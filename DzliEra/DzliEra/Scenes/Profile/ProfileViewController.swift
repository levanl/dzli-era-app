//
//  ProfileViewController.swift
//  DzliEra
//
//  Created by Levan Loladze on 20.01.24.
//

import UIKit
import SwiftUI

final class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    private var user: DBUser? = nil
    
    private let viewModel = ProfileViewModel()
    
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
        imageView.image = UIImage(named: "DzlieraImageHolder")
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
    
    private let exerciseLibraryButton: UIButton = {
        let button = UIButton()
        let magnifyingglass = UIImage(systemName: "book.closed.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold))?.withTintColor(.white, renderingMode: .alwaysOriginal)
        button.setImage(magnifyingglass, for: .normal)
        button.setTitle("  Exercises", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(AppColors.primaryRed)
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
        let list = UIImage(systemName: "fork.knife", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold))?.withTintColor(.white, renderingMode: .alwaysOriginal)
        button.setImage(list, for: .normal)
        button.setTitle("  Nutrition", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(AppColors.primaryRed)
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
    
    private let editProfileButton: UIButton = {
        let button = UIButton()
        let magnifyingglass = UIImage(systemName: "gear", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold))?.withTintColor(.white, renderingMode: .alwaysOriginal)
        button.setImage(magnifyingglass, for: .normal)
        button.setTitle("  Settings", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(AppColors.primaryRed)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        button.layer.cornerRadius = 6
        return button
    }()
    
    private let cardsButton: UIButton = {
        let button = UIButton()
        let magnifyingglass = UIImage(systemName: "creditcard.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold))?.withTintColor(.white, renderingMode: .alwaysOriginal)
        button.setImage(magnifyingglass, for: .normal)
        button.setTitle("  Your Cards", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(AppColors.primaryRed)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        button.layer.cornerRadius = 6
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.text = "Bio"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Task {
            do {
                let authDataResult = try await AuthenticationManager.shared.getAuthenticatedUser()
                self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
                print("User loaded: \(self.user?.email ?? "Unknown email")")
                DispatchQueue.main.async {
                    self.profileLabel.text = self.user?.email
                    self.loadProfileInfo()
                }
            } catch {
                print("Error loading user: \(error)")
            }
        }
    }
    
    
    // MARK: - Methods
    private func setupUI() {
        view.backgroundColor = UIColor(AppColors.backgroundColor)
        
        setupProfileStackView()
        setupProfileLabels()
        setupInfoStackViews()
        setupEditProfileButton()
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
        
        infoStackView.addArrangedSubview(exerciseLibraryButton)
        infoStackView.addArrangedSubview(foodButton)
        exerciseLibraryButton.addTarget(self, action: #selector(exerciseLibraryButtonTapped), for: .touchUpInside)
        
        
        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 40),
            infoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            infoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        foodButton.addTarget(self, action: #selector(foodButtonTapped), for: .touchUpInside)
    }
    
    private func setupProfileLabels() {
        view.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: profileStackView.bottomAnchor, constant: 30),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        view.addSubview(bioLabel)
        
        NSLayoutConstraint.activate([
            bioLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            bioLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupEditProfileButton() {
        view.addSubview(editProfileButton)
        
        editProfileButton.addTarget(self, action: #selector(editProfileTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            editProfileButton.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 8),
            editProfileButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            editProfileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        view.addSubview(cardsButton)
        
        NSLayoutConstraint.activate([
            cardsButton.topAnchor.constraint(equalTo: editProfileButton.bottomAnchor, constant: 8),
            cardsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cardsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
    }
    
    private func loadProfileInfo() {
        profileImageView.image = UIImage(named: "DzlieraImageHolder")
        nameLabel.text = "\(user?.name ?? "Name:")"
        bioLabel.text = "Bio: \(user?.bio ?? "Bio:")"
    }
    
    // MARK: - Button Functions
    @objc private func foodButtonTapped() {
        self.navigationController?.pushViewController(NutritionViewController(), animated: true)
    }
    
    @objc private func exerciseLibraryButtonTapped() {
        self.navigationController?.pushViewController(ExerciseListViewController(), animated: true)
    }
    
    @objc private func editProfileTapped() {
        self.navigationController?.pushViewController(UIHostingController(rootView: EditProfileView()), animated: true)
    }
}
