//
//  ResponseModel.swift
//  Avito
//
//  Created by Arman Davidoff on 26.12.2020.
//

import Foundation

// MARK: - Response
struct Result: Decodable {
    let result: ResponseModel
}

// MARK: - Result
struct ResponseModel: Decodable {
    let title, actionTitle, selectedActionTitle: String
    let list: [List]
}

// MARK: - List
struct List: Decodable {
    let id, title: String
    let description: String?
    let icon: Icon
    let price: String
    let isSelected: Bool
}

// MARK: - Icon
struct Icon: Decodable {
    let the52X52: String
    enum CodingKeys: String, CodingKey {
           case the52X52 = "52x52"
    }
}
