//
//  OnBoardingViewModel.swift
//  PikaTest
//
//  Created by jael ruvalcaba on 23/04/26.
//

import Foundation
import Combine

@MainActor
final class OnBoardingViewModel: ObservableObject {
    
    let onboardingVideoName = "AppHeroVideo"
    let onboardingVideoType = "mp4"
    
    @Published var phoneNumber = ""
}
