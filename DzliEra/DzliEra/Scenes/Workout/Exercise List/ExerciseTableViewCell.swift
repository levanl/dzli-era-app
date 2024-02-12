//
//  ExerciseTableViewCell.swift
//  DzliEra
//
//  Created by Levan Loladze on 22.01.24.
//

import UIKit

protocol ExerciseCellDelegate: AnyObject {
    func didTapDetailsButton(in cell: ExerciseTableViewCell, with exercise: Exercise)
}

// MARK: - ExerciseTableViewCell
final class ExerciseTableViewCell: UITableViewCell {
    
    // MARK: - Properties
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
    
    private let blueRectangleView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    var delegate: ExerciseCellDelegate?
    
    var exercise: Exercise?
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            animateOnSelection()
        } else {
            animateOnDeselection()
        }
        
    }
    
    // MARK: - Configure Method
    func configure(with exercise: Exercise) {
        self.exercise = exercise
        self.exerciseImageView.image = UIImage(named: "DzlieraImageHolder")
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
    
    // MARK: - Methods
    private func setupUI() {
        
        contentView.backgroundColor = UIColor(AppColors.backgroundColor)
        setupImageView()
        setupStackView()
        setupActionIcon()
        setupRectangle()
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
    
    private func setupRectangle() {
        contentView.addSubview(blueRectangleView)
        
        NSLayoutConstraint.activate([
            blueRectangleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            blueRectangleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            blueRectangleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            blueRectangleView.widthAnchor.constraint(equalToConstant: 5),
        ])
    }
    
    private func animateOnSelection() {
        UIView.animate(withDuration: 0.2, animations: {
            self.exerciseImageView.transform = CGAffineTransform(translationX: 10, y: 0)
            self.stackView.transform = CGAffineTransform(translationX: 10, y: 0)
            self.blueRectangleView.isHidden = false
        })
    }
    
    private func animateOnDeselection() {
        UIView.animate(withDuration: 0.2, animations: {
            self.exerciseImageView.transform = .identity
            self.stackView.transform = .identity
            self.blueRectangleView.isHidden = true
        })
    }
    
    @objc private func actionIconTapped() {
        guard let exercise = exercise else {
            return
        }
        delegate?.didTapDetailsButton(in: self, with: exercise)
    }
    
}
