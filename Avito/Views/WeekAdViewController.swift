//
//  WeekAdViewController.swift
//  Avito
//
//  Created by Arman Davidoff on 26.12.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol WeekAdDisplayLogic: class {
    func displayData(viewModel: WeekAd.Model.ViewModel.ViewModelData)
}

class WeekAdViewController: UIViewController, WeekAdDisplayLogic {
    
    var interactor: WeekAdBusinessLogic?
    private var weekAdViewModel: WeekAdViewModel!
    private var collectionView: UICollectionView!
    private var selectButton: UIButton!
    private var dataSource: UICollectionViewDiffableDataSource<Sections, WeekAdViewModel.CellModel>!
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = WeekAdInteractor()
        let presenter             = WeekAdPresenter()
        viewController.interactor = interactor
        interactor.presenter      = presenter
        presenter.viewController  = viewController
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigationBar()
        setupDataSource()
        setupButton()
        interactor?.makeRequest(request: .decodeData)
    }
    
    func displayData(viewModel: WeekAd.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .display(viewModel: let viewModel):
            self.weekAdViewModel = viewModel
            self.reloadData()
            self.weekAdViewModel.complition = { [weak self] in
                self?.setButton()
            }
        }
    }
}

//MARK: Setup UI
private extension WeekAdViewController {
    
    func setButton() {
        selectButton.tintColor = weekAdViewModel.selected ? .white : #colorLiteral(red: 0.05763521045, green: 0.557649672, blue: 0.9972464442, alpha: 1)
        let title = weekAdViewModel.selected ? weekAdViewModel.selectedActionTitle : weekAdViewModel.actionTitle
        selectButton.setTitle(title, for: .normal)
        selectButton.backgroundColor = weekAdViewModel.selected ? #colorLiteral(red: 0.05763521045, green: 0.557649672, blue: 0.9972464442, alpha: 1) : #colorLiteral(red: 0.889477551, green: 0.9738015532, blue: 1, alpha: 1)
    }
    
    func setupButton() {
        selectButton = UIButton(type: .system)
        selectButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(selectButton)
        selectButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        selectButton.widthAnchor.constraint(equalToConstant: view.bounds.width - 32).isActive = true
        selectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        selectButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -15).isActive = true
        selectButton.layer.cornerRadius = 5
        selectButton.layer.masksToBounds = true
        selectButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
    }
    
    @objc func showAlert() {
        let alert = UIAlertController(title: weekAdViewModel.titleForAlert, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        let config = UIImage.SymbolConfiguration(weight: .bold)
        let item = UIBarButtonItem.init(image: UIImage(systemName: "xmark",withConfiguration: config), style: .done, target: self, action: nil)
        item.tintColor = .black
        navigationController?.navigationBar.topItem?.setLeftBarButton(item, animated: true)
    }
}

//MARK: Setup CollectionView
private extension WeekAdViewController {
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: setupLayout())
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.allowsSelection = true
        collectionView.contentInset.top = 30
        collectionView.contentInset.bottom = 100
        
        collectionView.register(WeekAdCollectionViewCell.self, forCellWithReuseIdentifier: WeekAdCollectionViewCell.cellID)
        collectionView.register(WeekAdCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: WeekAdCollectionViewHeader.headerID)
    }
}

//MARK: CollectionView delegate
extension WeekAdViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let models = weekAdViewModel.selectItem(at: indexPath)
        reloadDataWithEditedAd(models: models)
    }
}

//MARK: Setup DataSource
private extension WeekAdViewController {
    
    enum Sections: Int {
        case main
    }
    
    func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Sections, WeekAdViewModel.CellModel>(collectionView: collectionView, cellProvider: { (cv, indexPath, model) -> UICollectionViewCell? in
            guard let section = Sections(rawValue: indexPath.section) else { return nil }
            switch section {
            case .main:
                let cell = cv.dequeueReusableCell(withReuseIdentifier: WeekAdCollectionViewCell.cellID, for: indexPath) as! WeekAdCollectionViewCell
                cell.config(viewModel: model)
                return cell
            }
        })
        
        dataSource.supplementaryViewProvider = { [weak self] (cv, kind, indexPath) -> UICollectionReusableView?  in
            guard let self = self else { return nil }
            guard let section = Sections(rawValue: indexPath.section) else { return nil }
            switch section {
            case .main:
                let header = cv.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: WeekAdCollectionViewHeader.headerID, for: indexPath) as! WeekAdCollectionViewHeader
                header.config(text: self.weekAdViewModel.title)
                return header
            }
        }
    }
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Sections, WeekAdViewModel.CellModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(weekAdViewModel.cellModels, toSection: .main)
        dataSource.apply(snapshot,animatingDifferences: true)
    }
    
    func reloadDataWithEditedAd(models: [WeekAdViewModel.CellModel]) {
        var snapshot = dataSource.snapshot()
        snapshot.reloadItems(models)
        dataSource.apply(snapshot,animatingDifferences: false)
    }
}

//MARK: Setup Layout
private extension WeekAdViewController {
    
    func setupLayout() -> UICollectionViewCompositionalLayout {
        let layout =  UICollectionViewCompositionalLayout { [weak self] (section, x) -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            guard let section = Sections(rawValue: section) else { return nil }
            switch section {
            case .main:
                return self.compositionalVerticalLayoutSection()
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 15
        layout.configuration = config
        return layout
    }
    
    //MARK: Vertical Section Layout
    func compositionalVerticalLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(250))
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(250))
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(90))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [header]
        section.contentInsets = NSDirectionalEdgeInsets(top: 10
                                                        , leading: 16, bottom: 15, trailing: 16)
        section.interGroupSpacing = 15
        
        return section
    }
}
