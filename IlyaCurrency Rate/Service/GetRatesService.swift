//
//  GetRatesService.swift
//  IlyaCurrency Rate
//
//  Created by Admin on 21.01.2020.
//  Copyright © 2020 Ilya Ilushenko. All rights reserved.
//

import Foundation

//https://api.privatbank.ua/p24api/pubinfo?exchange&json&coursid=11

class GetRatesService {
    private let httpService = HTTPService()
    var coursID: Int = 11
    var urlString = "https://api.privatbank.ua/p24api/pubinfo"
    func getParams () -> [String: String] {
        var params = [String: String]()
        params ["exchange"] = ""
        params ["json"] = ""
        params ["coursid"] = "\(coursID)"
        return params
    }
    init (coursID: Int = 11) {
        self .coursID = coursID
    }
    func request (complition: @escaping (_ rates: Rates?, _ error: Error?) -> Void) {
        httpService.sendRequest(urlString, parameters: getParams()) { (_ object: Rates?, error) in
            if let object = object {
                complition(object, nil)
            } else {
                complition(nil, error)
            }
        }
    }
}
