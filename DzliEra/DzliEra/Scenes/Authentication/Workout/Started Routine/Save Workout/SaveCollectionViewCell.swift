//
//  SaveCollectionViewCell.swift
//  DzliEra
//
//  Created by Levan Loladze on 26.01.24.
//

import UIKit

class SaveCollectionViewCell: UICollectionViewCell {
    let imageView: UIImageView

        override init(frame: CGRect) {
            imageView = UIImageView()
            super.init(frame: frame)

            contentView.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: topAnchor),
                imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
