//
//  WebBuilder.swift
//  VKMobileUp
//
//  Created by Виктор Степанов on 16.08.2024.
//

import UIKit

struct WebBuilder {
    let router: WebRouter
    
    init(router: WebRouter) {
        self.router = router
    }
    
    func createViewController() -> UIViewController {
        let webPresenter = WebPresenter(router: router)
        let viewController = WebViewController(router: router , presenter: webPresenter)
        webPresenter.viewController = viewController
        return viewController
    }
}
