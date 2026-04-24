import SwiftUI

struct OnBoardingFooterView: View {
    
    var body: some View {
        VStack(spacing: 24) {
            HStack(spacing: 14) {
                line
                Text("Or continue with")
                    .font(.telkaRegular(size: 16))
                    .foregroundStyle(Color.darkQuaternary)
                line
            }
            .padding(.horizontal, 10)

            HStack(spacing: 5) {
                PrimaryButtonView(icon: "applelogo") {
                    
                }
                
                PrimaryButtonView(icon: "envelope.fill") {
                    
                }
            }
            
            Text("Sign in to agree to \(Text("terms").foregroundStyle(Color.darkQuaternary).bold())")
                .font(.telkaRegular(size: 14))
                .foregroundStyle(Color.darkQuaternary)
                .padding(.top, 20)
                .frame(alignment: .bottom)
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
