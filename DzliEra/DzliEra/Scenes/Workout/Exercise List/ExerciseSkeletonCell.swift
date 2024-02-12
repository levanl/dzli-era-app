//
//  ExerciseSkeletonCell.swift
//  DzliEra
//
//  Created by Levan Loladze on 09.02.24.
//

import UIKit


class ExerciseSkeletonCell: UITableViewCell {
    static let identifier = "SkeletonCell"
    
    let titleLabel = UILabel()
        let workoutNamesLabel = UILabel()
        
        let titleLayer = CAGradientLayer()
        let workoutNamesLayer = CAGradientLayer()
    
    var game: PlaceHolderModel? {
        didSet {
            guard let game = game else { return }
            titleLabel.text = game.title
            workoutNamesLabel.text = game.year
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLayer.frame = titleLabel.bounds
                titleLayer.cornerRadius = 6
                workoutNamesLayer.frame = workoutNamesLabel.bounds
                workoutNamesLayer.cornerRadius = workoutNamesLabel.bounds.height / 2
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))

    }
    
}

extension ExerciseSkeletonCell {
    
    func setup() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        workoutNamesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLayer.startPoint = CGPoint(x: 0, y: 0.5)
                titleLayer.endPoint = CGPoint(x: 1, y: 0.5)
                titleLabel.layer.addSublayer(titleLayer)
        
        workoutNamesLayer.startPoint = CGPoint(x: 0, y: 0.5)
                workoutNamesLayer.endPoint = CGPoint(x: 1, y: 0.5)
                workoutNamesLabel.layer.addSublayer(workoutNamesLayer)
        
        let titleGroup = makeAnimationGroup()
                titleGroup.beginTime = 0.0
                titleLayer.add(titleGroup, forKey: "backgroundColor")
        
        let workoutNamesGroup = makeAnimationGroup(previousGroup: titleGroup)
                workoutNamesLayer.add(workoutNamesGroup, forKey: "backgroundColor")
    }
    
    func layout() {
        addSubview(titleLabel)
        addSubview(workoutNamesLabel)

        NSLayoutConstraint.activate([
                   titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
                   titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                   titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                   
                   workoutNamesLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
                   workoutNamesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                   workoutNamesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                   workoutNamesLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
               ])
    }
    
    func setPlaceholderText() {
            titleLabel.text = "Loading..."
            workoutNamesLabel.text = "Loading..."
        }
}

// inherit
extension ExerciseSkeletonCell: SkeletonLoadable {}

