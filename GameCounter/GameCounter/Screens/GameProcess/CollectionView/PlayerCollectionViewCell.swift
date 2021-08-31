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
        nameLabel.textColor = UIColor.manhattan
        nameLabel.font = UIFont.nunito(28, .extraBold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    let scoreLabel: UILabel = {
        let scoreLabel = UILabel()
        scoreLabel.textColor = .white
        scoreLabel.font = UIFont.nunito(GameProcessConstants.scoreLabelFontSize, .bold)
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        return scoreLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.veryDarkGray
        layer.cornerRadius = 15
        
        addSubview(nameLabel)
        addSubview(scoreLabel)
        
//        print(UIScreen.main.bounds.height)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(lessThanOrEqualTo: topAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            scoreLabel.centerYAnchor.constraint(lessThanOrEqualTo: centerYAnchor, constant: 10),
            scoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
