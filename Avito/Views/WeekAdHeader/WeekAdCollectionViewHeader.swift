//
//  WeekAdCollectionViewHeader.swift
//  Avito
//
//  Created by Arman Davidoff on 26.12.2020.
//

import UIKit

class WeekAdCollectionViewHeader: UICollectionReusableView {
    
    static let headerID = "WeekAdCollectionViewHeader"
    
    private let constants = HeaderConstants()
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = constants.font
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(text: String) {
        titleLabel.text = text
    }
    
    private func setupConstraints() {
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant: constants.bottomConstraintConstant).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
