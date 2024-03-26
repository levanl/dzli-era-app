//
//  TabController.swift
//  DzliEra
//
//  Created by Levan Loladze on 20.01.24.
//

import UIKit
import SwiftUI

// MARK: - TabController
final class TabController: UITabBarController {
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
        self.tabBar.tintColor = UIColor(AppColors.secondaryRed)
        self.tabBar.frame.size.height = 60
        self.tabBar.layer.cornerRadius = 10
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.tabBar.clipsToBounds = true
    }
    
    // MARK: - Private Methods
    private func setupTabs() {
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        tabBarAppearance.backgroundColor = UIColor(AppColors.secondaryBackgroundColor)
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        
        let homeView = UIHostingController(rootView: HomeView())
        
        let home = self.createNav(with: "Home", and: UIImage(systemName: "house"), vc: homeView)
        let profile = self.createNav(with: "Workout", and: UIImage(systemName: "list.clipboard.fill"), vc: WorkoutViewController())
        let workout = self.createNav(with: "Profile", and: UIImage(systemName: "person.crop.circle"), vc: ProfileViewController())
        let foodTracker = self.createNav(with: "Food", and: UIImage(systemName: "fork.knife"), vc: FoodTrackerViewController())
        
        self.setViewControllers([home, profile, workout, foodTracker], animated: true)
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UIViewController {
        
        vc.tabBarItem.image = image
        
        return vc
    }
}


