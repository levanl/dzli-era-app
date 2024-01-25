//
//  WorkoutInfoTableViewCell.swift
//  DzliEra
//
//  Created by Levan Loladze on 25.01.24.
//

import UIKit

class WorkoutInfoTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .gray
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
