//
//  Helpers.swift
//  GameCounter
//
//  Created by Маргарита Жучик on 30.08.21.
//

import Foundation
import UIKit

extension UIColor {
    static let gulfStream: UIColor = #colorLiteral(red: 0.5176470588, green: 0.7215686275, blue: 0.6784313725, alpha: 1)
    static let manhattan: UIColor = #colorLiteral(red: 0.9215686275, green: 0.6823529412, blue: 0.4078431373, alpha: 1)
    static let veryDarkGray: UIColor = #colorLiteral(red: 0.231372549, green: 0.231372549, blue: 0.231372549, alpha: 1)
}

extension UIFont {
    enum Prettiness: String {
        case bold
        case extraBold
        case semiBold
    }
    
    static func nunito(_ size: CGFloat, _ type: Prettiness) -> UIFont {
        UIFont(name: "Nunito-\(type.rawValue.capitalized)", size: size) ?? .systemFont(ofSize: size)
    }
}
