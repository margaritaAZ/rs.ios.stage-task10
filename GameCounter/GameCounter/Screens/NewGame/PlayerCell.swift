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
        title.font = UIFont.nunito(20, .extraBold)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    let removeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "deletePlayer"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func setEditing(_ editing: Bool, animated: Bool) {
                super.setEditing(editing, animated: animated)

        if editing {
                for view in subviews where view.description.contains("Reorder") {
                    for case let subview as UIImageView in view.subviews {
                        subview.image = UIImage(named: "sort")
                    }
                }
            }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupViews()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = UIColor.veryDarkGray
        self.addSubview(removeButton)
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            removeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            removeButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: removeButton.trailingAnchor, constant: 15),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
