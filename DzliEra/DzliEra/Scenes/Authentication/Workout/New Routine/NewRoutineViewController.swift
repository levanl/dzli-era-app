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

class NewRoutineViewController: UIViewController {
    
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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        setupTitleTextField()
        setupAddExerciseButton()
        // Do any additional setup after loading the view.
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
        
        NSLayoutConstraint.activate([
            addExerciseButton.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 24),
            addExerciseButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addExerciseButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

}
