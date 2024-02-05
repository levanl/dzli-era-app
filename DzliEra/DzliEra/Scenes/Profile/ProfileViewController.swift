//
//  ProfileViewController.swift
//  DzliEra
//
//  Created by Levan Loladze on 20.01.24.
//

import UIKit
import SwiftUI


class ProfileViewController: UIViewController {
    
    private var user: DBUser? = nil
    
    private let profileLabel: UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let profileStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private let statisticsButton: UIButton = {
        let button = UIButton()
        let list = UIImage(systemName: "chart.bar", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold))?.withTintColor(.blue, renderingMode: .alwaysOriginal)
        button.setImage(list, for: .normal)
        button.setTitle("  Statistics", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(AppColors.gray)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        button.layer.cornerRadius = 6
        return button
    }()
    
    private let exerciseLibraryButton: UIButton = {
        let button = UIButton()
        let magnifyingglass = UIImage(systemName: "book.closed.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold))?.withTintColor(.blue, renderingMode: .alwaysOriginal)
        button.setImage(magnifyingglass, for: .normal)
        button.setTitle("  Exercises", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(AppColors.gray)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        button.layer.cornerRadius = 6
        return button
    }()
    
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    private let foodButton: UIButton = {
        let button = UIButton()
        let list = UIImage(systemName: "fork.knife", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold))?.withTintColor(.blue, renderingMode: .alwaysOriginal)
        button.setImage(list, for: .normal)
        button.setTitle("  Nutrition", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(AppColors.gray)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        button.layer.cornerRadius = 6
        return button
    }()
    
    private let calendarButton: UIButton = {
        let button = UIButton()
        let magnifyingglass = UIImage(systemName: "calendar", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold))?.withTintColor(.blue, renderingMode: .alwaysOriginal)
        button.setImage(magnifyingglass, for: .normal)
        button.setTitle("  Calendar", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(AppColors.gray)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        button.layer.cornerRadius = 6
        return button
    }()
    
    private let secondaryInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            do {
                let authDataResult = try await AuthenticationManager.shared.getAuthenticatedUser()
                self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
                print("User loaded: \(self.user?.email ?? "Unknown email")")
                DispatchQueue.main.async {
                    self.profileLabel.text = self.user?.email
                    self.loadProfileImage()
                }
            } catch {
                print("Error loading user: \(error)")
            }
        }
        
        view.backgroundColor = .black
        setupProfileStackView()
        setupInfoStackViews()
    }
    
    
    private func setupProfileStackView() {
        
        view.addSubview(profileStackView)
        
        profileStackView.addArrangedSubview(profileImageView)
        profileStackView.addArrangedSubview(profileLabel)
        
        NSLayoutConstraint.activate([
            profileStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            profileStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            profileStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            profileImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 70),
            profileImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 70)
        ])
        
    }
    
    private func setupInfoStackViews() {
        view.addSubview(infoStackView)
        
        infoStackView.addArrangedSubview(statisticsButton)
        statisticsButton.addTarget(self, action: #selector(statisticsButtonTapped), for: .touchUpInside)
        
        infoStackView.addArrangedSubview(exerciseLibraryButton)
        
        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(equalTo: profileStackView.bottomAnchor, constant: 60),
            infoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            infoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        view.addSubview(secondaryInfoStackView)
        
        secondaryInfoStackView.addArrangedSubview(foodButton)
        secondaryInfoStackView.addArrangedSubview(calendarButton)
        
        NSLayoutConstraint.activate([
            secondaryInfoStackView.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 8),
            secondaryInfoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            secondaryInfoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    private func loadProfileImage() {
        self.profileImageView.image = UIImage(named: "onboarding1")
    }
    
    @objc private func statisticsButtonTapped() {
        
    }
    
}
