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
        // Do any additional setup after loading the view.
    }
    
    private func setupTabs() {
        let home = self.createNav(with: "Home", and: UIImage(systemName: "house"), vc: HomeViewController())
        let profile = self.createNav(with: "Workout", and: UIImage(systemName: "list.clipboard.fill"), vc: WorkoutViewController())
        let workout = self.createNav(with: "Profile", and: UIImage(systemName: "person.crop.circle"), vc: ProfileViewController())
        
        self.setViewControllers([home, profile, workout], animated: true)
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        nav.viewControllers.first?.navigationItem.title = title + " Controller"
        if let buttonImage = UIImage(named: "Button") {
            nav.viewControllers.first?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: buttonImage, style: .plain, target: nil, action: nil)
        }
        
        return nav
    }
}
