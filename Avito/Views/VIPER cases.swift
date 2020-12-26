//
//  VIPER cases.swift
//  Avito
//
//  Created by Arman Davidoff on 26.12.2020.
//

import Foundation

enum WeekAd {
    enum Model {
        struct Request {
            enum RequestType {
                case decodeData
            }
        }
        struct Response {
            enum ResponseType {
                case present(response: ResponseModel)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case display(viewModel: WeekAdViewModel)
            }
        }
    }
}
