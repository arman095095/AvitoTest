//
//  WeekAdPresenter.swift
//  Avito
//
//  Created by Arman Davidoff on 26.12.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol WeekAdPresentationLogic {
    func presentData(response: WeekAd.Model.Response.ResponseType)
}

class WeekAdPresenter: WeekAdPresentationLogic {
    weak var viewController: WeekAdDisplayLogic?
    
    func presentData(response: WeekAd.Model.Response.ResponseType) {
        switch response {
        case .present(response: let response):
            let viewModel = convertResponseModelToViewModel(response: response)
            viewController?.displayData(viewModel: .display(viewModel: viewModel))
        }
    }
}

private extension WeekAdPresenter {
    
    func convertResponseModelToViewModel(response: ResponseModel) -> WeekAdViewModel {
        let list = response.list.filter { $0.id == "xl" || $0.id == "highlight" }
        let cells = list.map { WeekAdViewModel.CellModel(responseModel: $0) }
        let title = response.title
        let actionTitle = response.actionTitle
        let selectedActionTitle = response.selectedActionTitle
        return WeekAdViewModel(cellModels: cells, actionTitle: actionTitle, selectedActionTitle: selectedActionTitle,title: title)
    }
}
