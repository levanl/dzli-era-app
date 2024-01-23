//
//  WorkoutViewController.swift
//  DzliEra
//
//  Created by Levan Loladze on 20.01.24.
//

import UIKit

class WorkoutViewController: UIViewController, NewRoutineDelegate {
    
    private let quickStartLabel: UILabel = {
        let label = UILabel()
        label.text = "Quick Start"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let routinesLabel: UILabel = {
        let label = UILabel()
        label.text = "Routines"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let startEmptyWorkoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let plusIcon = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold))?.withTintColor(.blue, renderingMode: .alwaysOriginal)
        button.setTitle("  Start Empty Workout", for: .normal)
        button.setImage(plusIcon, for: .normal)
        button.tintColor = .white
        button.semanticContentAttribute = .forceLeftToRight
        button.layer.cornerRadius = 6
        button.backgroundColor = UIColor(AppColors.gray)
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
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
        let list = UIImage(systemName: "list.clipboard", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold))?.withTintColor(.blue, renderingMode: .alwaysOriginal)
        button.setImage(list, for: .normal)
        button.setTitle("  New Routine", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(AppColors.gray)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        button.layer.cornerRadius = 6
        return button
    }()
    
    private let exploreButton: UIButton = {
        let button = UIButton()
        let magnifyingglass = UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold))?.withTintColor(.blue, renderingMode: .alwaysOriginal)
        button.setImage(magnifyingglass, for: .normal)
        button.setTitle("  Explore", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(AppColors.gray)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        button.layer.cornerRadius = 6
        
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let viewModel = WorkoutViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setupQuickStartLabel()
        setupStartEmptyWorkoutButton()
        setupRoutinesLabel()
        setupRoutineStackView()
        setupTableView()
    }
    
    func setupQuickStartLabel() {
        view.addSubview(quickStartLabel)
        
        NSLayoutConstraint.activate([
            quickStartLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            quickStartLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            quickStartLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    func setupRoutinesLabel() {
        view.addSubview(routinesLabel)
        
        NSLayoutConstraint.activate([
            routinesLabel.topAnchor.constraint(equalTo: startEmptyWorkoutButton.bottomAnchor, constant: 24),
            routinesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            routinesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    func setupStartEmptyWorkoutButton() {
        view.addSubview(startEmptyWorkoutButton)
        
        NSLayoutConstraint.activate([
            startEmptyWorkoutButton.topAnchor.constraint(equalTo: quickStartLabel.bottomAnchor, constant: 24),
            startEmptyWorkoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            startEmptyWorkoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
    }
    
    func setupRoutineStackView() {
        view.addSubview(routineStackView)
        
        routineStackView.addArrangedSubview(newRoutineButton)
        routineStackView.addArrangedSubview(exploreButton)
        
        newRoutineButton.addTarget(self, action: #selector(newRoutineButtonTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            routineStackView.topAnchor.constraint(equalTo: routinesLabel.bottomAnchor, constant: 24),
            routineStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            routineStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: routineStackView.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func newRoutineButtonTapped() {
        let newRoutineVC = NewRoutineViewController()
        newRoutineVC.delegate = self
        navigationController?.pushViewController(newRoutineVC, animated: true)
    }
    
    func didSaveRoutine(title: String, exercises: [Exercise]) {
        viewModel.addRoutine(title: title, exercises: exercises)
        tableView.reloadData()
    }
}

extension WorkoutViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.routines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
            let routine = viewModel.routines[indexPath.row]
            cell.textLabel?.text = routine.title
            
            return cell
    }
    
    
}
