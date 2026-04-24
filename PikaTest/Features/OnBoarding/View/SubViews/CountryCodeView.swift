//
//  CountryCodeView.swift
//  PikaTest
//
//  Created by jael ruvalcaba on 23/04/26.
//

import SwiftUI

struct CountryCodeView: View {
    var body: some View {
        HStack(spacing: 4) {
            Text("🇺🇸")
            Text("+1")
                .font(.telkaRegular(size: 16))
                .foregroundStyle(Color.darkQuaternary)
        }
        .padding(.horizontal, 12)
        .frame(height: 56)
        .background(Color.white.opacity(0.1))
    }
}

#if targetEnvironment(simulator)
#Preview {
    CountryCodeView()
}
#endif
