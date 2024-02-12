//
//  NewRoutineViewController.swift
//  DzliEra
//
//  Created by Levan Loladze on 21.01.24.
//

import UIKit

// MARK: - NewRoutine Protocol
protocol NewRoutineDelegate: AnyObject {
    func didSaveRoutine(title: String, exercises: [Exercise]) async
}

// MARK: - ViewController
final class NewRoutineViewController: UIViewController, NewRoutineDelegate {
    
    // MARK: - Properties
    private let titleTextField: UITextField = {
        let titleTextField = NewRoutineTextFieldComponent()
        return titleTextField
    }()
    
    private let addExerciseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let plusIcon = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold))?.withTintColor(.white, renderingMode: .alwaysOriginal)
        button.setTitle("  Add exercise", for: .normal)
        button.setImage(plusIcon, for: .normal)
        button.tintColor = .white
        button.semanticContentAttribute = .forceLeftToRight
        button.layer.cornerRadius = 6
        button.backgroundColor = UIColor(AppColors.primaryRed)
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.gray.withAlphaComponent(1)
        return tableView
    }()
    
    private lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTappedWrapper))
        return button
    }()
    
    weak var delegate: NewRoutineDelegate?
    
    var selectedExercise: Exercise?
    
    private let viewModel = NewRoutineViewModel()
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loadUser()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = UIColor(AppColors.backgroundColor)
        viewModel.delegate = self
        setupTitleTextField()
        setupAddExerciseButton()
        setupTableView()
        navigationItem.rightBarButtonItem = saveButton
    }
    
    private func setupTitleTextField() {
        view.addSubview(titleTextField)
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupAddExerciseButton() {
        view.addSubview(addExerciseButton)
        addExerciseButton.addTarget(self, action: #selector(addExerciseButtonTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            addExerciseButton.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 24),
            addExerciseButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addExerciseButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.register(ExerciseTableViewCell.self, forCellReuseIdentifier: "ExerciseCell")
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: addExerciseButton.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func addExerciseButtonTapped() {
        let exercisesVC = ExerciseListViewController()
        exercisesVC.exerciseListDelegate = self
        navigationController?.pushViewController(exercisesVC, animated: true)
    }
    
    func saveButtonTapped() async {
        if let title = titleTextField.text, !title.isEmpty, !viewModel.exercises.isEmpty {
            await didSaveRoutine(title: title, exercises: viewModel.exercises)
        } else {
            print("cant doit")
        }
    }
    
    @objc func saveButtonTappedWrapper() {
        Task {
            await saveButtonTapped()
        }
    }
    
    func didSaveRoutine(title: String, exercises: [Exercise]) async {
        do {
            guard var user = viewModel.user else {
                print("Error: User not found.")
                return
            }
            
            let newRoutine = Routine(title: title, exercises: exercises)
            
            user.addRoutine(newRoutine)
            
            try await viewModel.uploadRoutines(userId: user.userId, routines: user.routines ?? [])
            
            try await viewModel.uploadRoutinesToCollection(routines: user.routines ?? [])
            
            await delegate?.didSaveRoutine(title: title, exercises: exercises)
            
        } catch {
            print("Error saving routine: \(error)")
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    
}

// MARK: - TableView
extension NewRoutineViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.exercises.count
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

// MARK: - Exercise List Delegate
extension NewRoutineViewController: ExerciseListDelegate {
    func didSelectExercises(_ exercises: [Exercise]) {
        for exercise in exercises {
            viewModel.addExercise(exercise)
        }
        tableView.reloadData()
    }
}

// MARK: - Exercise Cell Delegate
extension NewRoutineViewController: ExerciseCellDelegate {
    func didTapDetailsButton(in cell: ExerciseTableViewCell, with exercise: Exercise) {
        let detailsViewController = ExerciseDetailsViewController()
        detailsViewController.exercise = exercise
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
