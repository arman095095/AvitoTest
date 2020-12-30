//
//  Constants.swift
//  Avito
//
//  Created by Arman Davidoff on 30.12.2020.
//

import UIKit

struct HeaderConstants {
    var font: UIFont {
        return UIFont.systemFont(ofSize: 26,weight: .bold)
    }
    var bottomConstraintConstant: CGFloat {
        return -10
    }
}

struct CellConstants {
    
    var checkButtonHeight: CGFloat {
        return 20
    }
    var adImageViewHeight: CGFloat {
        return 52
    }
    var priceFont: UIFont {
        return UIFont.systemFont(ofSize: 16,weight: .bold)
    }
    var titleFont: UIFont {
        return UIFont.systemFont(ofSize: 22,weight: .bold)
    }
    var descriptionFont: UIFont {
        return UIFont.systemFont(ofSize: 13)
    }
    var contentViewCornerRadius: CGFloat {
        return 6
    }
    var checkImage: UIImage? {
        return UIImage(named: "check2")
    }
    var backgroundColor: UIColor {
        .systemGray6
    }
}

struct ViewConstants {
    var selectButtonFont: UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .medium)
    }
    var selectButtonCornerRadius: CGFloat {
        return 5
    }
    var selectButtonHeight: CGFloat {
        return 50
    }
    var selectButtonWidthInset: CGFloat {
        return -32
    }
    var collectionViewContentInset: UIEdgeInsets {
        return UIEdgeInsets(top: 30, left: 0, bottom: 100, right: 0)
    }
    
    var collectionViewSectionInsets: NSDirectionalEdgeInsets {
        return NSDirectionalEdgeInsets(top: 10
                                       , leading: 16, bottom: 15, trailing: 16)
    }
    
    var spacing: CGFloat {
        return 15
    }
    
    var estimatedHeight: CGFloat {
        return 250
    }
    
    var absoluteHeaderHeight: CGFloat {
        return 90
    }
    
    var barButtonImage: UIImage? {
        let config = UIImage.SymbolConfiguration(weight: .bold)
        return UIImage(systemName: "xmark",withConfiguration: config)
    }
    var backgroundColor: UIColor {
        .white
    }
    var itemTintColor: UIColor {
        return .black
    }
}
