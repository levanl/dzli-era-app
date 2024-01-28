//
//  ProfileViewController.swift
//  DzliEra
//
//  Created by Levan Loladze on 20.01.24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var user: AuthDataResultModel? = nil
    
    private let profileLabel: UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            do {
                self.user = try await AuthenticationManager.shared.getAuthenticatedUser()
                print("User loaded: \(self.user?.email ?? "Unknown email")")
                DispatchQueue.main.async {
                    self.profileLabel.text = self.user?.email
                }
            } catch {
                print("Error loading user: \(error)")
            }
        }
        
        view.backgroundColor = .black
        setupProfileLabel()
    }
    
    
    private func setupProfileLabel() {
        view.addSubview(profileLabel)
        
        //        profileLabel.text = user?.email
        
        NSLayoutConstraint.activate([
            profileLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            profileLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            profileLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    
    
}
