//
//  GetBranchService.swift
//  IlyaCurrency Rate
//
//  Created by Admin on 21.01.2020.
//  Copyright © 2020 Ilya Ilushenko. All rights reserved.
//

import Foundation

//https://api.privatbank.ua/p24api/pboffice?json&city=&address=

class GetBranchService {
    private let httpService = HTTPService()
    var city: String = ""
    var address: String = ""
    var urlString = "https://api.privatbank.ua/p24api/pboffice"
    func getParams () -> [String: String] {
        var params = [String: String]()
        params ["city"] = "\(city)"
        params ["json"] = ""
        params ["address"] = "\(address)"
        return params
    }
    init (city: String, address: String = "") {
        self.city = city
        self.address = address
    }
    func request (complition: @escaping (_ branch: Branches?, _ error: Error?) -> Void) {
        httpService.sendRequest(urlString, parameters: getParams()) { (_ object: Branches?, error) in
            if let object = object {
                complition(object, nil)
            } else {
                complition(nil, error)
            }
        }
    }
    func getAllCities(completion: @escaping (_ cities: [String]) -> Void ) {
        request { branches, _ in
            if let branches = branches {
                completion(Array(Set(branches.map { $0.city })))
            } else {
                completion([])
            }
        }
    }
}
