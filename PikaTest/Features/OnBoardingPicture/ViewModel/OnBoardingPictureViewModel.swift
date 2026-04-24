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
                loadTransferable(from: imageSelection)
            }
        }
    }
    
    private let cameraService = CameraService()
    
    var session: AVCaptureSession {
        cameraService.session
    }
    
    func startCamera() async {
        let granted = await cameraService.checkPermissions()
        
        guard granted else {
            print("Camera access denied")
            return
        }
        
        do {
            try cameraService.setupSession(isFront: self.isFrontCamera)
            cameraService.start()
            
            await MainActor.run {
                self.isSessionRunning = true
            }
            
        } catch {
            print("Failed to setup camera session: \(error)")
        }
    }
    
    func stopCamera() {
        cameraService.stop()
        isSessionRunning = false
    }
    
    func toggleCamera() {
        isFrontCamera.toggle()
        do {
            try cameraService.setupSession(isFront: self.isFrontCamera)
        } catch {
            print("Failed to switch camera: \(error)")
        }
    }
    
    func takePhoto() {
        cameraService.capturePhoto(delegate: self)
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
    
     func loadTransferable(from item: PhotosPickerItem) {
        Task {
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
}

