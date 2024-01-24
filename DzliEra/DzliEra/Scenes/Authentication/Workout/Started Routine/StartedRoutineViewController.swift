//
//  StartedRoutineViewController.swift
//  DzliEra
//
//  Created by Levan Loladze on 24.01.24.
//

import UIKit

class StartedRoutineViewController: UIViewController {
    
    var routine: Routine?
    var timer: Timer?
    var elapsedTime: TimeInterval = 0
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupTimerLabel()
        startTimer()
    }
    
    deinit {
        stopTimer()
        print("aiufuisa")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopTimer()
    }

    
    private func setupTimerLabel() {
        view.addSubview(timerLabel)
        
        NSLayoutConstraint.activate([
            timerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            timerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            timerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateTimer()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func updateTimer() {
        elapsedTime += 1
        updateUI()
    }
    
    private func updateUI() {
        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60
        
        let formattedTime = String(format: "%02d:%02d", minutes, seconds)
        timerLabel.text = "Time: \(formattedTime)"
        print(elapsedTime)
    }
}
