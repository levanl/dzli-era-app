//
//  WorkoutPageButtonComponent.swift
//  DzliEra
//
//  Created by Levan Loladze on 12.02.24.
//

import UIKit

final class WorkoutPageButtonComponent: UIButton {
    
    // MARK: - Init
    init(image: UIImage?, title: String, tintColor: UIColor) {
        super.init(frame: .zero)
        setImage(image, for: .normal)
        setTitle("  \(title)", for: .normal)
        setTitleColor(tintColor, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 45).isActive = true
        layer.cornerRadius = 6
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Background
    func setCustomBackgroundColor(_ color: UIColor) {
        backgroundColor = color
    }
}
