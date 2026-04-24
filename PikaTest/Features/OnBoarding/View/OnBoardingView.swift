import SwiftUI

struct OnBoardingView: View {
    @StateObject private var viewModel = OnBoardingViewModel()
    @ObservedObject private var coordinator: AppCoordinator
    @State private var isVideoPlaying = true
    
    private enum Constants {
        static let continueButtonTitle = "Continue"
        static let stackSpacing: CGFloat = 12.0
    }
    
    public init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        ZStack {
            OnBoardingHeroView(
                viewModel: viewModel,
                isPlaying: $isVideoPlaying
            )
            .allowsHitTesting(false)
            
            VStack(spacing: Constants.stackSpacing) {
                Spacer()
                
                OnBoardingTextBlockView()
                
                PhoneInputView(phoneNumber: $viewModel.phoneNumber)
                
                PrimaryButtonView(title: Constants.continueButtonTitle) {
                    if !viewModel.phoneNumber.isEmpty {
                        coordinator.navigate(to: .onBoardingPicture)
                    }
                }
                
                OnBoardingFooterView()
            }
        }
        .onAppear {
            isVideoPlaying = true
        }
        .onDisappear {
            isVideoPlaying = false
        }
    }
}

#if targetEnvironment(simulator)
#Preview {
    OnBoardingView(coordinator: .init())
}
#endif
