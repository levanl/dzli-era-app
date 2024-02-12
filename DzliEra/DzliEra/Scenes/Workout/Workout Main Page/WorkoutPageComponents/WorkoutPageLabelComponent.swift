//
//  WorkoutPageLabelComponent.swift
//  DzliEra
//
//  Created by Levan Loladze on 12.02.24.
//

import UIKit

final class WorkoutPageLabelComponent: UILabel {
    
    // MARK: - Init
    init(text: String) {
        super.init(frame: .zero)
        self.text = text
        self.font = UIFont.boldSystemFont(ofSize: 20)
        self.textColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
