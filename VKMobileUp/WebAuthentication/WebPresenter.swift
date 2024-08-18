
import UIKit
import WebKit

class WebPresenter: NSObject, WKNavigationDelegate {
    weak var viewController: WebViewController?
    let router: WebRouterProtocol
    
    init(router: WebRouterProtocol) {
        self.router = router
    }

//    func authentication() {
//
//    }
}
