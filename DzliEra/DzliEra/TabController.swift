//
//  TabController.swift
//  DzliEra
//
//  Created by Levan Loladze on 20.01.24.
//

import UIKit

class TabController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
        self.tabBar.tintColor = .blue
        self.tabBar.frame.size.height = 60
        self.tabBar.layer.cornerRadius = 10
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.tabBar.clipsToBounds = true
    }
    
    private func setupTabs() {
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        tabBarAppearance.backgroundColor = UIColor(AppColors.gray)
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        
        let home = self.createNav(with: "Home", and: UIImage(systemName: "house"), vc: HomeViewController())
        let profile = self.createNav(with: "Workout", and: UIImage(systemName: "list.clipboard.fill"), vc: WorkoutViewController())
        let workout = self.createNav(with: "Profile", and: UIImage(systemName: "person.crop.circle"), vc: ProfileViewController())
        
        self.setViewControllers([home, profile, workout], animated: true)
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        
        nav.tabBarItem.image = image
        
        if let buttonImage = UIImage(named: "Button") {
            nav.viewControllers.first?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: buttonImage, style: .plain, target: nil, action: nil)
        }
        
        return nav
    }
}
