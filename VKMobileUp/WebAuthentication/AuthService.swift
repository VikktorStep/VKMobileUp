//
//  AuthService.swift
//  VKMobileUp
//
//  Created by Виктор Степанов on 16.08.2024.
//

//import UIKit
//import WebKit
//
//class AuthService: NSObject {
//    
//    var tokenHandler: ((String) -> Void)?
//    let webView = WKWebView()
//    
//    func createUrl() {
//        var urlComponents: URLComponents {
//            var urlComponents = URLComponents()
//            urlComponents.scheme = "https"
//            urlComponents.host = "oauth.vk.com"
//            urlComponents.path = "/authorize"
//            
//            urlComponents.queryItems = [
//                URLQueryItem(name: "client_id", value: "52149058"),  // ваш client_id
//                URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
//                URLQueryItem(name: "display", value: "mobile"),
//                URLQueryItem(name: "response_type", value: "token"),
//            ]
//            
//            if let url = urlComponents.url {
//                let request = URLRequest(url: url)
//                webView.load(request)
//            }
//        }
//    }
//}
//
//extension AuthService: WKNavigationDelegate {
//    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
//        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
//            decisionHandler(.allow)
//            return
//        }
//        
//        let params = fragment.components(separatedBy: "&")
//            .map { $0.components(separatedBy: "=") }
//            .reduce(into: [String: String]()) { dict, param in
//                if param.count == 2 {
//                    dict[param[0]] = param[1]
//                }
//            }
//        
//        if let accessToken = params["access_token"] {
//            tokenHandler?(accessToken)
//            router.dismiss()
//            print(accessToken)
//        }
//        
//        //TODO: Refactor
//        
//        decisionHandler(.cancel)
//}
//
//
////extension WebViewController: WKNavigationDelegate {
////
////func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
////    guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
////        decisionHandler(.allow)
////        return
////    }
////    
////    let params = fragment.components(separatedBy: "&")
////        .map { $0.components(separatedBy: "=") }
////        .reduce(into: [String: String]()) { dict, param in
////            if param.count == 2 {
////                dict[param[0]] = param[1]
////            }
////        }
////    
////    if let accessToken = params["access_token"] {
////        tokenHandler?(accessToken)
////        print(accessToken)
////        
////        router.dismiss()
////    }
////    //TODO: Refactor
////    
////    decisionHandler(.cancel)
////}
////}
////
////}
