//
//  NewGameViewController.swift
//  GameCounter
//
//  Created by Маргарита Жучик on 25.08.21.
//

import UIKit

class NewGameViewController: UIViewController {
    
    var players: [String]?
    
    private let viewTitle: UILabel = {
        let title = UILabel()
        title.text = "Game Counter"
        title.textColor = .white
        title.font = UIFont(name: "Nunito-ExtraBold", size: 36)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private let playersTable: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .black
        table.layer.cornerRadius = 15
        table.separatorColor = UIColor(red: 0.333, green: 0.333, blue: 0.333, alpha: 1)
        table.tableFooterView = UIView(frame: .zero)
        table.isEditing = true
        
        return table
    }()
    
    private let startGameButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start game", for: .normal)
        button.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 24)
        button.titleLabel?.textColor = .white
        button.titleLabel?.shadowOffset = CGSize(width: 0, height: 2)
        button.setTitleShadowColor(UIColor(red: 0.329, green: 0.471, blue: 0.435, alpha: 1), for: .normal)
        button.layer.cornerRadius = 32
        button.layer.backgroundColor = UIColor(named: "GulfStream")?.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        button.layer.shadowOpacity = 1
        button.layer.shadowColor = UIColor(red: 0.329, green: 0.471, blue: 0.435, alpha: 1).cgColor
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        playersTable.delegate = self;
        playersTable.dataSource = self;
        playersTable.register(PlayerCell.self, forCellReuseIdentifier: "CellId")
        playersTable.register(PlayerCell.self, forCellReuseIdentifier: "AddPlayerCell")
        players = ["Kate", "Betty"]
        //        self.navigationItem.title = "Game Counter"
        //        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension NewGameViewController {
    private func setupViews () {
        view.addSubview(viewTitle)
        view.addSubview(playersTable)
        view.addSubview(startGameButton)
        NSLayoutConstraint.activate([
            viewTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            viewTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            viewTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            playersTable.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 25),
            playersTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            playersTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            playersTable.bottomAnchor.constraint(equalTo: startGameButton.topAnchor, constant: -20),
            startGameButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            startGameButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            startGameButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -64),
            startGameButton.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
}

// MARK: - UITableViewDelegate
extension NewGameViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        55
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .none
    }
    
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        guard let playersArray = players else {
            return
        }
        let player = playersArray[sourceIndexPath.row]
        players?.remove(at: sourceIndexPath.row)
        if destinationIndexPath.row == playersArray.count {
            players?.insert(player, at: playersArray.count-1)
//            self.playersTable.moveRow(at: sourceIndexPath, to: IndexPath(row: playersArray.count-1, section: 0))
        } else {
            players?.insert(player, at: destinationIndexPath.row)
            self.playersTable.moveRow(at: sourceIndexPath, to: destinationIndexPath)
        }
    }
    
    //    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    //        50
    //    }
}

// MARK: - UITableViewDataSource
extension NewGameViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (players?.count ?? 0) + 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == players?.count {
            let cell = playersTable.dequeueReusableCell(withIdentifier: "AddPlayerCell", for: indexPath) as! PlayerCell
            cell.titleLabel.text = "Add player"
            cell.titleLabel.textColor = UIColor(named: "GulfStream")
            cell.titleLabel.font = UIFont(name: "Nunito-SemiBold", size: 16)
            cell.button.setImage(UIImage(named: "addPlayer"), for: .normal)
            return cell
        }
        
        let cell = playersTable.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! PlayerCell
        cell.backgroundColor = UIColor(named: "DarkGray")
        cell.titleLabel.text = players![indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(named: "DarkGray")
        let label = UILabel()
        label.text = "Players"
        label.font = UIFont(name: "Nunito-SemiBold", size: 16)
        label.textColor = UIColor(red: 0.922, green: 0.922, blue: 0.961, alpha: 0.6)
        
        headerView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 28),
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10)
        ])
        return headerView
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == players?.count {
            return false
        }
        
        return true
    }
    
    //    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    //        let footerView = UIView()
    //        footerView.backgroundColor = UIColor(named: "DarkGray")
    //
    //        let addPlayerButton = UIButton(type: .custom)
    //        addPlayerButton.setTitle("Add player", for: .normal)
    //        addPlayerButton.tintColor = UIColor(named: "GulfStream")
    //        addPlayerButton.titleLabel?.font = UIFont(name: "Nunito-SemiBold", size: 16)
    //        addPlayerButton.setTitleColor(UIColor(named: "GulfStream"), for: .normal)
    //        addPlayerButton.setImage(UIImage(named: "addPlayer"), for: .normal)
    //        addPlayerButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15)
    //
    //        footerView.addSubview(addPlayerButton)
    //        addPlayerButton.translatesAutoresizingMaskIntoConstraints = false
    //        NSLayoutConstraint.activate([
    //            addPlayerButton.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 16),
    //            addPlayerButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor)
    //        ])
    //        return footerView
    //    }
}
