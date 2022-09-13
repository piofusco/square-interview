//
//  SceneDelegate.swift
//  Contacts
//
//  Created by Michael Pace on 9/13/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let dispatchQueue = ContactsDispatchQueue()
        let contactAPI = ContactAPI(urlSession: URLSession.shared)
        let employeeListViewController = EmployeeListViewController(
            employeeAPI: contactAPI,
            dispatchQueue: dispatchQueue
        )
        let navigationController = UINavigationController(rootViewController: employeeListViewController)

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController
        self.window = window
        self.window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

