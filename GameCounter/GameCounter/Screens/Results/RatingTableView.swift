//
//  RatingTableView.swift
//  GameCounter
//
//  Created by Маргарита Жучик on 28.08.21.
//

import UIKit

class RatingTableView: UITableView {
    var cells = [Player]()
    
    init() {
        super.init(frame: .zero, style: .grouped)
        
        backgroundColor = .black
        register(RatingCell.self, forCellReuseIdentifier: RatingCell.reuseId)
        
        delegate = self
        dataSource = self
        
        translatesAutoresizingMaskIntoConstraints = false
        separatorStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RatingTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: RatingCell.reuseId, for: indexPath) as! RatingCell
        cell.placeLabel.text = "#\(indexPath.row)"
        cell.nameLabel.text = cells[indexPath.row].name
        cell.scoreLabel.text = String(cells[indexPath.row].score)
        return cell
    }
}

extension RatingTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0
    }
}
