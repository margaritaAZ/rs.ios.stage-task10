//
//  PlayersCollectionView.swift
//  GameCounter
//
//  Created by Маргарита Жучик on 28.08.21.
//

import UIKit

class PlayersCollectionView: UICollectionView {
    
    var cells = [Player]()
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        delegate = self
        dataSource = self
        
        register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellId")
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        layout.minimumLineSpacing = CollectionViewConstants.minimumLineSpacing
        contentInset = UIEdgeInsets(top: 0, left: CollectionViewConstants.leftDistanceToView, bottom: 0, right: CollectionViewConstants.rightDistanceToView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDelegate
extension PlayersCollectionView: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource
extension PlayersCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath)
        cell.backgroundColor = UIColor(named: "DarkGray")
        cell.layer.cornerRadius = 15
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor(named: "Orange")
        nameLabel.font = UIFont(name: "Nunito-ExtraBold", size: 28)
        nameLabel.text = cells[indexPath.row].name
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let scoreLabel = UILabel()
        scoreLabel.textColor = .white
        scoreLabel.font = UIFont(name: "Nunito-Bold", size: 100)
        scoreLabel.text = String(cells[indexPath.row].score)
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        cell.addSubview(nameLabel)
        cell.addSubview(scoreLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: cell.topAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: cell.centerXAnchor),
            scoreLabel.centerYAnchor.constraint(equalTo: cell.centerYAnchor, constant: 10),
            scoreLabel.centerXAnchor.constraint(equalTo: cell.centerXAnchor)
        ])
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension PlayersCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: CollectionViewConstants.itemWidth, height: frame.height)
    }
}
