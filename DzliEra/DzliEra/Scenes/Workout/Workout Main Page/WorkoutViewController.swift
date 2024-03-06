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
    private let routinesLabel: UILabel = {
        let label = WorkoutPageLabelComponent(text: "Routines")
        return label
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
        let list = UIImage(systemName: "list.clipboard", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold))?.withTintColor(UIColor(AppColors.secondaryRed), renderingMode: .alwaysOriginal)
        let button = WorkoutPageButtonComponent(image: list, title: "New Routine", tintColor: .white)
        button.setCustomBackgroundColor(UIColor(AppColors.secondaryBackgroundColor))
        return button
    }()
    
    private let exploreButton: UIButton = {
        let magnifyingglass = UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold))?.withTintColor(UIColor(AppColors.secondaryRed), renderingMode: .alwaysOriginal)
        let button = WorkoutPageButtonComponent(image: magnifyingglass, title: "Explore", tintColor: .white)
        button.setCustomBackgroundColor(UIColor(AppColors.secondaryBackgroundColor))
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
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        fetchRoutinesOnLoad()
        view.backgroundColor = UIColor(AppColors.backgroundColor)
        setupRoutinesLabel()
        setupRoutineStackView()
        setupTableView()
    }
    
    private func fetchRoutinesOnLoad() {
        viewModel.onDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.fetchRoutines()
    }
    
    private func setupRoutinesLabel() {
        view.addSubview(routinesLabel)
        NSLayoutConstraint.activate([
            routinesLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            routinesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            routinesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupRoutineStackView() {
        view.addSubview(routineStackView)
        routineStackView.addArrangedSubview(newRoutineButton)
        routineStackView.addArrangedSubview(exploreButton)
        exploreButton.addTarget(self, action: #selector(exploreButtonTapped), for: .touchUpInside)
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
    
    @objc func exploreButtonTapped() {
        let exploreRoutineVC = ExploreRoutinesViewController()
        exploreRoutineVC.delegate = self
        navigationController?.pushViewController(exploreRoutineVC, animated: true)
    }
    
    func didSaveRoutine(title: String, exercises: [Exercise]) {
        viewModel.addRoutine(title: title, exercises: exercises)
        tableView.reloadData()
    }
}

// MARK: - TableView
extension WorkoutViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.fetchingStatus {
        case .fetching:
            return viewModel.games.count
        case .success:
            return viewModel.routines.count
        case .failure:
            return 0
        case .idle:
            return viewModel.routines.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.fetchingStatus {
        case .fetching:
            let cell = tableView.dequeueReusableCell(withIdentifier: WorkoutSkeletonCell.identifier, for: indexPath) as! WorkoutSkeletonCell
            cell.game = viewModel.games[indexPath.row]
            cell.backgroundColor =  UIColor(AppColors.backgroundColor)
            return cell
        case .success:
            let reversedRoutines = Array(viewModel.routines.reversed())
            let cell = tableView.dequeueReusableCell(withIdentifier: WorkoutTableViewCell.identifier, for: indexPath) as! WorkoutTableViewCell
            
            let routine = reversedRoutines[indexPath.row]
            cell.configure(with: routine)
            cell.delegate = self
            
            cell.backgroundColor = UIColor(AppColors.backgroundColor)
            return cell
        case .failure:
            return UITableViewCell()
        case .idle:
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


// MARK: - Cell Delegate Listener
extension WorkoutViewController: WorkoutTableViewCellDelegate {
    func didTapRoutineInfoButton(for routine: Routine) {
        let routineInfoVC = RoutineInfoViewController()
        
        routineInfoVC.routine = routine
        
        navigationController?.pushViewController(routineInfoVC, animated: true)
    }
    func didSelectRoutine(_ routine: Routine) { }
    
    func didTapStartRoutine(_ routine: Routine) {
        let startedRoutineVC = StartedRoutineViewController()
        startedRoutineVC.routine = routine
        navigationController?.pushViewController(startedRoutineVC, animated: true)
    }
    
}


// MARK: - Explore Routines Delegate Listener
extension WorkoutViewController: ExploreRoutinesViewControllerDelegate {
    func didAddRoutine(_ routine: Routine) {
        viewModel.addRoutine(title: routine.title, exercises: routine.exercises)
        tableView.reloadData()
    }
}


