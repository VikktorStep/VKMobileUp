import UIKit
import WebKit

final class WebViewController: UIViewController, WebViewProtocol {
    var presenter: WebPresenter!
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        webView = WKWebView(frame: self.view.bounds)
        webView.navigationDelegate = self
        self.view.addSubview(webView)

        presenter.loadWebPage()
    }
    
    func loadWebPage(with request: URLRequest) {
        webView.load(request)
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        if let url = navigationResponse.response.url {
            presenter.handleNavigationResponse(url: url, decisionHandler: decisionHandler)
        } else {
            decisionHandler(.allow)
        }
    }
}
