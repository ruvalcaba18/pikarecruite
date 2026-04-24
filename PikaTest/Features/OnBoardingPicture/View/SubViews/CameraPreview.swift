//
//  CamerCoordinator.swift
//  PikaTest
//
//  Created by jael ruvalcaba on 23/04/26.
//

import Foundation
import AVFoundation
import UIKit

class CameraPreview: UIView {
    override class var layerClass: AnyClass {
        AVCaptureVideoPreviewLayer.self
    }
    
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        layer as! AVCaptureVideoPreviewLayer
    }
}
