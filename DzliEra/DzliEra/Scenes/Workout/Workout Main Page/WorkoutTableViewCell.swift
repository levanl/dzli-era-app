//
//  WorkoutTableViewCell.swift
//  DzliEra
//
//  Created by Levan Loladze on 23.01.24.
//

import UIKit

protocol WorkoutTableViewCellDelegate: AnyObject {
    func didSelectRoutine(_ routine: Routine)
    func didTapStartRoutine(_ routine: Routine)
}

// MARK: - WorkoutTableViewCell
final class WorkoutTableViewCell: UITableViewCell {
    static let identifier = "WorkoutCell"
    
    weak var delegate: WorkoutTableViewCellDelegate?
    var routine: Routine?
    
    // MARK: - Properties
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
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let startRoutineButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start Routine", for: .normal)
        button.backgroundColor = UIColor(AppColors.primaryRed)
        button.layer.cornerRadius = 6
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        contentView.backgroundColor = UIColor(AppColors.secondaryBackgroundColor)
        contentView.layer.cornerRadius = 6
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(workoutNamesLabel)
        contentView.addSubview(startRoutineButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            workoutNamesLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            workoutNamesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            workoutNamesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            startRoutineButton.topAnchor.constraint(equalTo: workoutNamesLabel.bottomAnchor, constant: 10),
            startRoutineButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            startRoutineButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            startRoutineButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        
        startRoutineButton.addTarget(self, action: #selector(startRoutineButtonTapped), for: .touchUpInside)
        
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor(AppColors.gray)
        selectedBackgroundView.layer.cornerRadius = 8
        selectedBackgroundView.layer.masksToBounds = true
        
        self.selectedBackgroundView = selectedBackgroundView
    }
    
    // MARK: - Configure Method
    func configure(with routine: Routine) {
        titleLabel.text = routine.title
        self.routine = routine
        workoutNamesLabel.text = "Workouts: \(routine.exercises.map { $0.name }.joined(separator: ", "))"
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        contentView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Button Methods
    @objc private func cellTapped() {
        guard let routine = routine else { return }
        delegate?.didSelectRoutine(routine)
    }
    
    @objc private func startRoutineButtonTapped() {
        guard let routine = routine else { return }
        delegate?.didTapStartRoutine(routine)
    }
}
