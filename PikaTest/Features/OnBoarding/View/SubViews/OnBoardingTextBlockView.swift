//
//  OnBoardingTextBlock.swift
//  PikaTest
//
//  Created by jael ruvalcaba on 23/04/26.
//

import SwiftUI

struct OnBoardingTextBlockView: View {
    var body: some View {
        VStack(spacing: 8) {
            Text("YOUR AI SELF IS\nWAITING")
                .font(.telkaExtendedBlack(size: 38))
                .multilineTextAlignment(.center)
                .lineSpacing(-5)
                .foregroundStyle(.black)
            
            Text("Sign up or log in below")
                .font(.telkaRegular(size: 16))
                .foregroundStyle(Color.darkQuaternary)
        }
    }
}

#if targetEnvironment(simulator)
#Preview {
    OnBoardingTextBlockView()
}
#endif
