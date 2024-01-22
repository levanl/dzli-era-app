//
//  ExerciseListViewController.swift
//  DzliEra
//
//  Created by Levan Loladze on 21.01.24.
//

import UIKit

class ExerciseListViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.gray.withAlphaComponent(1)
        return tableView
    }()
    
    private let viewModel = ExerciseListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        viewModel.delegate = self
        setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.register(ExerciseTableViewCell.self, forCellReuseIdentifier: "ExerciseCell")
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
}

extension ExerciseListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfExercises
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath) as! ExerciseTableViewCell
        let exercise = viewModel.exercises[indexPath.row]
        cell.delegate = self
        cell.configure(with: exercise)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}


extension ExerciseListViewController: ExerciseListViewModelDelegate {
    func exerciseListViewModelDidFetchData(_ viewModel: ExerciseListViewModel) {
        tableView.reloadData()
    }
}

extension ExerciseListViewController: ExerciseCellDelegate {
    
    func didTapDetailsButton(in cell: ExerciseTableViewCell, with exercise: Exercise) {
        let detailsViewController = ExerciseDetailsViewController()
        detailsViewController.exercise = exercise
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
