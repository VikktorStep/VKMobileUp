//
//  SceneDelegate.swift
//  VKMobileUp
//
//  Created by Mac on 14.08.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Убедитесь, что сцена имеет тип UIWindowScene
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Создаем UIWindow с использованием windowScene
        window = UIWindow(windowScene: windowScene)
        
        // Создаем начальный AuthViewController
        let authViewController = AuthViewController()
        
        // Оборачиваем его в UINavigationController для навигации
        let navigationController = UINavigationController(rootViewController: authViewController)
        
        // Устанавливаем navigationController как rootViewController
        window?.rootViewController = navigationController
        
        // Делаем окно видимым
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Этот метод вызывается, когда сцена отключается от системы
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Этот метод вызывается, когда сцена становится активной
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Этот метод вызывается, когда сцена переходит в неактивное состояние
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Этот метод вызывается при переходе сцены из фона на передний план
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Этот метод вызывается при переходе сцены в фон
    }
}
