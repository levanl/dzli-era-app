//
//  StartedWorkoutTableViewCell.swift
//  DzliEra
//
//  Created by Levan Loladze on 24.01.24.
//

import UIKit

class StartedWorkoutTableViewCell: UITableViewCell {
    
    private let exerciseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.lineBreakMode = .byTruncatingTail
        label.widthAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
        return label
    }()
    
    private let exerciseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        setupStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with exercise: Exercise) {
        if let imageURL = URL(string: exercise.gifURL) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageURL) {
                    DispatchQueue.main.async {
                        self.exerciseImageView.image = UIImage(data: data)
                        
                        self.exerciseImageView.layer.cornerRadius = self.exerciseImageView.frame.size.width / 2
                    }
                }
            }
        }
        
        nameLabel.text = exercise.name
    }
    
    private func setupStackView() {
        contentView.addSubview(exerciseStackView)
        
        exerciseStackView.addArrangedSubview(exerciseImageView)
        exerciseStackView.addArrangedSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            exerciseStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            exerciseStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            exerciseStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            exerciseImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 50),
            exerciseImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 50)
        ])
    }
    
}
