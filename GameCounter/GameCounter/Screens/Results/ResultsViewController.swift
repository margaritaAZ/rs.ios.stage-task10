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
    
    private let viewTitle: UILabel = {
            let title = UILabel()
            title.text = "Results"
            title.textColor = .white
            title.font = UIFont(name: "Nunito-ExtraBold", size: 36)
            title.translatesAutoresizingMaskIntoConstraints = false
            return title
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
        navigationItem.leftBarButtonItem = newGameButton
        newGameButton.target = self
        newGameButton.action = #selector(openNewGameScreen)
        
        navigationItem.rightBarButtonItem = resumeButton
        resumeButton.target = self
        resumeButton.action = #selector(openGameProcess)
    }
    
    func setupViews() {
        view.addSubview(viewTitle)
        view.addSubview(ratingTableView)
        
        NSLayoutConstraint.activate([
            viewTitle.topAnchor.constraint(equalTo: view.topAnchor),
            viewTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ratingTableView.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 15),
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
