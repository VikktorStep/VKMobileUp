//
//  WebRouter.swift
//  VKMobileUp
//
//  Created by Виктор Степанов on 16.08.2024.
//

import UIKit
import WebKit

protocol WebRouterProtocol {
    func open()
}

public class WebRouter: WebRouterProtocol {
    
    // MARK: - Public Outlets
    
    public var navigationController: UINavigationController?
    
    // MARK: - Private Properties
    
    private lazy var builder = WebBuilder(router: self)
    
    // MARK: - Public Init
    
    public init( navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public Methods
    
    public func openDetailsScreen() {
        print("Details screen opened")
    }
    
    public func start() {
        let viewController = builder.createViewController()
        viewController.modalPresentationStyle = .pageSheet
        self.navigationController?.present(viewController, animated: true, completion: nil)
    }
    
    public func dismiss() {
        self.navigationController?.dismiss(animated: true, completion: { [weak self] in
            self?.open()
        })
    }
    
    public func open() {
        let viewController = SegmentController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

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
