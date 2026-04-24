//  PikaRouteView.swift
//  PikaTest
//  Created by jael ruvalcaba on 23/04/26.
import SwiftUI

@MainActor
struct PikaRouteView: View {
    let destination: AppRoute
    let coordinator: AppCoordinator
    
    public init(
        destination: AppRoute,
        coordinator: AppCoordinator
    ) {
        self.destination = destination
        self.coordinator = coordinator
    }
    
    @ViewBuilder
    var body: some View {
        switch destination {
        case .onBoardingPicture:
            OnBoardingPictureView(coordinator: coordinator)
        case .recordVoice:
            VoiceRecordingView(coordinator: coordinator)
        case .success :
            IAFinalCardView(coordinator: coordinator)
        }
    }
}
