//
//  SceneDelegate.swift
//  GameStore_MatheusTorres_Teodoro
//
//  Created by Matheus Torres on 19/09/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        self.loadBaseController()
    }
    
    func loadBaseController() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let window = self.window else { return }
        window.makeKeyAndVisible()
        if UserDefaults.standard.bool(forKey: "isLogged") == false {
            let mainVC: MainViewController = storyboard.instantiateViewController(identifier: "MainViewController") as! MainViewController
            let mainVCNavigator = UINavigationController(rootViewController: mainVC)
            mainVCNavigator.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "lightColor")!]
            self.window?.rootViewController = mainVCNavigator
        } else {
            let gameListVC: GameListViewController = storyboard.instantiateViewController(identifier: "GameListViewController") as! GameListViewController
            let gameListVCNavigator = UINavigationController(rootViewController: gameListVC)
            gameListVCNavigator.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "neutralColor")!]
            self.window?.rootViewController = gameListVCNavigator
        }
        self.window?.makeKeyAndVisible()
    }
}

