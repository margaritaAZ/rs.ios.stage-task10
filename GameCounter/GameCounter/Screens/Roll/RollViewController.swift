//
//  RollViewController.swift
//  GameCounter
//
//  Created by Маргарита Жучик on 29.08.21.
//

import UIKit

class RollViewController: UIViewController {
    
    lazy var blurredView: UIView = {
        let containerView = UIView()
        var blurEffect = UIBlurEffect(style: .dark)
//        if #available(iOS 13.0, *) {
//            blurEffect = UIBlurEffect(style: .systemThickMaterialLight)
//        }
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        let dimmedView = UIView()
        dimmedView.backgroundColor = .black.withAlphaComponent(0.6)
        dimmedView.frame = self.view.bounds
        
        containerView.addSubview(blurEffectView)
//                    containerView.addSubview(dimmedView)
        return containerView
    }()
    
    var diceImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDiceEdge()
        setupViews()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapOnView))
        view.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    private func setupViews() {
        view.addSubview(blurredView)
        view.addSubview(diceImageView)
        
        NSLayoutConstraint.activate([
            diceImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            diceImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func getDiceEdge() {
        diceImageView.image = UIImage(named: "dice-\(Int.random(in: 1...6))")
    }
    
    @objc private func didTapOnView(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true) {}
    }
    
}
