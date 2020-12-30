//
//  WeekAdModels.swift
//  Avito
//
//  Created by Arman Davidoff on 26.12.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class WeekAdViewModel {
    
    var cellModels: [CellModel]
    var title: String
    var actionTitle: String
    var selectedActionTitle: String
    
    private var selectedAd: CellModel? {
        didSet {
            complition?()
        }
    }
    var complition: (() -> ())? {
        didSet {
            complition?()
        }
    }
    
    var selected: Bool {
        return selectedAd != nil
    }
    
    var selectButtonBackgroundColor: UIColor {
        return selected ? .buttonBlue : .buttonLight
    }
    
    var selectButtonTintColor: UIColor {
        return selected ? .white : .buttonBlue
    }
    
    var buttonTitle: String {
        return selected ? selectedActionTitle : actionTitle
    }
    
    var titleForAlert: String {
        if selected {
            return "Вы выбрали \(selectedAd!.serviceTitle)"
        } else {
            return "Вы не выбрали дополнительных услуг"
        }
    }
    
    init(cellModels: [CellModel], actionTitle: String, selectedActionTitle: String, title: String) {
        self.title = title
        self.cellModels = cellModels
        self.actionTitle = actionTitle
        self.selectedActionTitle = selectedActionTitle
    }
    
    func selectItem(at indexPath: IndexPath) -> [CellModel] {
        var reloadModels = [CellModel]()
        let model = cellModels[indexPath.row]
        if !model.selected {
            selectedAd = model
            if let first = cellModels.first(where: { $0.selected }) {
                first.selected.toggle()
                model.selected.toggle()
                reloadModels.append(contentsOf: [first,model])
                return reloadModels
            } else {
                model.selected.toggle()
                reloadModels.append(model)
                return reloadModels
            }
        } else {
            selectedAd = nil
            model.selected.toggle()
            reloadModels.append(model)
            return reloadModels
        }
    }
    
    func cellViewModel(at indexPath: IndexPath) -> CellModel {
        return cellModels[indexPath.row]
    }
    
}

//MARK: WeekAdCellViewModel
extension WeekAdViewModel {
    
    class CellModel: Hashable, WeekAdCellViewModelType {
        
        var serviceImageURL: String
        var serviceTitle: String
        var serviceDescription: String
        var price: String
        var selected: Bool
        private var id: String
        
        init(responseModel: List) {
            self.serviceImageURL = responseModel.icon.the52X52
            self.serviceTitle = responseModel.title
            self.selected = false
            self.price = responseModel.price
            self.serviceDescription = responseModel.description ?? ""
            self.id = responseModel.id
        }
        
        static func == (lhs: WeekAdViewModel.CellModel, rhs: WeekAdViewModel.CellModel) -> Bool {
            return lhs.id == rhs.id
        }
    
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }
}
