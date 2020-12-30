//
//  DataFetcher.swift
//  Avito
//
//  Created by Arman Davidoff on 30.12.2020.
//

import Foundation

class DataFetcher {
    
    func decodeJSON<T: Decodable>(name fileName: String, model: T.Type) -> T  {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else { fatalError("incorrect adress") }
        guard let data = try? Data.init(contentsOf: url) else { fatalError("error loading") }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let load = try? decoder.decode(model, from: data) else { fatalError("error decoding") }
        return load
    }
}
