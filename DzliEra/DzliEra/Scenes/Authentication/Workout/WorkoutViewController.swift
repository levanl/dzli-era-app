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
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return button
    }()
    
    
    private let routineStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    private let newRoutineButton: UIButton = {
        let button = UIButton()
        button.setTitle("New Routine", for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    private let exploreButton: UIButton = {
        let button = UIButton()
        button.setTitle("Explore", for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setupStartEmptyWorkoutButton()
        setupRoutineStackView()
    }
    
    
    func setupStartEmptyWorkoutButton() {
        view.addSubview(startEmptyWorkoutButton)
        
        NSLayoutConstraint.activate([
            startEmptyWorkoutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            startEmptyWorkoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            startEmptyWorkoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
    }
    
    func setupRoutineStackView() {
        view.addSubview(routineStackView)
        
        routineStackView.addArrangedSubview(newRoutineButton)
        routineStackView.addArrangedSubview(exploreButton)
        
        NSLayoutConstraint.activate([
            routineStackView.topAnchor.constraint(equalTo: startEmptyWorkoutButton.bottomAnchor, constant: 12),
            routineStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            routineStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
    }
    
}
