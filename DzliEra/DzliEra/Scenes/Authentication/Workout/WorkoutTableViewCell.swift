//
//  WorkoutTableViewCell.swift
//  DzliEra
//
//  Created by Levan Loladze on 23.01.24.
//

import UIKit

class WorkoutTableViewCell: UITableViewCell {
    static let identifier = "WorkoutCell"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let workoutNamesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let startRoutineButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start Routine", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 6
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(workoutNamesLabel)
        contentView.addSubview(startRoutineButton)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            workoutNamesLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            workoutNamesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            workoutNamesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            startRoutineButton.topAnchor.constraint(equalTo: workoutNamesLabel.bottomAnchor, constant: 8),
            startRoutineButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            startRoutineButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            startRoutineButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    func configure(with routine: Routine) {
        titleLabel.text = routine.title
        workoutNamesLabel.text = "Workouts: \(routine.exercises.map { $0.name }.joined(separator: ", "))"

    }
}
