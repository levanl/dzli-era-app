//
//  NutritionViewController.swift
//  DzliEra
//
//  Created by Levan Loladze on 10.02.24.
//

import UIKit

class NutritionViewController: UIViewController {
    
    private let viewModel = NutritionViewModel()
    
    private let nutritionNameLabel: UILabel = {
        let label = UILabel()
        label.text = "heyap"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nutritionImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    }
    
    private func setupNutritionNameLabel() {
        view.addSubview(nutritionNameLabel)
        
        NSLayoutConstraint.activate([
            nutritionNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            nutritionNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nutritionNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}

extension NutritionViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        
        //        viewModel.fetchImageData(for: searchText)
        searchBar.resignFirstResponder()
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        guard let searchText = searchBar.text else { return true }
        viewModel.fetchNutritionData(for: searchText) { nutritionData in
            guard let nutritionData = nutritionData else {
                // Handle case when no data is available
                return
            }
            DispatchQueue.main.async {
                self.updateNutritionLabel(with: nutritionData)
            }
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
        nutritionNameLabel.text = "Name: \(firstNutrition.name)\nCalories: \(firstNutrition.calories)"
    }
    
    
}

