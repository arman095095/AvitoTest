//
//  WeekAdCollectionViewCell.swift
//  Avito
//
//  Created by Arman Davidoff on 26.12.2020.
//

import UIKit

protocol WeekAdCellViewModelType {
    var serviceImageURL: String { get }
    var serviceTitle: String { get }
    var serviceDescription: String { get }
    var price: String { get }
    var selected: Bool { set get }
}

class WeekAdCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "WeekAdCollectionViewCell"
    private let serviceImageView = WebImageView()
    private let checkImageView = UIImageView()
    private let serviceTitleLabel = UILabel()
    private let serviceDescriptionLabel = UILabel()
    private let constants = CellConstants()
    private let priceLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        serviceImageView.image = nil
    }
    
    func config(viewModel: WeekAdCellViewModelType) {
        serviceImageView.set(imageURL: viewModel.serviceImageURL)
        priceLabel.text = viewModel.price
        serviceTitleLabel.text = viewModel.serviceTitle
        serviceDescriptionLabel.text = viewModel.serviceDescription
        checkImageView.isHidden = !viewModel.selected
    }
}

//MARK: Setup UI
private extension WeekAdCollectionViewCell {
    
    func setupViews() {
        
        [serviceImageView,checkImageView,serviceTitleLabel,serviceDescriptionLabel,priceLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            ($0 as? UILabel)?.numberOfLines = 0
        }
        
        checkImageView.layer.cornerRadius = constants.checkButtonHeight/2
        checkImageView.layer.masksToBounds = true
        contentView.layer.cornerRadius = constants.contentViewCornerRadius
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = constants.backgroundColor
        checkImageView.image = constants.checkImage
        
        priceLabel.font = constants.priceFont
        serviceTitleLabel.font = constants.titleFont
        serviceDescriptionLabel.font = constants.descriptionFont
    }
    
    func setupConstraints() {
        serviceImageView.heightAnchor.constraint(equalToConstant: constants.adImageViewHeight).isActive = true
        serviceImageView.widthAnchor.constraint(equalToConstant: constants.adImageViewHeight).isActive = true
        serviceImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        serviceImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        
        serviceTitleLabel.topAnchor.constraint(equalTo: serviceImageView.topAnchor).isActive = true
        serviceTitleLabel.leadingAnchor.constraint(equalTo: serviceImageView.trailingAnchor, constant: 15).isActive = true
        serviceTitleLabel.trailingAnchor.constraint(equalTo: checkImageView.leadingAnchor, constant: -15).isActive = true
        
        serviceDescriptionLabel.leadingAnchor.constraint(equalTo: serviceTitleLabel.leadingAnchor).isActive = true
        serviceDescriptionLabel.topAnchor.constraint(equalTo: serviceTitleLabel.bottomAnchor, constant: 7).isActive = true
        serviceDescriptionLabel.trailingAnchor.constraint(equalTo: checkImageView.leadingAnchor, constant: -15).isActive = true
        
        priceLabel.topAnchor.constraint(equalTo: serviceDescriptionLabel.bottomAnchor, constant: 10).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: serviceDescriptionLabel.leadingAnchor).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        
        checkImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        checkImageView.heightAnchor.constraint(equalToConstant: constants.checkButtonHeight).isActive = true
        checkImageView.widthAnchor.constraint(equalToConstant: constants.checkButtonHeight).isActive = true
        checkImageView.centerYAnchor.constraint(equalTo: serviceImageView.centerYAnchor).isActive = true
    }
}
