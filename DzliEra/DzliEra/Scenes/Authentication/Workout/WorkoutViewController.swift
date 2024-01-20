//
//  WorkoutViewController.swift
//  DzliEra
//
//  Created by Levan Loladze on 20.01.24.
//

import UIKit

class WorkoutViewController: UIViewController {
    
    private let startEmptyWorkoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let plusIcon = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold))?.withTintColor(.blue, renderingMode: .alwaysOriginal)
        button.setTitle("  Start Empty Workout", for: .normal)
        button.setImage(plusIcon, for: .normal)
        button.tintColor = .white
        button.semanticContentAttribute = .forceLeftToRight
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(AppColors.gray)
        button.heightAnchor.constraint(equalToConstant: 56).isActive = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setupStartEmptyWorkoutButton()
        // Do any additional setup after loading the view.
    }
    
    
    func setupStartEmptyWorkoutButton() {
        view.addSubview(startEmptyWorkoutButton)
        
        NSLayoutConstraint.activate([
            startEmptyWorkoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            startEmptyWorkoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            startEmptyWorkoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
    }
    
}
