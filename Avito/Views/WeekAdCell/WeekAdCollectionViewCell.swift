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
        contentView.addSubview(serviceImageView)
        contentView.addSubview(checkImageView)
        contentView.addSubview(serviceTitleLabel)
        contentView.addSubview(serviceDescriptionLabel)
        contentView.addSubview(priceLabel)
        
        checkImageView.layer.cornerRadius = 10
        checkImageView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 6
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .systemGray6
        checkImageView.image = UIImage(named: "check2")
        serviceImageView.translatesAutoresizingMaskIntoConstraints = false
        checkImageView.translatesAutoresizingMaskIntoConstraints = false
        serviceTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        serviceDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        priceLabel.numberOfLines = 0
        serviceTitleLabel.numberOfLines = 0
        serviceDescriptionLabel.numberOfLines = 0
        priceLabel.font = UIFont.systemFont(ofSize: 16,weight: .bold)
        serviceTitleLabel.font = UIFont.systemFont(ofSize: 22,weight: .bold)
        serviceDescriptionLabel.font = UIFont.systemFont(ofSize: 13)
    }
    
    func setupConstraints() {
        serviceImageView.heightAnchor.constraint(equalToConstant: 52).isActive = true
        serviceImageView.widthAnchor.constraint(equalToConstant: 52).isActive = true
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
        checkImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        checkImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        checkImageView.centerYAnchor.constraint(equalTo: serviceImageView.centerYAnchor).isActive = true
    }
}
