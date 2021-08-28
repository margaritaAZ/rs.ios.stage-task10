//
//  RatingCell.swift
//  GameCounter
//
//  Created by Маргарита Жучик on 28.08.21.
//

import UIKit

class RatingCell: UITableViewCell {
    static let reuseId = "RatingCell"
    
     let placeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Nunito-ExtraBold", size: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "Orange")
        label.font = UIFont(name: "Nunito-ExtraBold", size: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Nunito-ExtraBold", size: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupViews()
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setupViews() {
        
        backgroundColor = .black
        addSubview(placeLabel)
        addSubview(nameLabel)
        addSubview(scoreLabel)
        
        NSLayoutConstraint.activate([
            placeLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            placeLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: placeLabel.trailingAnchor, constant: 5),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            scoreLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
    }
}
