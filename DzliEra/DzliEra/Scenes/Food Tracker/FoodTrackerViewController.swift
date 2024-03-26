//
//  FoodTrackerViewController.swift
//  DzliEra
//
//  Created by Levan Loladze on 26.03.24.
//

import UIKit

class FoodTrackerViewController: UIViewController {
    
    let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    let lockImageView = UIImageView(image: UIImage(systemName: "lock.fill"))
    
    let giorga = false
    
    private let whiteBoxView: UIView = {
        let whiteBox = UIView()
        whiteBox.translatesAutoresizingMaskIntoConstraints = false
        whiteBox.backgroundColor = .white
        whiteBox.layer.cornerRadius = 10
        whiteBox.layer.shadowColor = UIColor.black.cgColor
        whiteBox.layer.shadowOpacity = 0.2
        whiteBox.layer.shadowOffset = CGSize(width: 5, height: 5)
        whiteBox.layer.shadowRadius = 5
        
        return whiteBox
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBlurView()
        setupLockIcon()
        
        view.backgroundColor = UIColor(AppColors.foodSectionBackground)
        
        view.addSubview(whiteBoxView)
        
        NSLayoutConstraint.activate([
            whiteBoxView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            whiteBoxView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            whiteBoxView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            whiteBoxView.heightAnchor.constraint(equalToConstant: 300)
                ])
        if giorga {
            blurEffectView.isHidden = false
            lockImageView.isHidden = false
        }
    }
    
    func setupBlurView() {
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        blurEffectView.isHidden = true
    }
    
    func setupLockIcon() {
        lockImageView.center = view.center
        view.addSubview(lockImageView)
        lockImageView.isHidden = true
    }
    
    
    
}
