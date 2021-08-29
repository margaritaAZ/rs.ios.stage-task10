//
//  GameProcessViewController.swift
//  GameCounter
//
//  Created by Маргарита Жучик on 27.08.21.
//

import UIKit

class GameProcessViewController: UIViewController {
    private var playersArray = Players().getFromStorage() ?? []
    private let scoreValues = ["-10", "-5", "-1", "+5", "+10"]
    
    private let newGameButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "New Game"
        return button
    }()
    
    private let resultsButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "Results"
        return button
    }()
    
    private let viewTitle: UILabel = {
            let title = UILabel()
            title.text = "Game"
            title.textColor = .white
            title.font = UIFont(name: "Nunito-ExtraBold", size: 36)
            title.translatesAutoresizingMaskIntoConstraints = false
            return title
        }()
    
    private let diceButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "dice"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Nunito-ExtraBold", size: 28)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        return label
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.setImage(UIImage(named: "play"), for: .normal)
        return button
    }()
    
    private let pauseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "pause"), for: .normal)
        return button
    }()
    
    private var timer: Timer?
    private var timerStart = Date()
    
    private let playersCollectionView = PlayersCollectionView()
    
    private let plusOneButton: CircleButton = {
       let button = CircleButton()
        button.setTitle("+1", for: .normal)
        button.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 40)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 45
        return button
    }()
    
    private let undoButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "undo"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let playersLettersLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Nunito-ExtraBold", size: 20)
        label.textColor = UIColor(named: "DarkGray")
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let scoreButtonsStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let diceView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.clear
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = UIScreen.main.bounds
        return view
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItems()
        setupViews()
        setupPlayersLettersLabel()
        setupTimer()
        setupScoreButtons()
        playersCollectionView.cells = playersArray
        diceButton.addTarget(self, action: #selector(openDiceScreen), for: .touchUpInside)
    }
}

extension GameProcessViewController {
    private func setupTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1.0,
                                         target: self,
                                         selector: #selector(updateTimer),
                                         userInfo: nil,
                                         repeats: true)
            timerStart = Date()
        }
    }
    
    @objc func updateTimer() {
        let time = Date().timeIntervalSince(timerStart)
        
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        var times: [String] = []
        if minutes < 10 {
            times.append("0\(minutes)")
        } else {
            times.append("\(minutes)")
        }
        if seconds < 10 {
            times.append("0\(seconds)")
        } else {
            times.append("\(seconds)")
        }
        timerLabel.text = times.joined(separator: ":")
    }
    
    private func setupPlayersLettersLabel() {
        var letters = [String]()
        for player in playersArray {
            letters.append(String(player.name[player.name.startIndex]))
        }
        playersLettersLabel.text = letters.joined(separator: " ")
    }
    
    private func setupScoreButtons() {
        for (i, value) in scoreValues.enumerated() {
            let button = CircleButton()
            button.layer.cornerRadius = 55/2
            button.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 25)
            button.tag = i
            button.setTitle(value, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 55).isActive = true
            button.widthAnchor.constraint(equalToConstant: 55).isActive = true
            scoreButtonsStackView.addArrangedSubview(button)
        }
        
    }
    
    private func setupNavigationBarItems() {
        navigationItem.leftBarButtonItem = newGameButton
        navigationItem.rightBarButtonItem = resultsButton

        newGameButton.target = self
        newGameButton.action = #selector(openNewGameScreen)
        
        resultsButton.target = self
        resultsButton.action = #selector(openResults)
    }
    
    private func setupViews() {
        view.addSubview(viewTitle)
        view.addSubview(diceButton)
        view.addSubview(timerLabel)
        view.addSubview(playButton)
        view.addSubview(pauseButton)
        view.addSubview(playersCollectionView)
//        view.addSubview(plusOneButton)
        view.addSubview(undoButton)
        view.addSubview(playersLettersLabel)
        view.addSubview(scoreButtonsStackView)
//        view.addSubview(diceView)
//        view.bringSubviewToFront(diceView)

        NSLayoutConstraint.activate([
            viewTitle.topAnchor.constraint(equalTo: view.topAnchor),
            viewTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            diceButton.centerYAnchor.constraint(equalTo: viewTitle.centerYAnchor),
            diceButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            timerLabel.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 20),
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.leadingAnchor.constraint(equalTo: timerLabel.trailingAnchor, constant: 28),
            playButton.centerYAnchor.constraint(equalTo: timerLabel.centerYAnchor),
            pauseButton.leadingAnchor.constraint(equalTo: timerLabel.trailingAnchor, constant: 28),
            pauseButton.centerYAnchor.constraint(equalTo: timerLabel.centerYAnchor),
            playersCollectionView.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 42),
            playersCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playersCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playersCollectionView.heightAnchor.constraint(equalToConstant: 300),
//            plusOneButton.topAnchor.constraint(equalTo: playersCollectionView.bottomAnchor, constant: 28),
//            plusOneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            plusOneButton.widthAnchor.constraint(equalToConstant: 90),
//            plusOneButton.heightAnchor.constraint(equalToConstant: 90),
            undoButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            undoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            playersLettersLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            playersLettersLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scoreButtonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scoreButtonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scoreButtonsStackView.bottomAnchor.constraint(equalTo: playersLettersLabel.topAnchor, constant: -20)
        ])
    }
    
    @objc func openNewGameScreen() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func openResults() {
        navigationController?.pushViewController(ResultsViewController(), animated: true)
    }
    
    @objc func openDiceScreen() {
        let rollVC = RollViewController()
        rollVC.modalPresentationStyle = .overCurrentContext
        rollVC.modalTransitionStyle = .crossDissolve
        present(rollVC, animated: true, completion: nil)
    }
}
