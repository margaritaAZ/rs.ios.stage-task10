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
        title.font = UIFont.nunito(36, .extraBold)
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
        label.font = UIFont.nunito(28, .extraBold)
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
    private var prevTimerValue = TimeInterval()
    
    private let playersCollectionView = PlayersCollectionView()
    
    private let plusOneButton: CircleButton = {
        let button = CircleButton()
        button.setTitle("+1", for: .normal)
        button.titleLabel?.font = UIFont.nunito(40, .extraBold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 45
        button.tag = -1
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
        label.font = UIFont.nunito(20, .extraBold)
        label.textColor = UIColor.veryDarkGray
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
    
    private let previuosButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "previous"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "next"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let line: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItems()
        setupViews()
        setupPlayersLettersLabel(activePlayer: 0)
        startTimer()
        setupScoreButtons()
        playersCollectionView.cells = playersArray
        setupActions()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        plusOneButton.layer.cornerRadius = plusOneButton.frame.height/2
        for view in scoreButtonsStackView.arrangedSubviews{
            if let button = view as? UIButton{
                button.layer.cornerRadius = button.frame.height/2
            }
        }
    }
}

private extension GameProcessViewController {
    func setupActions() {
        pauseButton.addTarget(self, action: #selector(pauseTimer), for: .touchUpInside)
        playButton.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        diceButton.addTarget(self, action: #selector(openDiceScreen), for: .touchUpInside)
        previuosButton.addTarget(self, action: #selector(scrollToPrevious), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(scrollToNext), for: .touchUpInside)
        plusOneButton.addTarget(self, action: #selector(addPoints), for: .touchUpInside)
    }
    
    @objc func startTimer() {
        timerLabel.textColor = .white
        pauseButton.isHidden = false
        playButton.isHidden = true
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: true)
        timerStart = Date()
        prevTimerValue = getTimerFromStorage() ?? TimeInterval()
    }
    
    @objc func updateTimer() {
        let time = Date().timeIntervalSince(timerStart) + prevTimerValue
        
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
    
    @objc func pauseTimer() {
        timer?.invalidate()
        saveTimerToStorage()
        timerLabel.textColor = UIColor.veryDarkGray
        pauseButton.isHidden = true
        playButton.isHidden = false
    }
    
    private func saveTimerToStorage() {
        let time = Date().timeIntervalSince(timerStart).rounded(.down) + prevTimerValue.rounded(.down)
        UserDefaults.standard.set(time, forKey: "timer")
    }
    
    private func getTimerFromStorage() -> TimeInterval? {
        return UserDefaults.standard.double(forKey: "timer")
        
    }
    
    @objc func addPoints(sender: UIButton) {
        let playerIndex = playersCollectionView.getActivePlayerIndex()
        let playerTurns = playersArray[playerIndex].turns
        let points = sender.tag != -1 ? (Int(scoreValues[sender.tag]) ?? 0) : 1
        
        if playerTurns == nil {
            playersArray[playerIndex].turns = [points]
        } else {
            playersArray[playerIndex].turns?.append(points)
        }
        
        playersArray[playerIndex].updateScore()
        Players().saveToStorage(players: playersArray)
        playersCollectionView.reloadItems(at: [IndexPath(row: playerIndex, section: 0)])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.scrollToNext()
        }
    }
    
    @objc func scrollToPrevious() {
        let playerIndex = playersCollectionView.getActivePlayerIndex()
        var nextActive = 0
        if playerIndex == 0 {
            nextActive = playersArray.count - 1
        } else {
            nextActive = playerIndex - 1
        }
        playersCollectionView.scrollToItem(nextActive)
        setupPlayersLettersLabel(activePlayer: nextActive)
    }
    
    @objc func scrollToNext() {
        let playerIndex = playersCollectionView.getActivePlayerIndex()
        var nextActive = 0
        
        if playerIndex == playersArray.count - 1 {
            nextActive = 0
        } else {
            nextActive = playerIndex + 1
        }
        playersCollectionView.scrollToItem(nextActive)
        setupPlayersLettersLabel(activePlayer: nextActive)
    }
    
    private func setupPlayersLettersLabel(activePlayer: Int) {
        var letters = [String]()
        var whiteColorIndex = 0
        for (i, player) in playersArray.enumerated() {
            letters.append(String(player.name[player.name.startIndex]))
            if i == activePlayer {
                whiteColorIndex = i*2
            }
        }
        let attributedString = NSMutableAttributedString(string: letters.joined(separator: " "), attributes: [.foregroundColor: UIColor.veryDarkGray])
        attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: whiteColorIndex, length: 1))
        playersLettersLabel.attributedText = attributedString

    }
    
    private func setupScoreButtons() {
        for (i, value) in scoreValues.enumerated() {
            let button = CircleButton()
            button.layer.cornerRadius = 55/2
            button.titleLabel?.font = UIFont.nunito(25, .extraBold)
            button.tag = i
            button.setTitle(value, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 55).isActive = true
            button.widthAnchor.constraint(equalTo: button.heightAnchor).isActive = true
            button.addTarget(self, action: #selector(addPoints), for: .touchUpInside)
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
        view.addSubview(plusOneButton)
        view.addSubview(previuosButton)
        view.addSubview(nextButton)
        view.addSubview(undoButton)
        view.addSubview(playersLettersLabel)
        view.addSubview(scoreButtonsStackView)
        
        NSLayoutConstraint.activate([
            viewTitle.topAnchor.constraint(equalTo: view.topAnchor),
            viewTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            diceButton.centerYAnchor.constraint(equalTo: viewTitle.centerYAnchor),
            diceButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            timerLabel.topAnchor.constraint(lessThanOrEqualTo: viewTitle.bottomAnchor, constant: GameProcessConstants.timerToTitle),
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.leadingAnchor.constraint(equalTo: timerLabel.trailingAnchor, constant: 28),
            playButton.centerYAnchor.constraint(equalTo: timerLabel.centerYAnchor),
            pauseButton.leadingAnchor.constraint(equalTo: timerLabel.trailingAnchor, constant: 28),
            pauseButton.centerYAnchor.constraint(equalTo: timerLabel.centerYAnchor),
            playersCollectionView.topAnchor.constraint(lessThanOrEqualTo: timerLabel.bottomAnchor, constant: GameProcessConstants.playersToTimer),
            playersCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playersCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            plusOneButton.topAnchor.constraint(equalTo: playersCollectionView.bottomAnchor, constant: GameProcessConstants.bigScoreButtonToPlayers),
            plusOneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plusOneButton.widthAnchor.constraint(equalToConstant: 90),
            plusOneButton.heightAnchor.constraint(equalTo: plusOneButton.widthAnchor),
            previuosButton.centerYAnchor.constraint(equalTo: plusOneButton.centerYAnchor),
            previuosButton.trailingAnchor.constraint(equalTo: plusOneButton.leadingAnchor, constant: -60),
            nextButton.centerYAnchor.constraint(equalTo: plusOneButton.centerYAnchor),
            nextButton.leadingAnchor.constraint(equalTo: plusOneButton.trailingAnchor, constant: 60),
            undoButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            undoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            playersLettersLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -GameProcessConstants.playersLettersToBottom),
            playersLettersLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scoreButtonsStackView.topAnchor.constraint(equalTo: plusOneButton.bottomAnchor, constant: 15),
            scoreButtonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scoreButtonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scoreButtonsStackView.bottomAnchor.constraint(equalTo: playersLettersLabel.topAnchor, constant: -GameProcessConstants.playersLettersToSmallButtons)
            //            line.topAnchor.constraint(equalTo: view.topAnchor),
            //            line.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            //            line.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //            line.widthAnchor.constraint(equalToConstant: 1)
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
