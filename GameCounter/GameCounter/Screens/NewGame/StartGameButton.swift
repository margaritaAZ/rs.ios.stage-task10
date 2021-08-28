//
//  StartGameButton.swift
//  GameCounter
//
//  Created by Маргарита Жучик on 28.08.21.
//

import UIKit

class StartGameButton: UIButton {
    override var isHighlighted: Bool {
        get {
           return super.isHighlighted
        }
        
        set {
            if newValue {
                backgroundColor = #colorLiteral(red: 0.3607843137, green: 0.5647058824, blue: 0.5215686275, alpha: 1)
                layer.shadowOpacity = 0.5
            } else {
                backgroundColor = UIColor(named: "GulfStream")
                layer.shadowOpacity = 1
            }
            super.isHighlighted = newValue
        }
    }
    
    init() {
        super.init(frame: .zero)
        titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 24)
        titleLabel?.textColor = .white
        titleLabel?.shadowOffset = CGSize(width: 0, height: 2)
        setTitleShadowColor(UIColor(red: 0.329, green: 0.471, blue: 0.435, alpha: 1), for: .normal)
        layer.cornerRadius = 32
        backgroundColor = UIColor(named: "GulfStream")
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowOpacity = 1
        layer.shadowColor = #colorLiteral(red: 0.3294117647, green: 0.4705882353, blue: 0.4352941176, alpha: 1).cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
