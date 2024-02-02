//
//  SaveWorkoutViewController.swift
//  DzliEra
//
//  Created by Levan Loladze on 26.01.24.
//

import UIKit
import SwiftUI

class SaveWorkoutViewController: UIViewController {
    private var libraryImages: [UIImage] = []
    var elapsedTime: Int = 0
    var totalSets: Int = 0
    var totalReps: Int = 0
    
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
        label.text = "0"
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
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .black
        return collectionView
    }()
    
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No images available"
        label.textAlignment = .center
        label.textColor = .gray
        label.isHidden = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Description"
        label.textAlignment = .left
        label.textColor = .gray
        label.isHidden = false
        return label
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = .white
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.backgroundColor = UIColor.black
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.cornerRadius = 8
        return textView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        label.textAlignment = .left
        label.textColor = .gray
        label.isHidden = false
        return label
    }()
    
    private let titleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = .white
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.backgroundColor = UIColor.black
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.cornerRadius = 8
        return textView
    }()
    
    private let discardWorkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Discard Workout", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 16)
        button.setTitleColor(.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.layer.cornerRadius = 6
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let finishButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(finishButtonTapped))
        navigationItem.rightBarButtonItem = finishButton
        view.backgroundColor = .black
        updateInfoLabels()
        setupWorkoutInfoStack()
        setupWorkoutInfoCounterStack()
        setupAddImageButton()
        setupImageCollectionView()
        setupDescriptionTextView()
        setupTitleTextView()
        setupDiscardWorkoutButton()
    }
    
    private func updateInfoLabels() {
        let minutes = elapsedTime / 60
        let seconds = elapsedTime % 60
        
        let timerText: String
        if minutes > 0 {
            timerText = String(format: "%dmin %02ds", minutes, seconds)
        } else {
            timerText = String(format: "%ds", seconds)
        }
        
        timerLabel.text = timerText
        repsCounterLabel.text = "\(totalReps)"
        setCounterLabel.text = "\(totalSets)"
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
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 140)
        ])
        
        view.addSubview(emptyLabel)
        NSLayoutConstraint.activate([
            emptyLabel.topAnchor.constraint(equalTo: collectionView.topAnchor),
            emptyLabel.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            emptyLabel.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            emptyLabel.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor)
        ])
        
    }
    
    private func setupDescriptionTextView() {
        
        view.addSubview(descriptionLabel)
        
        view.addSubview(descriptionTextView)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func setupTitleTextView() {
        
        view.addSubview(titleLabel)
        
        view.addSubview(titleTextView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            titleTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            titleTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleTextView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupDiscardWorkoutButton() {
        view.addSubview(discardWorkoutButton)
        
        NSLayoutConstraint.activate([
            discardWorkoutButton.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: 24),
            discardWorkoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16),
            discardWorkoutButton.leadingAnchor  .constraint(equalTo: view.leadingAnchor, constant: -16)
        ])
        
        discardWorkoutButton.addTarget(self, action: #selector(discardButtonTapped), for: .touchUpInside)
        
    }
    
    @objc private func addImageButtonTapped() {
        showImagePicker()
    }
    
    @objc private func finishButtonTapped() {
        let title = titleTextView.text ?? ""
        let workout = DoneWorkout(title: title, elapsedTime: elapsedTime, totalReps: totalReps, images: libraryImages)
        
        
        self.navigationController?.present(UIHostingController(rootView: NiceJobView(workout: workout)), animated: true)

            print("finish")
    }
    
    @objc private func discardButtonTapped() {
        let alertController = UIAlertController(
            title: "Discard Workout",
            message: "Are you sure you want to discard this workout?",
            preferredStyle: .alert
        )
        
        let discardAction = UIAlertAction(title: "Discard", style: .destructive) { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(discardAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
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
            if libraryImages.isEmpty {
                emptyLabel.isHidden = false
            } else {
                emptyLabel.isHidden = true
            }
            collectionView.reloadData()
        } else { }
        dismiss(animated: true)
    }
    
}

extension SaveWorkoutViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        libraryImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! SaveCollectionViewCell
        cell.configureCell(with: libraryImages[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }
}



struct DoneWorkout {
    var title: String
    var elapsedTime: Int
    var totalReps: Int
    var images: [UIImage]
}
