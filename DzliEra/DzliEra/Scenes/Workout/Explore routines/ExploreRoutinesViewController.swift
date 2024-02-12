//
//  ExploreRoutinesViewController.swift
//  DzliEra
//
//  Created by Levan Loladze on 12.02.24.
//

import UIKit

protocol ExploreRoutinesViewControllerDelegate: AnyObject {
    func didAddRoutine(_ routine: Routine)
}

// MARK: - ExploreRoutinesViewController
class ExploreRoutinesViewController: UIViewController {
    
    // MARK: - Properties
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(AppColors.backgroundColor)
        return tableView
    }()
    
    weak var delegate: ExploreRoutinesViewControllerDelegate?
    
    private let viewModel = ExploreRoutinesViewModel()
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Methods
    private func setupUI() {
        viewModel.onDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.fetchAllRoutines()
        view.backgroundColor = UIColor(AppColors.backgroundColor)
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ExploreTableViewCell.self, forCellReuseIdentifier: ExploreTableViewCell.identifier)
        tableView.register(WorkoutSkeletonCell.self, forCellReuseIdentifier: WorkoutSkeletonCell.identifier)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

extension ExploreRoutinesViewController: UITableViewDelegate, UITableViewDataSource {
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
            let cell = tableView.dequeueReusableCell(withIdentifier: ExploreTableViewCell.identifier, for: indexPath) as! ExploreTableViewCell
            
            let routine = viewModel.routines[indexPath.row]
            cell.configure(with: routine)
            cell.delegate = self
            cell.backgroundColor = UIColor(AppColors.backgroundColor)
            return cell
        case .failure:
            return UITableViewCell()
        case .idle:
            let cell = tableView.dequeueReusableCell(withIdentifier: ExploreTableViewCell.identifier, for: indexPath) as! ExploreTableViewCell
            cell.delegate = self
            let routine = viewModel.routines[indexPath.row]
            cell.configure(with: routine)
            
            cell.backgroundColor = UIColor(AppColors.backgroundColor)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
}

// MARK: - ExploreTableViewCellDelegate
extension ExploreRoutinesViewController: ExploreTableViewCellDelegate {
    func didTapAddRoutine(in cell: ExploreTableViewCell) {
        guard let tappedRoutine = cell.routine else { return }
        delegate?.didAddRoutine(tappedRoutine)
        
        self.navigationController?.popViewController(animated: true)
    }
}
