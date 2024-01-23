//
//  ExerciseListViewController.swift
//  DzliEra
//
//  Created by Levan Loladze on 21.01.24.
//

import UIKit

protocol ExerciseListDelegate: AnyObject {
    func didSelectExercises(_ exercise: [Exercise])
}

class ExerciseListViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.gray.withAlphaComponent(1)
        tableView.allowsMultipleSelection = true
        return tableView
    }()
    
    private let selectButton: UIButton = {
        let button = UIButton()
        button.setTitle("Select", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.tintColor = .white
        button.semanticContentAttribute = .forceLeftToRight
        button.layer.cornerRadius = 6
        button.backgroundColor = .blue
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        return button
    }()
    
    private var selectedIndexPath: IndexPath?
    
    private let viewModel = ExerciseListViewModel()
    
    weak var exerciseListDelegate: ExerciseListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        viewModel.delegate = self
        setupTableView()
        setupSelectButton()
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
    
    func setupSelectButton() {
        selectButton.addTarget(self, action: #selector(selectButtonTapped), for: .touchUpInside)
        view.addSubview(selectButton)
        
        NSLayoutConstraint.activate([
            selectButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            selectButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            selectButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            selectButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    @objc func selectButtonTapped() {
        guard let selectedIndexPaths = tableView.indexPathsForSelectedRows else {
                    return
                }
                
                let selectedExercises = selectedIndexPaths.map { viewModel.exercises[$0.row] }
                exerciseListDelegate?.didSelectExercises(selectedExercises)
                navigationController?.popViewController(animated: true)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        selectButton.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedIndexPath = nil
        selectButton.isHidden = true
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
