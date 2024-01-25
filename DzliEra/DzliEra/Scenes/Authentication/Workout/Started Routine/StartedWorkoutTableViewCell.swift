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
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    
    private let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let setLabel: UILabel = {
        let label = UILabel()
        label.text = "SET"
        label.textColor = .gray
        label.textAlignment = .left
        return label
    }()
    
    private let repsLabel: UILabel = {
        let label = UILabel()
        label.text = "Reps"
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    private let checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark")
        imageView.tintColor = .gray
        imageView.clipsToBounds = true
        imageView.contentMode = .right
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        setupStackView()
        setupHeaderStackView()
        setupTableView()
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
    
    private func setupHeaderStackView() {
        contentView.addSubview(headerStackView)
        
        headerStackView.addArrangedSubview(setLabel)
        headerStackView.addArrangedSubview(repsLabel)
        headerStackView.addArrangedSubview(checkmarkImageView)
        
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: exerciseStackView.bottomAnchor, constant: 30),
            headerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            headerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ])
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        contentView.addSubview(tableView)
        
        tableView.register(WorkoutInfoTableViewCell.self, forCellReuseIdentifier: "WorkoutInfo")
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    
}

extension StartedWorkoutTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutInfo", for: indexPath) as! WorkoutInfoTableViewCell
        
        return cell
    }
    
    
}
