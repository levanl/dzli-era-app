//
//  StartedRoutineViewController.swift
//  DzliEra
//
//  Created by Levan Loladze on 24.01.24.
//

import UIKit

// MARK: - StartedRoutineViewController
final class StartedRoutineViewController: UIViewController {
    
    // MARK: - Properties
    var routine: Routine?
    
    var viewModel = StartedRoutineViewModel()
    
    private let durationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Duration"
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private var isFinishButtonEnabled: Bool = false {
        didSet {
            navigationItem.rightBarButtonItem?.isEnabled = isFinishButtonEnabled
        }
    }
    
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
        let label = SaveWorkoutLabelComponent(frame: .zero, text: "0", textColor: .white)
        return label
    }()
    
    private let repsCounterLabel: UILabel = {
        let label = SaveWorkoutLabelComponent(frame: .zero, text: "0", textColor: .white)
        return label
    }()
    
    private let setCounterLabel: UILabel = {
        let label = SaveWorkoutLabelComponent(frame: .zero, text: "0", textColor: .white)
        return label
    }()
    
    private let workoutInfoCounterStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 255/255, green: 253/255, blue: 208/255, alpha: 1.0) // Cream color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    deinit {
        stopTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopTimer()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(AppColors.backgroundColor)
        
        let finishButton = UIBarButtonItem(title: "Finish", style: .plain, target: self, action: #selector(finishButtonTapped))
        navigationItem.rightBarButtonItem = finishButton
        isFinishButtonEnabled = false
        startTimer()
        setupWorkoutInfoStack()
        setupWorkoutInfoCounterStack()
        setupStackSeparator()
        setupTableView()
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
    
    private func setupStackSeparator() {
        
        view.addSubview(stackSeparatorView)
        
        NSLayoutConstraint.activate([
            stackSeparatorView.topAnchor.constraint(equalTo: workoutInfoCounterStack.bottomAnchor, constant: 30),
            stackSeparatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackSeparatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackSeparatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.register(StartedWorkoutTableViewCell.self, forCellReuseIdentifier: "StartedExerciseCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: stackSeparatorView.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func startTimer() {
        viewModel.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateTimer()
        }
    }
    
    func stopTimer() {
        viewModel.timer?.invalidate()
        viewModel.timer = nil
    }
    
    @objc func updateTimer() {
        viewModel.elapsedTime += 1
        updateTimerLabel()
    }
    
    private func updateFinishButtonState() {
        if viewModel.elapsedTime > 0 && viewModel.totalSets > 0 && viewModel.totalReps > 0 {
            isFinishButtonEnabled = true
        } else {
            isFinishButtonEnabled = false
        }
    }
    
    private func updateTimerLabel() {
        let minutes = viewModel.elapsedTime / 60
        let seconds = viewModel.elapsedTime % 60
        
        let timerText: String
        
        if minutes > 0 {
            timerText = String(format: "%dmin %02ds", minutes, seconds)
        } else {
            timerText = String(format: "%ds", seconds)
        }
        timerLabel.text = timerText
    }
    
    @objc private func finishButtonTapped() {
        let saveWorkoutVC = SaveWorkoutViewController()
        
        saveWorkoutVC.elapsedTime = viewModel.elapsedTime
        saveWorkoutVC.totalSets = viewModel.totalSets
        saveWorkoutVC.totalReps = viewModel.totalReps
        saveWorkoutVC.exercises = routine?.exercises ?? []
        
        navigationController?.pushViewController(saveWorkoutVC, animated: true)
        print("Finish button tapped")
    }
}


extension StartedRoutineViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        routine?.exercises.count ?? 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StartedExerciseCell", for: indexPath) as! StartedWorkoutTableViewCell
        cell.delegate = self
        
        if let exercise = routine?.exercises[indexPath.row] {
            cell.configure(with: exercise)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
}

// MARK: - StartedWorkoutTableViewCellDelegate
extension StartedRoutineViewController: StartedWorkoutTableViewCellDelegate {
    func updateValues(in cell: StartedWorkoutTableViewCell, with sets: Int, reps: Int) {
        if cell.isSelected {
            viewModel.totalSets += sets
            viewModel.totalReps += reps
            print(sets)
            
        } else {
            viewModel.totalSets -= sets
            viewModel.totalReps -= reps
            print(sets)
            
        }
        repsCounterLabel.text = String(viewModel.totalReps)
        setCounterLabel.text = String(viewModel.totalSets)
        updateFinishButtonState()
    }
}
