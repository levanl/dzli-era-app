//
//  ExerciseTableViewCell.swift
//  DzliEra
//
//  Created by Levan Loladze on 22.01.24.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {
    
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
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.lineBreakMode = .byTruncatingTail
        label.widthAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
        return label
    }()
    
    private let bodyPartLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let actionIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "info.circle"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .black
        setupImageView()
        setupStackView()
        setupActionIcon()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
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
        bodyPartLabel.text = exercise.bodyPart
    }
    
    private func setupImageView() {
        addSubview(exerciseImageView)
        
        NSLayoutConstraint.activate([
            exerciseImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            exerciseImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            exerciseImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 70),
            exerciseImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 70)
        ])
    }
    
    private func setupStackView() {
        addSubview(stackView)
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(bodyPartLabel)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: exerciseImageView.trailingAnchor, constant: 12)
        ])
    }
    
    private func setupActionIcon() {
        addSubview(actionIcon)
        
        NSLayoutConstraint.activate([
            actionIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            actionIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actionIconTapped))
                actionIcon.isUserInteractionEnabled = true
                actionIcon.addGestureRecognizer(tapGesture)
    }
    
    @objc private func actionIconTapped() {
           print("action tapped")
       }
    
}
