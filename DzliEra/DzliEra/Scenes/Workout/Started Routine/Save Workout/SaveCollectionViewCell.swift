//
//  SaveCollectionViewCell.swift
//  DzliEra
//
//  Created by Levan Loladze on 26.01.24.
//

import UIKit

// MARK: - SaveCollectionViewCell
final class SaveCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with image: UIImage) {
        imageView.image = image
    }
}
