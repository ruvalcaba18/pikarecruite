import Foundation
import Combine
import SwiftUI

@MainActor
final class AppCoordinator: ObservableObject {
    @Published var path: NavigationPath
    
    public init() {
        self.path = NavigationPath()
    }
    
    func navigate(to route: AppRoute) {
        path.append(route)
    }
}
