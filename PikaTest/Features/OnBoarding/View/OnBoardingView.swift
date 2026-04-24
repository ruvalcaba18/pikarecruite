import SwiftUI

struct OnBoardingView: View {
    @StateObject private var viewModel = OnBoardingViewModel()
    @ObservedObject private var coordinator: AppCoordinator
    
    public init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        ZStack {
            OnBoardingHeroView(viewModel: viewModel)
                .allowsHitTesting(false)
            
            VStack(spacing: 12) {
                Spacer()
                
                OnBoardingTextBlockView()
                
                PhoneInputView(phoneNumber: $viewModel.phoneNumber)
                
                PrimaryButtonView(title: "Continue") {
                    
                    if !viewModel.phoneNumber.isEmpty {
                        print("This is executed correctly")
                        coordinator.navigate(to: .onBoardingPicture)
                    }
                }
                
                OnBoardingFooterView()
            }
           
        }
    }
}

#if targetEnvironment(simulator)
#Preview {
    OnBoardingView(coordinator: .init())
}
#endif
