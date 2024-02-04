//
//  RoutineDetailViewController.swift
//  DzliEra
//
//  Created by Levan Loladze on 24.01.24.
//

import UIKit

class RoutineDetailViewController: UIViewController {

    
    var routine: Routine? {
        didSet {
            updateUI()
        }
    }
    
    private let titleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 20)
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    private let exercisesTableView: UITableView = {
           let tableView = UITableView()
           tableView.translatesAutoresizingMaskIntoConstraints = false
           tableView.backgroundColor = .black
           return tableView
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
                setupTitleLabel()
                updateUI()
        setupExercisesTableView()
    }
    
    private func setupTitleLabel() {
           view.addSubview(titleLabel)
           
           NSLayoutConstraint.activate([
               titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
               titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
               titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
           ])
       }
    
    private func setupExercisesTableView() {
            view.addSubview(exercisesTableView)
            
            exercisesTableView.delegate = self
            exercisesTableView.dataSource = self
            exercisesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "ExerciseCell")

            NSLayoutConstraint.activate([
                exercisesTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
                exercisesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                exercisesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                exercisesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    
    

       private func updateUI() {
           guard let routine = routine else { return }
           titleLabel.text = routine.title
           exercisesTableView.reloadData()
       }
    

}


extension RoutineDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routine?.exercises.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath)
        
        if let exercise = routine?.exercises[indexPath.row] {
            cell.textLabel?.text = exercise.name
            cell.textLabel?.textColor = .white
            cell.backgroundColor = .black
        }
        
        return cell
    }
}
