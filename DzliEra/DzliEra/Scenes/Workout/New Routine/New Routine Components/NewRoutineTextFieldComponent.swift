//
//  NewRoutineTextFieldComponent.swift
//  DzliEra
//
//  Created by Levan Loladze on 12.02.24.
//

import UIKit

// MARK: - Component
final class NewRoutineTextFieldComponent: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTextField()
    }
    
    private func setupTextField() {
        placeholder = "Enter Routine Title"
        font = UIFont.systemFont(ofSize: 16)
        textColor = .white
        backgroundColor = UIColor(AppColors.secondaryGray)
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 45).isActive = true
        layer.cornerRadius = 6
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        leftViewMode = .always
    }
}

