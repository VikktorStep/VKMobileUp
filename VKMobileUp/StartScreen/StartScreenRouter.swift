
import UIKit

protocol StartScreenProtocol {
    func openWebView()
    func start() -> UINavigationController
    func navigateToMainScreen() -> UINavigationController
}

protocol StartScreenViewProtocol: AnyObject {
    
}

final class StartScreenRouter: StartScreenProtocol {
    var navigationController: UINavigationController?
    private lazy var builder = StartScreenBuilder(router: self)

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func start() -> UINavigationController {
        print("Router: Starting navigation...")
        let viewController = builder.createViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        self.navigationController = navigationController
        setRootViewController(navigationController)
        return navigationController
    }
    
    func openWebView() {
        guard let navigationController = self.navigationController else {
            print("NavigationController отсутствует")
            return
        }
        
        print("Router: Opening WebView...")
        let router = WebRouter(navigationController: navigationController)
        router.start()
    }

    func navigateToMainScreen() -> UINavigationController {
        print("Router: Navigating to main screen...")
        let segmentedController = SegmentedController()
        let navigationController = UINavigationController(rootViewController: segmentedController)
        self.navigationController = navigationController
        setRootViewController(navigationController)
        return navigationController
    }

    private func setRootViewController(_ navigationController: UINavigationController) {
        guard let window = UIApplication.shared.windows.first else { return }
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
