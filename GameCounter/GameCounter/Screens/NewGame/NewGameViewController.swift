//
//  NewGameViewController.swift
//  GameCounter
//
//  Created by Маргарита Жучик on 25.08.21.
//

import UIKit

class NewGameViewController: UIViewController {
    
    var playersArray = Players().getFromStorage() ?? []
    let maxPlayers = 6
    
    private let viewTitle: UILabel = {
        let title = UILabel()
        title.text = "Game Counter"
        title.textColor = .white
        title.font = UIFont.nunito(36, .extraBold)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private let playersTable: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .black
        table.layer.cornerRadius = 15
        table.separatorColor = #colorLiteral(red: 0.3333333333, green: 0.3333333333, blue: 0.3333333333, alpha: 1)
        table.isEditing = true
        return table
    }()
    
    private let startGameButton: UIButton = {
        let button = StartGameButton()
        button.setTitle("Start game", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "Cancel"
        
        return button
    }()
    
    let addPlayerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Add player", for: .normal)
        button.tintColor = UIColor.gulfStream
        button.titleLabel?.font = UIFont.nunito(16, .semiBold)
        button.setTitleColor(UIColor.gulfStream, for: .normal)
        button.setImage(UIImage(named: "addPlayer"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //    override var preferredStatusBarStyle: UIStatusBarStyle {
    //        .lightContent
    //    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playersArray = Players().getFromStorage() ?? []
        playersTable.reloadData()
        isStatGameButtonEnable()
        isAddPlayerButtonEnable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        playersTable.delegate = self;
        playersTable.dataSource = self;
        playersTable.register(PlayerCell.self, forCellReuseIdentifier: "CellId")
        
        cancelButton.action = #selector(returnToGameProcess)
        cancelButton.target = self
        if UserDefaults.standard.integer(forKey: "isActiveGameAvaliable") != 1 {
            navigationItem.leftBarButtonItem = nil
        } else {
            navigationItem.leftBarButtonItem = cancelButton
        }
        
    }
}

private extension NewGameViewController {
    func setupViews () {
        view.addSubview(viewTitle)
        view.addSubview(playersTable)
        view.addSubview(startGameButton)
        NSLayoutConstraint.activate([
            viewTitle.topAnchor.constraint(equalTo: view.topAnchor),
            viewTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            playersTable.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 20),
            playersTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            playersTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            playersTable.bottomAnchor.constraint(equalTo: startGameButton.topAnchor, constant: -20),
            startGameButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            startGameButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            startGameButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            startGameButton.heightAnchor.constraint(equalToConstant: 65)
        ])
        
        startGameButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
    }
    
    @objc func returnToGameProcess() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func addPlayer() {
        navigationController?.pushViewController(AddPlayerViewController(), animated: true)
        
    }
    @objc func startGame() {
        
        playersArray = playersArray.map { player in
            var player = player
            player.turns = nil
            player.score = 0
            return player
        }
        
        Players().saveToStorage(players: playersArray)
        UserDefaults.standard.set(0.0, forKey: "timer")
        UserDefaults.standard.set(1, forKey: "isActiveGameAvaliable")
        navigationController?.setViewControllers([GameProcessViewController()], animated: true)
    }
    
    @objc func deleteButtonPressed(sender: UIButton) {
        playersArray.remove(at: sender.tag)
        Players().saveToStorage(players: playersArray)
        playersTable.reloadData()
        isStatGameButtonEnable()
        isAddPlayerButtonEnable()
    }
    
    func isStatGameButtonEnable() {
        startGameButton.isEnabled = playersArray.count != 0
    }
    
    func isAddPlayerButtonEnable() {
        addPlayerButton.isEnabled = playersArray.count < 6
    }
    
}

// MARK: - UITableViewDelegate
extension NewGameViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
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
        let player = playersArray[sourceIndexPath.row]
        playersArray.remove(at: sourceIndexPath.row)
        playersArray.insert(player, at: destinationIndexPath.row)
        self.playersTable.moveRow(at: sourceIndexPath, to: destinationIndexPath)
        Players().saveToStorage(players: playersArray)
    }
}

// MARK: - UITableViewDataSource
extension NewGameViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (playersArray.count)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = playersTable.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! PlayerCell
        cell.titleLabel.text = playersArray[indexPath.row].name
        cell.removeButton.tag = indexPath.row
        cell.removeButton.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.veryDarkGray
        let label = UILabel()
        label.text = "Players"
        label.font = UIFont.nunito(16, .semiBold)
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
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.veryDarkGray
        footerView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        footerView.layer.cornerRadius = 15
        
        let dividerView = UIView()
        dividerView.backgroundColor = UIColor(red: 0.333, green: 0.333, blue: 0.333, alpha: 1)
        
        addPlayerButton.addTarget(self, action: #selector(addPlayer), for: .touchUpInside)
        
        footerView.addSubview(dividerView)
        footerView.addSubview(addPlayerButton)
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dividerView.topAnchor.constraint(equalTo: footerView.topAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            dividerView.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 16),
            dividerView.trailingAnchor.constraint(equalTo: footerView.trailingAnchor),
            addPlayerButton.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 16),
            addPlayerButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            addPlayerButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -16)
        ])
        return footerView
    }
}
