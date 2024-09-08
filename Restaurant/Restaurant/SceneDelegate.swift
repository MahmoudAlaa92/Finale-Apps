//
//  SceneDelegate.swift
//  Restaurant
//
//  Created by Mahmoud Alaa on 30/08/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var orderTabBarItem: UITabBarItem!
        
    @objc func updataOrderBadge(){
        let count = MenuController.shared.order.menuItems.count
        orderTabBarItem.badgeValue = count > 0 ? String(count) : nil
    }

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }
       
        // Handle badge icon of order tab bar
        NotificationCenter.default.addObserver(self, selector: #selector(updataOrderBadge), name: MenuController.orderUpdatedNotification, object: nil)
        
        orderTabBarItem = (window?.rootViewController as? UITabBarController)?.viewControllers?[1].tabBarItem
        
    }
    
    func stateRestorationActivity(for scene: UIScene) -> NSUserActivity? {
        //print("stateRestorationActivity")
        return MenuController.shared.userActivity
    }
    
    func scene(_ scene: UIScene, restoreInteractionStateWith stateRestorationActivity: NSUserActivity) {
       // print("restoreInteractionStateWith")
        if let restoreOrder = stateRestorationActivity.order{
            MenuController.shared.order = restoreOrder
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

