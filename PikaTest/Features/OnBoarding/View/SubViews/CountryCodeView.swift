//
//  CountryCodeView.swift
//  PikaTest
//
//  Created by jael ruvalcaba on 23/04/26.
//

import SwiftUI

struct CountryCodeView: View {
    private enum Constants {
        static let emoji = "🇺🇸"
        static let code = "+1"
        static let stackSpacing: CGFloat = 4.0
        static let horizontalPadding: CGFloat = 12.0
    }
    
    var body: some View {
        HStack(spacing: Constants.stackSpacing) {
            Text(Constants.emoji)
            Text(Constants.code)
                .font(.telkaRegular(size: AppConstants.FontSizes.bodyStandard))
                .foregroundStyle(Color.darkQuaternary)
        }
        .padding(.horizontal, Constants.horizontalPadding)
        .frame(height: AppConstants.Layout.inputHeight)
        .background(Color.white.opacity(0.1))
    }
}

#if targetEnvironment(simulator)
#Preview {
    CountryCodeView()
}
#endif
