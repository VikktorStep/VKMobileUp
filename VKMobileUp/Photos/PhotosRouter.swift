//
//  PhotosRouter.swift
//  VKMobileUp
//
//  Created by Виктор Степанов on 16.08.2024.
//

import UIKit

protocol PhotoRouterProtocol {
    func openDetailsScreen()
}

class PhotosRouter: PhotoRouterProtocol {
    
    var navigationController: UINavigationController? {
        didSet {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }
        
    private lazy var builder = PhotosBuilder(router: self)
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func openDetailsScreen() {
        print("Details screen opened")
    }
    
    func start() -> UINavigationController {
        let viewController = builder.createViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        self.navigationController = navigationController
        return navigationController
    }
    
    func openWebView() {
        let router = WebRouter(navigationController: navigationController)
        router.start()
    }

    func open() {
        let viewController = SegmentController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

struct PhotosBuilder {
    let router: PhotosRouter
    
    init(router: PhotosRouter) {
        self.router = router
    }
    
    func createViewController() -> UIViewController {
        let presenter = PhotosPresenter(router: router, service: PhotosService())
        let viewController = PhotosVC(router: router, presenter: presenter)
        presenter.viewController = viewController
        return viewController
    }
}

class PhotosPresenter {
    weak var viewController: PhotosVC?
    let router: PhotoRouterProtocol
    let service: PhotosServiceProtocol
    
    var errorMessage: String?
    
    init(router: PhotoRouterProtocol, service: PhotosServiceProtocol) {
        self.router = router
        self.service = service
    }
    
    func fetchPhotos() async {
        do {
            let photosArray = try await service.fetchPhotos()
            print(photosArray)
        } catch {
            guard let error = error as? PhotosAPIErrors else { return }
            self.errorMessage = error.customDescription
            print(errorMessage ?? "unknown error")
        }
    }
}
