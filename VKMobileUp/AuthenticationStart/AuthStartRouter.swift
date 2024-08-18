
import UIKit

class AuthStartRouter: AuthStartProtocol {
    var navigationController: UINavigationController? {
        didSet {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }
        
    private lazy var builder = Builder(router: self)
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func openDetailsScreen() {
        print("Details screen opened")
    }
    
    func start() -> UINavigationController {
        let viewController = builder.createViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        self.navigationController = navigationController
        return navigationController
    }
    
    func openWebView() {
        let router = WebRouter(navigationController: navigationController)
        router.start()
    }

    func open() {
        let viewController = SegmentController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

struct Builder {
    let router: AuthStartRouter
    
    init(router: AuthStartRouter) {
        self.router = router
    }
    
    func createViewController() -> UIViewController {
        let presenter = Presenter(router: router)
        let viewController = AuthViewController(router: router, presenter: presenter)
        presenter.viewController = viewController
        return viewController
    }
}


class Presenter {
    weak var viewController: AuthViewController?
    let router: AuthStartProtocol
    
    init(router: AuthStartProtocol) {
        self.router = router
    }
    
    func didTapButton() {
        router.openWebView()
    }
}
