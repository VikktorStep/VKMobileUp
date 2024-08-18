
import UIKit
import WebKit

final class WebViewController: UIViewController, WebViewProtocol {
    var presenter: WebPresenter!
    var webView: WKWebView!
    var tokenHandler: ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        webView = WKWebView(frame: self.view.bounds)
        webView.navigationDelegate = self
        self.view.addSubview(webView)

        presenter.loadWebPage()
    }
    
    func loadWebPage(with request: URLRequest) {
        print("Загружаем запрос: \(request.url?.absoluteString ?? "нет URL")")
        webView.load(request)
    }
    
    func handleToken(_ token: String) {
        tokenHandler?(token)
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        if let url = navigationResponse.response.url {
            presenter.handleNavigationResponse(url: url, decisionHandler: decisionHandler)
        } else {
            decisionHandler(.allow)
        }
    }
}

