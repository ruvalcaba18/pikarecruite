//  OnBoardingPictureViewModel.swift
//  PikaTest
//  Created by jael ruvalcaba on 23/04/26.
import Foundation
import Combine
import AVFoundation
import UIKit
import PhotosUI
import _PhotosUI_SwiftUI

final class OnBoardingPictureViewModel: NSObject, ObservableObject {
    @Published var capturedImage: UIImage?
    @Published var isFrontCamera = true
    @Published var isSessionRunning = false
    @Published var imageSelection: PhotosPickerItem? {
        didSet {
            if let imageSelection {
                Task {
                    do {
                        if let data = try await imageSelection.loadTransferable(type: Data.self),
                           let image = UIImage(data: data) {
                            await MainActor.run {
                                self.capturedImage = self.fixOrientation(image)
                                self.stopCamera()
                            }
                        }
                    } catch {
                        print("Error loading gallery image: \(error)")
                    }
                }
            }
        }
    }
    
    private let cameraService = CameraService()
    
    var session: AVCaptureSession {
        cameraService.session
    }
    
    func startCamera() {
        Task {
            let granted = await cameraService.checkPermissions()
            guard granted else { return }
            
            do {
                try cameraService.setupSession(isFront: self.isFrontCamera)
                
                DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                    self?.cameraService.start()
                    DispatchQueue.main.async {
                        self?.isSessionRunning = true
                    }
                }
            } catch {
                print("Failed to setup camera session: \(error)")
            }
        }
    }
    
    func stopCamera() {
        cameraService.stop()
        isSessionRunning = false
    }
    
    func toggleCamera() {
        isFrontCamera.toggle()
        startCamera()
    }
    
    func takePhoto() {
        cameraService.capturePhoto(delegate: self)
    }
    
    private func fixOrientation(_ image: UIImage) -> UIImage {
        if image.imageOrientation == .up { return image }
        
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        image.draw(in: CGRect(origin: .zero, size: image.size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return normalizedImage ?? image
    }
}

extension OnBoardingPictureViewModel: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print("Error capturing photo: \(error)")
            return
        }
        
        guard let data = photo.fileDataRepresentation(),
              let image = UIImage(data: data) else {
            return
        }
        
        DispatchQueue.main.async {
            self.capturedImage = image
        }
    }
}

private extension OnBoardingPictureViewModel {
    
    func loadTransferable(from item: PhotosPickerItem) async {
        do {
            if let data = try await item.loadTransferable(type: Data.self),
               let image = UIImage(data: data) {
                
                await MainActor.run {
                    self.capturedImage = image
                }
            }
        } catch {
            print("Error loading image: \(error)")
        }
    }
}

