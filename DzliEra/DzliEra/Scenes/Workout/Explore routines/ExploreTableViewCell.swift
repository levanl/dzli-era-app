//
//  ExploreTableViewCell.swift
//  DzliEra
//
//  Created by Levan Loladze on 12.02.24.
//


import UIKit

protocol ExploreTableViewCellDelegate: AnyObject {
    func didTapAddRoutine(in cell: ExploreTableViewCell)
}

// MARK: - WorkoutTableViewCell
final class ExploreTableViewCell: UITableViewCell {
    static let identifier = "ExploreCell"

    weak var delegate: ExploreTableViewCellDelegate?

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
        button.setTitle("Add Routine", for: .normal)
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
        
        startRoutineButton.addTarget(self, action: #selector(addRoutineButtonTapped), for: .touchUpInside)
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
    }
    
    @objc private func addRoutineButtonTapped() {
            delegate?.didTapAddRoutine(in: self)
        print("tapped")
        }
}
