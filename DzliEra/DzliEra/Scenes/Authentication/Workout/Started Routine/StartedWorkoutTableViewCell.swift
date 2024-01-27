//
//  StartedWorkoutTableViewCell.swift
//  DzliEra
//
//  Created by Levan Loladze on 24.01.24.
//

import UIKit

protocol StartedWorkoutTableViewCellDelegate: AnyObject {
    func updateValues(in cell: StartedWorkoutTableViewCell, with sets: Int, reps: Int)
}

class StartedWorkoutTableViewCell: UITableViewCell {
    
    weak var delegate: StartedWorkoutTableViewCellDelegate?
    var currentSets: Int = 0
    var currentReps: Int = 0
    
    private let exerciseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .systemBlue
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
        label.textAlignment = .center
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
        imageView.contentMode = .center
        return imageView
    }()
    
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let setsTextField: UITextField = {
        let textField = UITextField()
        textField.text = "0"
        textField.textColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        return textField
    }()
    
    private let repsTextField: UITextField = {
        let textField = UITextField()
        textField.text = "0"
        textField.textColor = .white
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let checkmarkBox: UIImageView = {
        let imageView = UIImageView()
        let config = UIImage.SymbolConfiguration(paletteColors: [.white, .secondaryLabel, .secondaryLabel])
        let image = UIImage(systemName: "checkmark.diamond.fill", withConfiguration: config)
        imageView.image = image
        imageView.tintColor = .gray
        imageView.clipsToBounds = true
        imageView.contentMode = .center
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        setupStackView()
        setupHeaderStackView()
        setupInfoStackView()
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
                        self.exerciseImageView.setNeedsLayout()
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
            exerciseStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            exerciseStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            exerciseStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
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
            headerStackView.topAnchor.constraint(equalTo: exerciseStackView.bottomAnchor, constant: 24),
            headerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            headerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ])
    }
    
    private func setupInfoStackView() {
        contentView.addSubview(infoStackView)
        
        infoStackView.addArrangedSubview(setsTextField)
        infoStackView.addArrangedSubview(repsTextField)
        infoStackView.addArrangedSubview(checkmarkBox)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(checkmarkTapped))
        checkmarkBox.addGestureRecognizer(tapGesture)
        
        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 4),
            infoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            infoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            checkmarkBox.widthAnchor.constraint(equalToConstant: 30),
            checkmarkBox.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc private func checkmarkTapped() {
        if checkmarkBox.tintColor == .gray {
            
            let newPaletteColors: [UIColor] = [.white, UIColor(red: 129/255, green: 203/255, blue: 74/255, alpha: 1.0), UIColor(red: 129/255, green: 203/255, blue: 74/255, alpha: 1.0)]
            let newConfig = UIImage.SymbolConfiguration(paletteColors: newPaletteColors)
            let newImage = UIImage(systemName: "checkmark.diamond.fill", withConfiguration: newConfig)
            checkmarkBox.image = newImage
            infoStackView.backgroundColor = UIColor(red: 45/255, green: 96/255, blue: 18/255, alpha: 1.0)
            setSelected(true, animated: true)
            currentSets = Int(setsTextField.text ?? "") ?? 0
            currentReps = Int(repsTextField.text ?? "") ?? 0
            delegate?.updateValues(in: self, with: currentSets, reps: currentReps)
        } else {
            let config = UIImage.SymbolConfiguration(paletteColors: [.white, .secondaryLabel, .secondaryLabel])
            let newImage = UIImage(systemName: "checkmark.diamond.fill", withConfiguration: config)
            checkmarkBox.image = newImage
            infoStackView.backgroundColor = .black
            setSelected(false, animated: true)
            currentSets = Int(setsTextField.text ?? "") ?? 0
            currentReps = Int(repsTextField.text ?? "") ?? 0
            delegate?.updateValues(in: self, with: currentSets, reps: currentReps)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
