//
//  SceneDelegate.swift
//  Weather
//
//  Created by Владимир on 12.04.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    var settings = Settings()
    var storage = Storage()
    var network = Network()
    var location = Location()
    
    var homeViewModel: HomeViewModelProtocol?

    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
    
        storage.featch { response in
            switch response {
            case .success(let result):
                self.settings = result
            case .failure(let error):
                self.settings = Settings()
                print(error)
            }
            
            DispatchQueue.main.sync {
                self.homeViewModel = HomeViewModel(settings: self.settings, storage: self.storage, network: self.network, location: self.location)
                if let viewModel = self.homeViewModel {
                    let homeVC = HomeViewController(viewModel: viewModel)
                    let window = UIWindow(windowScene: windowScene)
                    window.rootViewController = homeVC
                    self.window = window
                    window.makeKeyAndVisible()
                }
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) { }
    func sceneDidBecomeActive(_ scene: UIScene) { }
    func sceneWillResignActive(_ scene: UIScene) { }
    func sceneWillEnterForeground(_ scene: UIScene) { }
    func sceneDidEnterBackground(_ scene: UIScene) { }
}

