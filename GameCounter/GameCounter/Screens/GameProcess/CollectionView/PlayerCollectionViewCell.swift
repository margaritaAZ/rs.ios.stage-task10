//
//  PlayerCollectionViewCell.swift
//  GameCounter
//
//  Created by Маргарита Жучик on 30.08.21.
//

import UIKit

class PlayerCollectionViewCell: UICollectionViewCell {
    static let reuseId = "PlayerCell"
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor(named: "Orange")
        nameLabel.font = UIFont(name: "Nunito-ExtraBold", size: 28)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    let scoreLabel: UILabel = {
        let scoreLabel = UILabel()
        scoreLabel.textColor = .white
        scoreLabel.font = UIFont(name: "Nunito-Bold", size: 100)
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        return scoreLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "DarkGray")
        layer.cornerRadius = 15
        
        addSubview(nameLabel)
        addSubview(scoreLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            scoreLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10),
            scoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
