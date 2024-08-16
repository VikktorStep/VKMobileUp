//
//  AuthWebViewController.swift
//  VKMobileUp
//
//  Created by Mac on 15.08.2024.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var router: WebRouter
    var presenter: WebPresenter
    
    init(router: WebRouter, presenter: WebPresenter) {
        self.router = router
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var tokenHandler: ((String) -> Void)?
    
    private var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView()
        webView.navigationDelegate = self
        view.addSubview(webView)
        webView.frame = view.bounds
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "52149058"),  // ваш client_id
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "response_type", value: "token"),
        ]
        
        if let url = urlComponents.url {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
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
            tokenHandler?(accessToken)
            print(accessToken)
            
            router.dismiss()
        }
        //TODO: Refactor
        
        decisionHandler(.cancel)
    }
}
