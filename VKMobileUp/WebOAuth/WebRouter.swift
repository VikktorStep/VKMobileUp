import UIKit
import WebKit


final class WebRouter: WebRouterProtocol {
    var navigationController: UINavigationController?
    
    private lazy var builder = WebBuilder(router: self)
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = builder.createViewController()
        viewController.modalPresentationStyle = .pageSheet
        navigationController?.present(viewController, animated: true, completion: nil)
    }
    
    func dismiss() {
        self.navigationController?.dismiss(animated: true, completion: { [weak self] in
            self?.open()
        })
    }
    
    func open() {
        let viewController = SegmentedViewController(router: StartScreenRouter(navigationController: navigationController))
        navigationController?.pushViewController(viewController, animated: true)
    }

}


protocol WebViewProtocol: AnyObject {
    func loadWebPage(with request: URLRequest)
}

protocol WebRouterProtocol {
    func open()
    func dismiss()
    func start()
}
