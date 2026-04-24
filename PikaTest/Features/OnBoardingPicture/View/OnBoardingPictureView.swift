//  OnBoardingPictureView.swift
//  PikaTest
//  Created by jael ruvalcaba on 23/04/26.

import SwiftUI
import PhotosUI

struct OnBoardingPictureView: View {
    @StateObject private var viewModel = OnBoardingPictureViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            CameraView(session: viewModel.session)
            
            VStack {
                Spacer()
                bottomControls
            }
        }
        .task {
            await viewModel.startCamera()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Circle().fill(.black.opacity(0.3)))
                }
            }
            
            ToolbarItem(placement: .principal) {
                Capsule()
                    .fill(Color.white.opacity(0.3))
                    .frame(width: 80, height: 4)
                    .overlay(
                        Capsule()
                            .fill(Color.white)
                            .frame(width: 40, height: 4),
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
        HStack(spacing: 60) {
            galleryButton
            
            Button(action: { viewModel.takePhoto() }) {
                Circle()
                    .fill(.white)
                    .frame(width: 70, height: 70)
                    .overlay(Circle().stroke(.white, lineWidth: 2).frame(width: 82, height: 82))
            }
            
            Button(action: { viewModel.toggleCamera() }) {
                Image(systemName: "camera.rotate")
                    .foregroundColor(.white)
                    .font(.title2)
            }
        }
        .padding(.bottom, 50)
    }
    
    var galleryButton: some View {
        PhotosPicker(
            selection: $viewModel.imageSelection,
            matching: .images,
            photoLibrary: .shared()
        ) {
            Image(systemName: "photo")
                .foregroundColor(.white)
                .font(.title2)
        }
    }
}

#if targetEnvironment(simulator)
#Preview {
    OnBoardingPictureView()
}
#endif
