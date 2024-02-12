//
//  NutritionViewController.swift
//  DzliEra
//
//  Created by Levan Loladze on 10.02.24.
//

import UIKit

// MARK: - NutritionViewController
final class NutritionViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel = NutritionViewModel()
    
    private let nutritionNameLabel: UILabel = {
        let label = NutritionLabelComponent(text: "Egg")
        label.textAlignment = .center
        return label
    }()
    
    private let caloriesLabel: UILabel = {
        let label = NutritionLabelComponent(text: "Calories:")
        label.textAlignment = .left
        return label
    }()
    
    private let proteinLabel: UILabel = {
        let label = NutritionLabelComponent(text: "Proteins:")
        label.textAlignment = .left
        return label
    }()
    
    private let totalFatLabel: UILabel = {
        let label = NutritionLabelComponent(text: "TotalFatG:")
        label.textAlignment = .left
        return label
    }()
    
    private let totalSugarLabel: UILabel = {
        let label = NutritionLabelComponent(text: "Sugar:")
        label.textAlignment = .left
        return label
    }()
    
    
    private let nutritionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Methods
    private func setupUI() {
        view.backgroundColor = UIColor(AppColors.backgroundColor)
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        setupNutritionNameLabel()
        setupNutritionImageView()
        setupNutritionLabels()
    }
    
    private func setupNutritionNameLabel() {
        view.addSubview(nutritionNameLabel)
        nutritionImageView.layer.shadowColor = UIColor.black.cgColor
        nutritionImageView.layer.shadowOpacity = 0.5
        nutritionImageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        nutritionImageView.layer.shadowRadius = 4
        
        nutritionImageView.layer.shadowPath = UIBezierPath(rect: nutritionImageView.bounds).cgPath
        nutritionImageView.layer.shouldRasterize = true
        nutritionImageView.layer.rasterizationScale = UIScreen.main.scale
        
        NSLayoutConstraint.activate([
            nutritionNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            nutritionNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nutritionNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupNutritionImageView() {
        view.addSubview(nutritionImageView)
        
        nutritionImageView.image = UIImage(named: "kvercxi")
        
        NSLayoutConstraint.activate([
            nutritionImageView.topAnchor.constraint(equalTo: nutritionNameLabel.bottomAnchor, constant: 20),
            nutritionImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nutritionImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nutritionImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
    }
    
    private func setupNutritionLabels() {
        view.addSubview(caloriesLabel)
        
        view.addSubview(proteinLabel)
        
        view.addSubview(totalFatLabel)
        
        view.addSubview(totalSugarLabel)
        
        NSLayoutConstraint.activate([
            caloriesLabel.topAnchor.constraint(equalTo: nutritionImageView.bottomAnchor, constant: 20),
            caloriesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            caloriesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            proteinLabel.topAnchor.constraint(equalTo: caloriesLabel.bottomAnchor, constant: 12),
            proteinLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            proteinLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            totalFatLabel.topAnchor.constraint(equalTo: proteinLabel.bottomAnchor, constant: 12),
            totalFatLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            totalFatLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            totalSugarLabel.topAnchor.constraint(equalTo: totalFatLabel.bottomAnchor, constant: 12),
            totalSugarLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            totalSugarLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
    }
    
}

extension NutritionViewController: UISearchBarDelegate {
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        guard let searchText = searchBar.text else { return true }
        
        viewModel.fetchNutritionData(for: searchText) { nutritionData in
            guard let nutritionData = nutritionData else {
                
                return
            }
            DispatchQueue.main.async {
                self.updateNutritionLabel(with: nutritionData)
            }
        }
        
        
        viewModel.fetchImageData(for: searchText) { imageData in
            guard let url = URL(string: self.viewModel.imageUrl) else {
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let error = error {
                    print("Error downloading image: \(error)")
                    return
                }
                
                guard let data = data, let image = UIImage(data: data) else {
                    print("Invalid image data")
                    return
                }
                
                DispatchQueue.main.async {
                    self.nutritionImageView.image = image
                }
            }.resume()
        }
        
        searchBar.resignFirstResponder()
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    private func updateNutritionLabel(with nutritionData: [NutritionModel]) {
        guard let firstNutrition = nutritionData.first else {
            return
        }
        nutritionNameLabel.text = "\(firstNutrition.name)"
        caloriesLabel.text =  "Calories: \(firstNutrition.calories)"
        proteinLabel.text = "Proteins: \(firstNutrition.proteinG)"
        totalFatLabel.text = "TotalFat: \(firstNutrition.fatTotalG)"
        totalSugarLabel.text = "Sugar: \(firstNutrition.sugarG)"
    }
    
    
}

