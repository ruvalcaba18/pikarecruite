import AVFoundation
import UIKit

final class CameraService: NSObject {
    let session = AVCaptureSession()
    private let photoOutput = AVCapturePhotoOutput()
    private var videoDeviceInput: AVCaptureDeviceInput?
    
    func checkPermissions() async -> Bool {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            return true
        case .notDetermined:
            return await AVCaptureDevice.requestAccess(for: .video)
        default:
          return false
        }
    }
    
    func setupSession(isFront: Bool) throws {
        session.beginConfiguration()
        session.sessionPreset = .photo
        
        session.inputs.forEach {
            session.removeInput($0)
        }
        
        session.outputs.forEach {
            session.removeOutput($0)
        }
        
        let position: AVCaptureDevice.Position = isFront ? .front : .back
        
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: position),
              let input = try? AVCaptureDeviceInput(device: device) else {
            session.commitConfiguration()
            throw CameraError.deviceUnavailable
        }
        
        if session.canAddInput(input) {
            session.addInput(input)
        }
        
        if session.canAddOutput(photoOutput) {
            session.addOutput(photoOutput)
        }
        
        session.commitConfiguration()
    }
    
    func start() {
        if !session.isRunning {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                self?.session.startRunning()
            }
        }
    }
    
    func stop() {
        if session.isRunning {
            session.stopRunning()
        }
    }
    
    func capturePhoto(delegate: AVCapturePhotoCaptureDelegate) {
        let settings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: settings, delegate: delegate)
    }
}
