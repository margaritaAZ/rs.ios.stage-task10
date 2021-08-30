//
//  AddPlayerViewController.swift
//  GameCounter
//
//  Created by Маргарита Жучик on 26.08.21.
//

import UIKit

class AddPlayerViewController: UIViewController {
    
    private let backButton: UIBarButtonItem = {
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        return backButton
    }()
    
    private let addButton: UIBarButtonItem = {
        let addButton = UIBarButtonItem()
        addButton.title = "Add"
        addButton.isEnabled = false
        return addButton
    }()
    
    private let viewTitle: UILabel = {
        let title = UILabel()
        title.text = "Add Player"
        title.textColor = .white
        title.font = UIFont.nunito(36, .extraBold)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let playerName: UITextField = {
        let name = UITextField()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.attributedPlaceholder = NSAttributedString(string: "Player Name",
                                                        attributes: [.font: UIFont.nunito(20, .extraBold),
                                                                     NSAttributedString.Key.foregroundColor: UIColor(red: 0.608, green: 0.608, blue: 0.631, alpha: 1)])
        name.textColor = .white
        name.font = UIFont.nunito(20, .extraBold)
        name.backgroundColor = UIColor.veryDarkGray
        name.tintColor = .white
        
        name.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: name.frame.height))
        name.leftViewMode = .always
        name.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: name.frame.height))
        name.rightViewMode = .always
        name.keyboardAppearance = .dark
        name.becomeFirstResponder()
        return name
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerName.delegate = self
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
        setupViews()
    }
}

private extension AddPlayerViewController {
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func setupViews() {
        backButton.action = #selector(backToPlayersList)
        backButton.target = self
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = addButton
        addButton.target = self
        addButton.action = #selector(addPlayer)
        
        view.addSubview(viewTitle)
        view.addSubview(playerName)
        NSLayoutConstraint.activate([
            viewTitle.topAnchor.constraint(equalTo: view.topAnchor),
            viewTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            playerName.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 20),
            playerName.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerName.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerName.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func backToPlayersList() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func addPlayer() {
        var playersArray = Players().getFromStorage()
        if playersArray != nil {
            playersArray?.append(Player(name: playerName.text ?? "Name"))
        } else {
            playersArray = [Player(name: playerName.text ?? "Name")]
        }
        
        Players().saveToStorage(players: playersArray)
        
        navigationController?.popToRootViewController(animated: true)
        
    }
}

// MARK: UITextFieldDelegate
extension AddPlayerViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return true
        }
        
        if text.count == 1 && string.count == 0 {
            addButton.isEnabled = false
        } else {
            addButton.isEnabled = true
        }
        return true
    }
}
