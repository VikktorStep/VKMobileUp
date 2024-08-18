
import UIKit
import WebKit

class WebRouter: WebRouterProtocol {
    
    var navigationController: UINavigationController?
    
    private lazy var builder = WebBuilder(router: self)
    
    init( navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func openDetailsScreen() {
        print("Details screen opened")
    }
    
    func start() {
        let viewController = builder.createViewController()
        viewController.modalPresentationStyle = .pageSheet
        self.navigationController?.present(viewController, animated: true, completion: nil)
    }
    
    func dismiss() {
        self.navigationController?.dismiss(animated: true, completion: { [weak self] in
            self?.open()
        })
    }
    
    func open() {
        let viewController = SegmentController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
