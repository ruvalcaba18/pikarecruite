//
//  CameraError.swift
//  PikaTest
//
//  Created by jael ruvalcaba on 23/04/26.
//

import Foundation

enum CameraError: Error {
    case deviceUnavailable
    case unauthorized
    case sessionSetupFailed
}
