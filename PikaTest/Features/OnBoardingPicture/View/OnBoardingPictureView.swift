//  OnBoardingPictureView.swift
//  PikaTest
//  Created by jael ruvalcaba on 23/04/26.

import SwiftUI
import PhotosUI

struct OnBoardingPictureView: View {
    @StateObject private var viewModel = OnBoardingPictureViewModel()
    @Environment(\.dismiss) var dismiss
    @ObservedObject private var coordinator: AppCoordinator
    
    private enum Constants {
        static let backButtonIcon = "chevron.left"
        static let rotateCameraIcon = "camera.rotate"
        static let galleryIcon = "photo"
        static let nextIcon = "chevron.right"
        static let backButtonSize: CGFloat = 18.0
        static let backButtonPadding: CGFloat = 8.0
        static let progressCapsuleWidth: CGFloat = 80.0
        static let progressCapsuleHeight: CGFloat = 4.0
        static let activeProgressWidth: CGFloat = 40.0
        static let controlsSpacing: CGFloat = 60.0
    }
    
    public init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        ZStack {
            if let image = viewModel.capturedImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
            } else {
                CameraView(session: viewModel.session)
                    .ignoresSafeArea()
            }
            
            VStack {
                Spacer()
                bottomControls
            }
        }
        .onAppear {
            viewModel.startCamera()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: Constants.backButtonIcon)
                        .font(.system(size: Constants.backButtonSize, weight: .bold))
                        .foregroundColor(.white)
                        .padding(Constants.backButtonPadding)
                        .background(Circle().fill(.black.opacity(0.3)))
                }
            }
            
            ToolbarItem(placement: .principal) {
                Capsule()
                    .fill(Color.white.opacity(0.3))
                    .frame(width: Constants.progressCapsuleWidth, height: Constants.progressCapsuleHeight)
                    .overlay(
                        Capsule()
                            .fill(Color.white)
                            .frame(width: Constants.activeProgressWidth, height: Constants.progressCapsuleHeight),
                        alignment: .leading
                    )
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - Componentes de UI
private extension OnBoardingPictureView {
    
    var bottomControls: some View {
        HStack(spacing: Constants.controlsSpacing) {
            galleryButton
            
            Button(action: { viewModel.takePhoto() }) {
                Circle()
                    .fill(.white)
                    .frame(width: AppConstants.Layout.shutterInnerSize, height: AppConstants.Layout.shutterInnerSize)
                    .overlay(Circle().stroke(.white, lineWidth: 2).frame(width: AppConstants.Layout.shutterOuterSize, height: AppConstants.Layout.shutterOuterSize))
            }
            
            Button(action: { viewModel.toggleCamera() }) {
                Image(systemName: Constants.rotateCameraIcon)
                    .foregroundColor(.white)
                    .font(.title2)
            }
            
            if viewModel.capturedImage != nil {
                Button(action: {
                    coordinator.navigate(to: .recordVoice)
                }) {
                    Image(systemName: Constants.nextIcon)
                        .foregroundColor(.white)
                        .font(.title2)
                }.onAppear {
                    viewModel.stopCamera()
                }
            }
        }
        .padding(.bottom, AppConstants.Spacing.bottomPaddingLarge)
    }
    
    var galleryButton: some View {
        PhotosPicker(
            selection: $viewModel.imageSelection,
            matching: .images,
            photoLibrary: .shared()
        ) {
            Image(systemName: Constants.galleryIcon)
                .foregroundColor(.white)
                .font(.title2)
        }
    }
}

#if targetEnvironment(simulator)
#Preview {
    OnBoardingPictureView(coordinator: .init())
}
#endif
