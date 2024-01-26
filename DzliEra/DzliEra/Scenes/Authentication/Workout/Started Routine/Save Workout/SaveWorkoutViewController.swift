//
//  SaveWorkoutViewController.swift
//  DzliEra
//
//  Created by Levan Loladze on 26.01.24.
//

import UIKit

class SaveWorkoutViewController: UIViewController {
    private let libraryImages: [UIImage] = []
    
    private let durationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Duration"
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let volumeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Reps"
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let setsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Sets"
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let workoutInfoStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "0 KG"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let repsCounterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "0"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let setCounterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "0"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let workoutInfoCounterStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.addSolidBorder()
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "photo")
        imageView.tintColor = .white
        return imageView
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setupWorkoutInfoStack()
        setupWorkoutInfoCounterStack()
        setupImageContainerPicker()
        setupCollectionView()
    }
    
    
    
    private func setupWorkoutInfoStack() {
        view.addSubview(workoutInfoStack)
        
        workoutInfoStack.addArrangedSubview(durationLabel)
        workoutInfoStack.addArrangedSubview(volumeLabel)
        workoutInfoStack.addArrangedSubview(setsLabel)
        
        NSLayoutConstraint.activate([
            workoutInfoStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            workoutInfoStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            workoutInfoStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupWorkoutInfoCounterStack() {
        view.addSubview(workoutInfoCounterStack)
        
        workoutInfoCounterStack.addArrangedSubview(timerLabel)
        workoutInfoCounterStack.addArrangedSubview(repsCounterLabel)
        workoutInfoCounterStack.addArrangedSubview(setCounterLabel)
        
        NSLayoutConstraint.activate([
            workoutInfoCounterStack.topAnchor.constraint(equalTo: workoutInfoStack.bottomAnchor, constant: 8),
            workoutInfoCounterStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            workoutInfoCounterStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
    }
    
    private func setupImageContainerPicker() {
        
        view.addSubview(container)
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: workoutInfoStack.bottomAnchor, constant: 50),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            container.widthAnchor.constraint(equalToConstant: 130),
            container.heightAnchor.constraint(equalToConstant: 130),
        ])
        
        container.addSubview(iconImageView)
        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.3),
            iconImageView.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.3),
        ])
    }
    
    private func setupCollectionView() {
        
        view.addSubview(collectionView)
        
        collectionView.register(SaveCollectionViewCell.self, forCellWithReuseIdentifier: "SaveCell")
        
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: workoutInfoStack.bottomAnchor, constant: 30),
            collectionView.leadingAnchor.constraint(equalTo: container.trailingAnchor, constant: 30),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension SaveWorkoutViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SaveCell", for: indexPath) as! SaveCollectionViewCell
        //                cell.imageView.image = libraryImages[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
}



extension UIView {
    func addDashedBorder() {
        let color = UIColor.red.cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
}


extension UIView {
    func addSolidBorder() {
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = 8
    }
}

