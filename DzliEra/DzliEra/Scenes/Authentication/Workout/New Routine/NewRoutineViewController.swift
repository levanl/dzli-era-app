//
//  NewRoutineViewController.swift
//  DzliEra
//
//  Created by Levan Loladze on 21.01.24.
//

import UIKit

protocol NewRoutineDelegate: AnyObject {
    func didSaveRoutine(title: String)
}

class NewRoutineViewController: UIViewController, NewRoutineDelegate {
    func didSaveRoutine(title: String) {
        print(title)
    }
    
    weak var delegate: NewRoutineDelegate?
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Routine Title"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .white
        textField.backgroundColor = UIColor(AppColors.gray)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        textField.layer.cornerRadius = 6
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        textField.leftViewMode = .always
        return textField
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
        button.backgroundColor = .blue
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

    private let viewModel = NewRoutineViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        viewModel.delegate = self
        setupTitleTextField()
        setupAddExerciseButton()
        setupTableView()
    }
    
    func setupTitleTextField() {
        view.addSubview(titleTextField)
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    func setupAddExerciseButton() {
        view.addSubview(addExerciseButton)
        
        addExerciseButton.addTarget(self, action: #selector(addExerciseButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            addExerciseButton.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 24),
            addExerciseButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addExerciseButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    func setupTableView() {
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
        navigationController?.pushViewController(exercisesVC, animated: true)
    }

}


extension NewRoutineViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath) as! ExerciseTableViewCell
//        let exercise = viewModel.exercises[indexPath.row]
//        cell.delegate = self
//        cell.configure(with: exercise)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

