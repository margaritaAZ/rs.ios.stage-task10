//
//  PlayerCell.swift
//  GameCounter
//
//  Created by Маргарита Жучик on 26.08.21.
//

import UIKit

class PlayerCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.font = UIFont(name: "Nunito-ExtraBold", size: 20)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "deletePlayer"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupViews()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = UIColor(named: "DarkGray")
        self.addSubview(button)
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            button.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: 15),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
}
