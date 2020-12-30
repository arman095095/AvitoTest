//
//  WeekAdInteractor.swift
//  Avito
//
//  Created by Arman Davidoff on 26.12.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol WeekAdBusinessLogic {
    func makeRequest(request: WeekAd.Model.Request.RequestType)
}

class WeekAdInteractor: WeekAdBusinessLogic {
    
    var presenter: WeekAdPresentationLogic?
    private let dataFetcher = DataFetcher()
    
    func makeRequest(request: WeekAd.Model.Request.RequestType) {
        switch request {
        case .decodeData:
            let result = dataFetcher.decodeJSON(name: "result.json", model: Result.self).result
            presenter?.presentData(response: .present(response: result))
        }
    }
}
