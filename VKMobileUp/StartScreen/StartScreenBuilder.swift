import UIKit

struct StartScreenBuilder {
    let router: StartScreenRouter
    
    init(router: StartScreenRouter) {
        self.router = router
    }
    
    func createViewController() -> UIViewController {
        let viewController = StartScreenViewController(presenter: StartScreenPresenter(view: nil, router: router))
        viewController.presenter.view = viewController
        return viewController
    }
}
