//
//  SceneDelegate.swift
//  BundleCaseStudy
//
//  Created by Sadık Kemal Sarı on 11.12.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let coordinator = PackagesCoordinator()
        let viewController = coordinator.prepareScreen()
        let navigationViewController = UINavigationController(rootViewController: viewController)

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationViewController
        window?.makeKeyAndVisible()
    }
}
