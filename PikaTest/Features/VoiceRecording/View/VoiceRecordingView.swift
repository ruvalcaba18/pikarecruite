//  VoiceRecordingView.swift
//  PikaTest
//  Created by jael ruvalcaba on 23/04/26.
import SwiftUI

struct VoiceRecordingView: View {
    @StateObject private var viewModel = VoiceRecordingViewModel()
    @Environment(\.dismiss) var dismiss
    @ObservedObject private var coordinator: AppCoordinator
    
    public init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    private enum Constants {
        static let topPadding: CGFloat = 60.0
        static let headerSpacing: CGFloat = 12.0
        static let karaokeLineSpacing: CGFloat = 8.0
        static let textPadding: CGFloat = 30.0
        static let bottomPadding: CGFloat = 20.0
        static let backButtonSize: CGFloat = 18.0
        static let headerLineSpacing: CGFloat = -5.0
        static let strokeWidth: CGFloat = 4.0
        
        static let headerTitle = "MAKE YOUR\n AI SELF SOUND \n LIKE YOU"
        static let headerSubtitle = "Read the text below to clone your \n voice and create an \n AI Self that talks like you. "
        static let recordingStatus = "Recording..."
        static let tapToRecordStatus = "Tap to record"
        static let backButtonIcon = "chevron.left"
    }
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: AppConstants.Spacing.stackSpacingStandard) {
                headerSection
                
                Spacer()
                
                paintingTextView
                    .padding(.horizontal, Constants.textPadding)
                
                Spacer()
                
                controlsArea
            }
            .padding(.top, Constants.topPadding)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: Constants.backButtonIcon)
                        .font(.system(size: Constants.backButtonSize, weight: .bold))
                        .foregroundColor(.black)
                }
            }
        }
    }
}

private extension VoiceRecordingView {
    
    var controlsArea: some View {
        VStack(spacing: 20) {
            if viewModel.state == .finished {
                HStack(spacing: 30) {
                    secondaryButton(icon: "arrow.clockwise") {
                        viewModel.resetRecording()
                    }
                    
                    mainActionButton
                    
                    secondaryButton(icon: "play.fill") {
                        viewModel.playRecording()
                    }
                }
            } else {
                mainActionButton
                
                if viewModel.state == .recording {
                    Text("Listening...")
                        .font(.telkaMedium(size: AppConstants.FontSizes.captionSmall))
                        .foregroundColor(.darkQuaternary)
                        .transition(.opacity)
                }
            }
        }
        .padding(.bottom, Constants.bottomPadding)
        .animation(.spring(), value: viewModel.state)
    }
    
    var mainActionButton: some View {
        Button(action: {
            switch viewModel.state {
            case .idle:
                Task {
                    await viewModel.startRecording()
                }
            case .recording:
                viewModel.stopRecording()
            case .finished:
                coordinator.navigate(to: .success)
            }
        }) {
            ZStack {
                Circle()
                    .fill(Color(red: 0.8, green: 0.8, blue: 1.0))
                    .frame(width: 90, height: 90)
                
                Group {
                    switch viewModel.state {
                    case .idle:
                        Circle()
                            .fill(Color.black)
                            .frame(width: 20, height: 20)
                    case .recording:
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color(red: 0.38, green: 0.4, blue: 0.95))
                            .frame(width: 30, height: 30)
                    case .finished:
                        Image(systemName: "checkmark")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
    
    func secondaryButton(icon: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Circle()
                .fill(Color.black.opacity(0.05))
                .frame(width: 60, height: 60)
                .overlay(
                    Image(systemName: icon)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.black)
                )
        }
    }
    
    var headerSection: some View {
        VStack(spacing: Constants.headerSpacing) {
            Text(Constants.headerTitle)
                .font(.telkaExtendedBlack(size: AppConstants.FontSizes.titleMedium))
                .multilineTextAlignment(.center)
                .lineSpacing(Constants.headerLineSpacing)
                .foregroundColor(.black)
            
            Text(Constants.headerSubtitle)
                .font(.telkaRegular(size: AppConstants.FontSizes.bodyStandard))
                .multilineTextAlignment(.center)
                .foregroundColor(Color.darkQuaternary)
        }
    }
    
    var paintingTextView: some View {
        Text(viewModel.attributedKaraokeText)
            .font(.telkaMedium(size: AppConstants.FontSizes.karaokeText))
            .multilineTextAlignment(.center)
            .lineSpacing(Constants.karaokeLineSpacing)
            .frame(maxWidth: .infinity)
            .animation(.easeInOut, value: viewModel.currentWordIndex)
    }
}

#if targetEnvironment(simulator)
#Preview {
    VoiceRecordingView()
}
#endif
