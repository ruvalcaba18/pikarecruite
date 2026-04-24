//
//  OnBoardingHeroView.swift
//  PikaTest
//
//  Created by jael ruvalcaba on 23/04/26.
//

import SwiftUI

struct OnBoardingHeroView: View {
    let viewModel: OnBoardingViewModel
    
    var body: some View {
        ZStack {
            LoopingVideoPlayer(
                videoName: viewModel.onboardingVideoName,
                videoType: viewModel.onboardingVideoType
            )
        }
        .ignoresSafeArea()
    }
}

#if targetEnvironment(simulator)
#Preview {
    OnBoardingHeroView(viewModel: OnBoardingViewModel())
}
#endif
