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
    
    func makeRequest(request: WeekAd.Model.Request.RequestType) {
        switch request {
        case .decodeData:
            let result = decode()
            presenter?.presentData(response: .present(response: result))
        }
    }
}

private extension WeekAdInteractor {
    
    func decode() -> ResponseModel {
        guard let url = Bundle.main.url(forResource: "result.json", withExtension: nil) else { fatalError("incorrect adress") }
        guard let data = try? Data.init(contentsOf: url) else { fatalError("error loading") }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let load = try? decoder.decode(Result.self, from: data) else { fatalError("error decoding") }
        return load.result
    }
}
