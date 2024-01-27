//
//  SaveWorkoutViewController.swift
//  DzliEra
//
//  Created by Levan Loladze on 26.01.24.
//

import UIKit

class SaveWorkoutViewController: UIViewController {
    private var libraryImages: [UIImage] = [UIImage(named: "onboarding1")!]
    
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
    
    private let addImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Image", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(AppColors.gray)
        button.layer.cornerRadius = 6
        return button
    }()
    
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
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
        setupAddImageButton()
        setupImageCollectionView()
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
    
    private func setupAddImageButton() {
        view.addSubview(addImageButton)
        
        addImageButton.addTarget(self, action: #selector(addImageButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            addImageButton.topAnchor.constraint(equalTo: workoutInfoCounterStack.bottomAnchor, constant: 24),
            addImageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            addImageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
        
    }
    
    private func setupImageCollectionView() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(SaveCollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: addImageButton.bottomAnchor, constant: 24),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    @objc private func addImageButtonTapped() {
        showImagePicker()
    }
    
    private func showImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
}

extension SaveWorkoutViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            libraryImages.append(selectedImage)
            collectionView.reloadData()
        } else { }
        dismiss(animated: true)
    }
    
}

extension SaveWorkoutViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        libraryImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! SaveCollectionViewCell
        cell.configureCell(with: libraryImages[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 200, height: 200)
        }
}



class MyCollectionViewCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
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

