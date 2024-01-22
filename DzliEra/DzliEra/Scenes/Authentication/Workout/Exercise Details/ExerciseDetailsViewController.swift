//
//  ExerciseDetailsViewController.swift
//  DzliEra
//
//  Created by Levan Loladze on 22.01.24.
//

import UIKit

class ExerciseDetailsViewController: UIViewController {
    
    
    var exercise: Exercise?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let exerciseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setupImageView()
        updateUI()
    }
    
    private func setupImageView() {
        
        view.addSubview(exerciseImageView)
        
        NSLayoutConstraint.activate([
            exerciseImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            exerciseImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            exerciseImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            exerciseImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func updateUI() {
        guard let exercise = exercise, let imageURL = URL(string: exercise.gifURL) else {
            return
        }
        nameLabel.text = exercise.name
        
        exerciseImageView.image = UIImage.gifImageWithName("workout")
        
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
