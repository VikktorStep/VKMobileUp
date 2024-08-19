import UIKit

struct WebBuilder {
    let router: WebRouter
    
    init(router: WebRouter) {
        self.router = router
    }
    
    func createViewController() -> UIViewController {
        let viewController = WebViewController()
        let authModel = WebAuthModel()
        let webPresenter = WebPresenter(view: viewController, router: router, authModel: authModel)
        viewController.presenter = webPresenter
        
        return viewController
    }
}
