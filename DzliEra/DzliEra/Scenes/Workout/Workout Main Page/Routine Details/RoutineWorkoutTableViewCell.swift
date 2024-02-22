//
//  RoutineWorkoutTableViewCell.swift
//  DzliEra
//
//  Created by Levan Loladze on 20.02.24.
//

import UIKit

final class RoutineWorkoutTableViewCell: UITableViewCell {
    
    private let workoutImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var exercise: Exercise?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor(AppColors.secondaryBackgroundColor)
        contentView.layer.cornerRadius = 6
        
        contentView.addSubview(workoutImageView)
        contentView.addSubview(titleLabel)
        
        
        NSLayoutConstraint.activate([
            workoutImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            workoutImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            workoutImageView.widthAnchor.constraint(equalToConstant: 40),
            workoutImageView.heightAnchor.constraint(equalToConstant: 40),
            
            titleLabel.leadingAnchor.constraint(equalTo: workoutImageView.trailingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        contentView.backgroundColor = UIColor(AppColors.secondaryBackgroundColor)
    }
    
    func configure(with exercise: Exercise) {
        self.exercise = exercise
        workoutImageView.image = UIImage(named: "DzlieraImageHolder")
        
        titleLabel.text = exercise.name
    }
    
}
