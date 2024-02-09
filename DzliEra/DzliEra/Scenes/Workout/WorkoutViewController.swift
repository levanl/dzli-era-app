//
//  WorkoutViewController.swift
//  DzliEra
//
//  Created by Levan Loladze on 20.01.24.
//

import UIKit

// MARK: - WorkoutViewController
final class WorkoutViewController: UIViewController, NewRoutineDelegate {
    
    // MARK: - Properties
    private let quickStartLabel: UILabel = {
        let label = UILabel()
        label.text = "Quick Start"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let games = [
        Game("Pacman", "1980"),
        Game("Space Invaders", "1978"),
        Game("Frogger", "1981")
    ]
    
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
        let plusIcon = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold))?.withTintColor(UIColor(AppColors.secondaryRed), renderingMode: .alwaysOriginal)
        button.setTitle("  Start Empty Workout", for: .normal)
        button.setImage(plusIcon, for: .normal)
        button.tintColor = .white
        button.semanticContentAttribute = .forceLeftToRight
        button.layer.cornerRadius = 6
        button.backgroundColor = UIColor(AppColors.secondaryBackgroundColor)
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
        let list = UIImage(systemName: "list.clipboard", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold))?.withTintColor(UIColor(AppColors.secondaryRed), renderingMode: .alwaysOriginal)
        button.setImage(list, for: .normal)
        button.setTitle("  New Routine", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(AppColors.secondaryBackgroundColor)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        button.layer.cornerRadius = 6
        return button
    }()
    
    private let exploreButton: UIButton = {
        let button = UIButton()
        let magnifyingglass = UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold))?.withTintColor(UIColor(AppColors.secondaryRed), renderingMode: .alwaysOriginal)
        button.setImage(magnifyingglass, for: .normal)
        button.setTitle("  Explore", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(AppColors.secondaryBackgroundColor)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        button.layer.cornerRadius = 6
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(AppColors.backgroundColor)
        return tableView
    }()
    
    // MARK: - ViewModel reference
    private let viewModel = WorkoutViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.fetchRoutines()
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //        viewModel.fetchRoutines()
        //        tableView.reloadData()
    }
    
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = UIColor(AppColors.backgroundColor)
        setupQuickStartLabel()
        setupStartEmptyWorkoutButton()
        setupRoutinesLabel()
        setupRoutineStackView()
        setupTableView()
    }
    
    private func setupQuickStartLabel() {
        view.addSubview(quickStartLabel)
        NSLayoutConstraint.activate([
            quickStartLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            quickStartLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            quickStartLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupRoutinesLabel() {
        view.addSubview(routinesLabel)
        NSLayoutConstraint.activate([
            routinesLabel.topAnchor.constraint(equalTo: startEmptyWorkoutButton.bottomAnchor, constant: 24),
            routinesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            routinesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupStartEmptyWorkoutButton() {
        view.addSubview(startEmptyWorkoutButton)
        
        NSLayoutConstraint.activate([
            startEmptyWorkoutButton.topAnchor.constraint(equalTo: quickStartLabel.bottomAnchor, constant: 24),
            startEmptyWorkoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            startEmptyWorkoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupRoutineStackView() {
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
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WorkoutTableViewCell.self, forCellReuseIdentifier: WorkoutTableViewCell.identifier)
        tableView.register(WorkoutSkeletonCell.self, forCellReuseIdentifier: WorkoutSkeletonCell.identifier)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: routineStackView.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Button Tap Methods
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

// MARK: - TableView
extension WorkoutViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.routines.count > 0 ? viewModel.routines.count : games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if viewModel.routines.isEmpty {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: WorkoutSkeletonCell.identifier, for: indexPath) as! WorkoutSkeletonCell
            cell.game = games[indexPath.row]
            cell.backgroundColor =  UIColor(AppColors.backgroundColor)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: WorkoutTableViewCell.identifier, for: indexPath) as! WorkoutTableViewCell
            
            let routine = viewModel.routines[indexPath.row]
            cell.configure(with: routine)
            cell.delegate = self
            
            cell.backgroundColor = UIColor(AppColors.backgroundColor)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}


extension WorkoutViewController: WorkoutTableViewCellDelegate {
    func didSelectRoutine(_ routine: Routine) {
        let routineDetailVC = RoutineDetailViewController()
        routineDetailVC.routine = routine
        navigationController?.pushViewController(routineDetailVC, animated: true)
    }
    
    func didTapStartRoutine(_ routine: Routine) {
        let startedRoutineVC = StartedRoutineViewController()
        startedRoutineVC.routine = routine
        navigationController?.pushViewController(startedRoutineVC, animated: true)
    }
}
