//  PrimaryButtonView.swift
//  PikaTest
//  Created by jael ruvalcaba on 23/04/26.
import SwiftUI

struct PrimaryButtonView: View {
    let title: String?
    let icon: String?
    let action: () -> Void
    
    public init(
        title: String? = nil,
        icon: String? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            content
        }
        .padding(.horizontal, 24)
    }
}

private extension PrimaryButtonView {
    
    @ViewBuilder
     var content: some View {
        if let title = title, !title.isEmpty {
            Text(title)
                .font(.telkaMedium(size: AppConstants.FontSizes.bodyStandard))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .frame(height: AppConstants.Layout.buttonHeight)
                .background(Color.continueButtonBackground)
                .cornerRadius(AppConstants.Layout.standardCornerRadius)
                .contentShape(RoundedRectangle(cornerRadius: AppConstants.Layout.standardCornerRadius)) // Hace que todo el botón sea clickable
            
        } else if let icon = icon, !icon.isEmpty {
            Image(systemName: icon)
                .font(.system(size: 22))
                .foregroundColor(.black.opacity(0.8))
                .frame(width: 64, height: 64)
                .background(
                    Circle()
                        .fill(Color.black.opacity(0.05))
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1.5)
                )
            
        } else {
            EmptyView()
        }
    }
}

#if targetEnvironment(simulator)
#Preview("Title Button") {
    PrimaryButtonView(title: "Continue") {
        print("Tap")
    }
}

#Preview("Icon Button") {
    PrimaryButtonView(icon: "arrow.right") {
        print("Tap")
    }
}
#endif
