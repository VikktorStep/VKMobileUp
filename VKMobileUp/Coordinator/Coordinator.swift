
import UIKit

protocol Example1RouterProtocol {
    func open()
    func openWebView()
}

public class Example1Router: Example1RouterProtocol {

    // MARK: - Public Outlets
    
    public var navigationController: UINavigationController? {
        didSet {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }
    
    // MARK: - Private Properties
    
    private lazy var builder = Builder(router: self)

    // MARK: - Public Init
    
    public init( navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    // MARK: - Public Methods
    
    public func openDetailsScreen() {
        print("Details screen opened")
    }
    
    public func start() -> UINavigationController {
        let viewController = builder.createViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        self.navigationController = navigationController
        return navigationController
    }
    
    func openWebView() {
        let router = WebRouter(navigationController: navigationController)
        router.start()
    }

    public func open() {
        let viewController = SegmentController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

struct Builder {
    let router: Example1Router
    
    init(router: Example1Router) {
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
    let router: Example1RouterProtocol
    
    init(router: Example1RouterProtocol) {
        self.router = router
    }
    
    func didTapButton() {
        router.openWebView()
    }
}
