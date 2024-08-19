import UIKit

final class StartScreenRouter: StartScreenProtocol {
    var navigationController: UINavigationController?

    private lazy var builder = StartScreenBuilder(router: self)

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func start() -> UINavigationController {
        let viewController = builder.createViewController()
        let navigationController = UINavigationController(rootViewController: viewController)

        self.navigationController = navigationController
        setRootViewController(navigationController)

        return navigationController
    }
    
    func openWebView() {
        guard let navigationController = self.navigationController else { return }

        let router = WebRouter(navigationController: navigationController)
        router.start()
    }

    func navigateToMainScreen() -> UINavigationController {
        let segmentedController = SegmentedViewController(router: self)
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

protocol StartScreenProtocol {
    func openWebView()
    func start() -> UINavigationController
    func navigateToMainScreen() -> UINavigationController
}

protocol StartScreenViewProtocol: AnyObject {}
