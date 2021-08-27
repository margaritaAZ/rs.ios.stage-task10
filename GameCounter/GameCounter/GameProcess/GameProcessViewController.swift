//
//  GameProcessViewController.swift
//  GameCounter
//
//  Created by Маргарита Жучик on 27.08.21.
//

import UIKit

class GameProcessViewController: UIViewController {
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

extension GameProcessViewController {
    func setupViews() {
        navigationItem.leftBarButtonItem = newGameButton
        navigationItem.rightBarButtonItem = resultsButton
        navigationController?.title = "Game"
        
        newGameButton.target = self
        newGameButton.action = #selector(goToNewGameScreen)
    }
    
    @objc func goToNewGameScreen() {
        navigationController?.popToRootViewController(animated: true)
    }
}
