//
//  PlayersCollectionView.swift
//  GameCounter
//
//  Created by Маргарита Жучик on 28.08.21.
//

import UIKit

class PlayersCollectionView: UICollectionView {
    
    var cells = [Player]()
    var activeCellPath: IndexPath?
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        delegate = self
        dataSource = self
        
        register(PlayerCollectionViewCell.self, forCellWithReuseIdentifier: PlayerCollectionViewCell.reuseId)
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


// MARK: - Private interface
private extension PlayersCollectionView {
    func indexOfMajorCell() -> Int {
        let proportionalOffset = collectionViewLayout.collectionView!.contentOffset.x / CollectionViewConstants.itemWidth
        let index = Int(round(proportionalOffset))
        let safeIndex = max(0, min(cells.count - 1, index))
//                print ("\(collectionViewLayout.collectionView!.contentOffset)    \(CollectionViewConstants.itemWidth)")
        return safeIndex
    }
    
    func getActiveCellIndexPath() {
        let cellCenterPoint = CGPoint(x: center.x + contentOffset.x + CollectionViewConstants.leftDistanceToView,
                                      y: center.y)
        print("central point: \(cellCenterPoint) -- \(collectionViewLayout.collectionView!.center) -- \(collectionViewLayout.collectionView!.contentOffset) -- \(UIScreen.main.bounds)")
        activeCellPath = indexPathForItem(at: cellCenterPoint)
    }
}

// MARK: - Public Interface
extension PlayersCollectionView {
    func scrollToItem(_ index: Int) {
        scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    func getActivePlayerIndex() -> Int {
        getActiveCellIndexPath()
        return activeCellPath?.row ?? 0
    }
}

// MARK: - UICollectionViewDelegate
extension PlayersCollectionView: UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //        print ("scrollViewWillBeginDragging: \(collectionViewLayout.collectionView!.contentOffset)")
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        //        print("scrollViewWillEndDragging: \(targetContentOffset)")
        
        // Stop scrollView sliding:
        targetContentOffset.pointee = scrollView.contentOffset
        let indexOfMajorCell = self.indexOfMajorCell()
        let indexPath = IndexPath(row: indexOfMajorCell, section: 0)
        collectionViewLayout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension PlayersCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: PlayerCollectionViewCell.reuseId, for: indexPath) as! PlayerCollectionViewCell
        
        cells = Players().getFromStorage() ?? []
        cell.nameLabel.text = cells[indexPath.row].name
        cell.scoreLabel.text = String(cells[indexPath.row].score)
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension PlayersCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: CollectionViewConstants.itemWidth, height: frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}
