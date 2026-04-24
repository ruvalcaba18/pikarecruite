//
//  PhoneInputView.swift
//  PikaTest
//
//  Created by jael ruvalcaba on 23/04/26.
//

import SwiftUI

struct PhoneInputView: View {
    @Binding var phoneNumber: String
    
    private enum Constants {
        static let promptText = "Phone number"
        static let stackSpacing: CGFloat = 12.0
    }
    
    var body: some View {
        HStack(spacing: Constants.stackSpacing) {
            CountryCodeView()
            
            Divider()
                .frame(height: AppConstants.Layout.dividerHeight)
            
            TextField("", text: $phoneNumber, prompt: Text(Constants.promptText).foregroundColor(.darkQuaternary))
                .keyboardType(.phonePad)
                .font(.telkaRegular(size: AppConstants.FontSizes.bodyStandard))
                .foregroundColor(.black)
        }
        .padding(.horizontal, AppConstants.Layout.standardCornerRadius)
        .frame(height: AppConstants.Layout.inputHeight)
        .background(Color.white.opacity(0.9), in: RoundedRectangle(cornerRadius: AppConstants.Layout.standardCornerRadius))
        .clipShape(RoundedRectangle(cornerRadius: AppConstants.Layout.standardCornerRadius))
        .contentShape(RoundedRectangle(cornerRadius: AppConstants.Layout.standardCornerRadius))
        .overlay(
            RoundedRectangle(cornerRadius: AppConstants.Layout.standardCornerRadius)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
        .padding(.horizontal, AppConstants.Spacing.screenHorizontalPadding)
    }
}


#if targetEnvironment(simulator)
#Preview {
    PhoneInputView(
        phoneNumber: .constant(
            "+1-23534-34634"
        )
    )
}
#endif
