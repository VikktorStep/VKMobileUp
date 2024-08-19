
import UIKit
import WebKit

final class WebPresenter {
    weak var view: WebViewProtocol?
    let router: WebRouterProtocol
    let authModel: WebAuthModel
    
    init(view: WebViewProtocol, router: WebRouterProtocol, authModel: WebAuthModel) {
        self.view = view
        self.router = router
        self.authModel = authModel
    }
    
    func loadWebPage() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "52149058"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "scope", value: "video"),
            URLQueryItem(name: "response_type", value: "token"),
        ]
        
        if let url = urlComponents.url {
            let request = URLRequest(url: url)
            print("Загружаем URL: \(url.absoluteString)")
            view?.loadWebPage(with: request)
        } else {
            print("Ошибка формирования URL")
        }
    }
    
    func handleNavigationResponse(url: URL, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment.components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce(into: [String: String]()) { dict, param in
                if param.count == 2 {
                    dict[param[0]] = param[1]
                }
            }
        
        if let accessToken = params["access_token"] {
            authModel.saveToken(accessToken)
            
            DispatchQueue.main.async {
                self.router.dismiss()
            }
        }
        
        decisionHandler(.cancel)
    }
}
