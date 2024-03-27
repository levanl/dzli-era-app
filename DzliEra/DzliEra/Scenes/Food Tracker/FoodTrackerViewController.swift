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
    var progressPercentage: Float = 0.0
    let shapeLayer =  CAShapeLayer()
    let trackLayer = CAShapeLayer()
    let giorga = false
    
    private let whiteBoxView: UIView = {
        let whiteBox = UIView()
        whiteBox.translatesAutoresizingMaskIntoConstraints = false
        whiteBox.backgroundColor = .white
        whiteBox.layer.cornerRadius = 10
        whiteBox.layer.shadowColor = UIColor.black.cgColor
        whiteBox.layer.shadowOpacity = 0.2
        whiteBox.layer.shadowOffset = CGSize(width: 0, height: 0)
        whiteBox.layer.shadowRadius = 5
        
        return whiteBox
    }()
    
    private let precentageLabel: UILabel = {
        let label = UILabel()
        label.text = "0%"
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
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
        
        let centerPoint = CGPoint(x: 180, y: 150)
        
        let circularPath = UIBezierPath(arcCenter: centerPoint, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.black.cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = CAShapeLayerLineCap.round
        trackLayer.strokeEnd = 0
        
        whiteBoxView.layer.addSublayer(trackLayer)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 0
        
        whiteBoxView.layer.addSublayer(shapeLayer)
        
        if giorga {
            blurEffectView.isHidden = false
            lockImageView.isHidden = false
        }
        
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
        whiteBoxView.addSubview(precentageLabel)
        
        NSLayoutConstraint.activate([
            precentageLabel.centerXAnchor.constraint(equalTo: whiteBoxView.centerXAnchor),
            precentageLabel.centerYAnchor.constraint(equalTo: whiteBoxView.centerYAnchor),
        ])
        
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
    
    @objc private func handleTap() {
        progressPercentage = 0.75
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    
        basicAnimation.toValue = progressPercentage
        basicAnimation.duration = 2
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        let percentageAnimation = CABasicAnimation(keyPath: "string")
        percentageAnimation.fromValue = precentageLabel.text ?? "0%"
        percentageAnimation.toValue = "\(Int(progressPercentage * 100))%"
        percentageAnimation.duration = 2
        percentageAnimation.fillMode = CAMediaTimingFillMode.forwards
        percentageAnimation.isRemovedOnCompletion = false
        precentageLabel.layer.add(percentageAnimation, forKey: "updateText")
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
    }
    
    
}
