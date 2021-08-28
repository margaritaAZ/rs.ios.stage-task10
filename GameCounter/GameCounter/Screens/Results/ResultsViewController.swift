//
//  ResultsViewController.swift
//  GameCounter
//
//  Created by Маргарита Жучик on 28.08.21.
//

import UIKit

class ResultsViewController: UIViewController {
    
    private let newGameButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "New Game"
        return button
    }()
    
    private let resumeButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "Resume"
        return button
    }()
    
    private let ratingTableView = RatingTableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ratingTableView.cells = Players().getFromStorage() ?? []
        setupNavigationBarItems()
        setupViews()
    }
}

extension ResultsViewController {
    func setupNavigationBarItems() {
        navigationItem.title = "Results"
        navigationItem.leftBarButtonItem = newGameButton
        newGameButton.target = self
        newGameButton.action = #selector(openNewGameScreen)
        
        navigationItem.rightBarButtonItem = resumeButton
        resumeButton.target = self
        resumeButton.action = #selector(openGameProcess)
    }
    
    func setupViews() {
        view.addSubview(ratingTableView)
        
        NSLayoutConstraint.activate([
            ratingTableView.topAnchor.constraint(equalTo: view.topAnchor),
            ratingTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ratingTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            ratingTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
        
    }
    
    @objc func openNewGameScreen() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func openGameProcess() {
        navigationController?.popViewController(animated: true)
    }
}
