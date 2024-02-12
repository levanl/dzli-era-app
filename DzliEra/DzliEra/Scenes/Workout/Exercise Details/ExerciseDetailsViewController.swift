//
//  ExerciseDetailsViewController.swift
//  DzliEra
//
//  Created by Levan Loladze on 22.01.24.
//

import UIKit

// MARK: - ViewController
class ExerciseDetailsViewController: UIViewController {
    
    // MARK: - Properties
    var exercise: Exercise?
    
    private let exerciseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 20.0)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    private let targetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 16.0)
        label.numberOfLines = 0
        label.textColor = .gray
        return label
    }()
    
    private let secondaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 16.0)
        label.numberOfLines = 0
        label.textColor = .gray
        return label
    }()
    
    private let exerciseInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let instructionsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setupImageView()
        setupStackView()
        setupInstructionsLabel()
        updateUI()
    }
    
    // MARK: - Private Properties
    private func setupImageView() {
        view.addSubview(exerciseImageView)
        
        NSLayoutConstraint.activate([
            exerciseImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            exerciseImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            exerciseImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            exerciseImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func setupStackView() {
        view.addSubview(exerciseInfoStackView)
        
        exerciseInfoStackView.addArrangedSubview(nameLabel)
        exerciseInfoStackView.addArrangedSubview(targetLabel)
        exerciseInfoStackView.addArrangedSubview(secondaryLabel)
        
        NSLayoutConstraint.activate([
            exerciseInfoStackView.topAnchor.constraint(equalTo: exerciseImageView.bottomAnchor, constant: 16),
            exerciseInfoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            exerciseInfoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupInstructionsLabel() {
        view.addSubview(instructionsLabel)
        
        NSLayoutConstraint.activate([
            instructionsLabel.topAnchor.constraint(equalTo: exerciseInfoStackView.bottomAnchor, constant: 24),
            instructionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            instructionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
    }
    
    private func updateUI() {
        guard let exercise = exercise, let imageURL = URL(string: exercise.gifURL) else {
            return
        }
        
        let secondaryMusclesString = exercise.secondaryMuscles?.joined(separator: ", ")
        
        let numberedInstructions = exercise.instructions?.enumerated().map { (index, instruction) in
            return "\(index + 1). \(instruction)"
        }
        
        let instructionsString = numberedInstructions?.joined(separator: "\n\n")
        
        nameLabel.text = exercise.name
        targetLabel.text = "Target: " + exercise.target
        secondaryLabel.text = "Secondary: " + (secondaryMusclesString ?? "none")
        exerciseImageView.image = UIImage.gifImageWithName("workout")
        instructionsLabel.text = "Instructions:\n\n" + (instructionsString ?? "none")
        
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: imageURL) {
                let image = UIImage.gifImageWithData(imageData)
                
                DispatchQueue.main.async {
                    self.exerciseImageView.image = image
                }
            }
        }
    }
}
