//
//  SaveWorkoutLabelComponent.swift
//  DzliEra
//
//  Created by Levan Loladze on 12.02.24.
//

import UIKit

class SaveWorkoutLabelComponent: UILabel {
        // MARK: - Properties
        var customTextColor: UIColor
        
        // MARK: - Initialization
        init(frame: CGRect, text: String, textColor: UIColor) {
            self.customTextColor = textColor
            super.init(frame: frame)
            setup(text: text)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setup(text: String) {
            font = UIFont.boldSystemFont(ofSize: 16)
            self.text = text
            textColor = customTextColor
            translatesAutoresizingMaskIntoConstraints = false
            textAlignment = .center
        }
}
