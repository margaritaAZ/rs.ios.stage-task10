//
//  CircleButton.swift
//  GameCounter
//
//  Created by Маргарита Жучик on 28.08.21.
//

import UIKit

class CircleButton: UIButton {
    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            if newValue {
                backgroundColor = #colorLiteral(red: 0.3607843137, green: 0.5647058824, blue: 0.5215686275, alpha: 1)
            } else {
                backgroundColor = UIColor.gulfStream
            }
            super.isHighlighted = newValue
        }
    }
    
    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor.gulfStream
        tintColor = .white
        setTitleShadowColor(#colorLiteral(red: 0.3294117647, green: 0.4705882353, blue: 0.4352941176, alpha: 1), for: .normal)
        titleLabel?.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
