import SwiftUI

@main
struct PikaTestApp: App {
    
    @StateObject private var coordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                OnBoardingView(coordinator: coordinator)
                    .navigationDestination(for: AppRoute.self) { destination in
                        PikaRouteView(destination: destination, coordinator: coordinator)
                    }
            }
        }
    }
}
