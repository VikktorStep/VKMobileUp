
import UIKit

final class StartScreenPresenter {
    
    weak var view: StartScreenViewProtocol?
    let router: StartScreenProtocol

    init(view: StartScreenViewProtocol?, router: StartScreenProtocol) {
        self.view = view
        self.router = router
    }
        
    func didTapButton() {
        print("Presenter: Button tapped!")
        router.openWebView()
    }
}

