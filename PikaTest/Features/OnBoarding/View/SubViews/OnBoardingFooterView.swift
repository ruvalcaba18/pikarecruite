import SwiftUI

struct OnBoardingFooterView: View {
    private enum Constants {
        static let orText = "Or continue with"
        static let agreementTextPrefix = "Sign in to agree to "
        static let termsText = "terms"
        static let stackSpacing: CGFloat = 24.0
        static let separatorSpacing: CGFloat = 14.0
        static let buttonSpacing: CGFloat = 5.0
        static let topPadding: CGFloat = 20.0
        static let horizontalPadding: CGFloat = 10.0
    }
    
    var body: some View {
        VStack(spacing: Constants.stackSpacing) {
            HStack(spacing: Constants.separatorSpacing) {
                line
                Text(Constants.orText)
                    .font(.telkaRegular(size: AppConstants.FontSizes.bodyStandard))
                    .foregroundStyle(Color.darkQuaternary)
                line
            }
            .padding(.horizontal, Constants.horizontalPadding)

            HStack(spacing: Constants.buttonSpacing) {
                PrimaryButtonView(icon: "applelogo") {}
                PrimaryButtonView(icon: "envelope.fill") {}
            }
            
            Text("\(Constants.agreementTextPrefix)\(Text(Constants.termsText).foregroundStyle(Color.darkQuaternary).bold())")
                .font(.telkaRegular(size: AppConstants.FontSizes.captionSmall))
                .foregroundStyle(Color.darkQuaternary)
                .padding(.top, Constants.topPadding)
        }
    }
}

private extension OnBoardingFooterView {
    var line: some View {
        Rectangle()
            .fill(Color.darkQuaternary.opacity(0.3))
            .frame(height: 1)
            .frame(maxWidth: .infinity)
    }
    
}

#if targetEnvironment(simulator)
#Preview {
    OnBoardingFooterView()
}
#endif
