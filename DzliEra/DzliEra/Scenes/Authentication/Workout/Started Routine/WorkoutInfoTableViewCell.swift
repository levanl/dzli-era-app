//
//  WorkoutInfoTableViewCell.swift
//  DzliEra
//
//  Created by Levan Loladze on 25.01.24.
//

import UIKit

protocol WorkoutInfoTableViewCellDelegate: AnyObject {
    func checkmarkTapped(in cell: WorkoutInfoTableViewCell)
}

class WorkoutInfoTableViewCell: UITableViewCell {
        
    weak var delegate: WorkoutInfoTableViewCellDelegate?

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
        return textField
    }()
    
    private let repsTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "0"
        textField.textColor = .white
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let checkmarkBox: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark.square.fill")
        imageView.tintColor = .gray
        imageView.clipsToBounds = true
        imageView.contentMode = .right
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(infoStackView)
        
        
        infoStackView.addArrangedSubview(setsTextField)
        infoStackView.addArrangedSubview(repsTextField)
        infoStackView.addArrangedSubview(checkmarkBox)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(checkmarkTapped))
                checkmarkBox.addGestureRecognizer(tapGesture)
        
        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            infoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            infoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            checkmarkBox.widthAnchor.constraint(equalToConstant: 30),
            checkmarkBox.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc private func checkmarkTapped() {
        if checkmarkBox.tintColor == .gray {
                    checkmarkBox.tintColor = UIColor(red: 129/255, green: 203/255, blue: 74/255, alpha: 1.0)
                    contentView.backgroundColor = UIColor(red: 45/255, green: 96/255, blue: 18/255, alpha: 1.0)
                    setSelected(true, animated: true)
                } else {
                    checkmarkBox.tintColor = .gray
                    contentView.backgroundColor = .black
                    setSelected(false, animated: true)
                }
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            
        }
}
