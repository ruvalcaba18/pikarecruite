//  OnBoardingTextBlock.swift
//  PikaTest
//  Created by jael ruvalcaba on 23/04/26.
import SwiftUI

struct OnBoardingTextBlockView: View {
    private enum Constants {
        static let titleText = "YOUR AI SELF IS\nWAITING"
        static let subtitleText = "Sign up or log in below"
        static let stackSpacing: CGFloat = 8.0
        static let lineSpacing: CGFloat = -5.0
    }
    
    var body: some View {
        VStack(spacing: Constants.stackSpacing) {
            Text(Constants.titleText)
                .font(.telkaExtendedBlack(size: AppConstants.FontSizes.titleLarge))
                .multilineTextAlignment(.center)
                .lineSpacing(Constants.lineSpacing)
                .foregroundStyle(.black)
            
            Text(Constants.subtitleText)
                .font(.telkaRegular(size: AppConstants.FontSizes.bodyStandard))
                .foregroundStyle(Color.darkQuaternary)
        }
    }
}

#if targetEnvironment(simulator)
#Preview {
    OnBoardingTextBlockView()
}
#endif
