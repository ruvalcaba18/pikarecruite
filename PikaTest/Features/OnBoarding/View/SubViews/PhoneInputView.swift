//
//  PhoneInputView.swift
//  PikaTest
//
//  Created by jael ruvalcaba on 23/04/26.
//

import SwiftUI

struct PhoneInputView: View {
    @Binding var phoneNumber: String
    
    var body: some View {
        HStack(spacing: 12) {
            CountryCodeView()
            
            Divider()
                .frame(height: 24)
            
            TextField("", text: $phoneNumber, prompt: Text("Phone number").foregroundColor(.darkQuaternary))
                .keyboardType(.phonePad)
                .font(.telkaRegular(size: 16))
                .foregroundColor(.black)
        }
        .padding(.horizontal, 16)
        .frame(height: 56)
        .background(Color.white.opacity(0.9), in: RoundedRectangle(cornerRadius: 16))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .contentShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
        .padding(.horizontal, 24)
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
