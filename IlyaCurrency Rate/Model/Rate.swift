//
//  Rate.swift
//  IlyaCurrency Rate
//
//  Created by Admin on 21.01.2020.
//  Copyright © 2020 Ilya Ilushenko. All rights reserved.
//

import Foundation

typealias Rates = [Rate]

struct Rate: Decodable {
     let currency: String
     let baseCurrency: String
     let buy: Double
     let sell: Double

    enum CodingKeys: String, CodingKey {
        case currency = "ccy",
        baseCurrency = "base_ccy",
        buy = "buy",
        sell = "sale"
    }
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            self.currency = try container.decode(String.self, forKey: .currency)
            self.baseCurrency = try container.decode(String.self, forKey: .baseCurrency)

            if let value = try? container.decode(String.self, forKey: .buy), let doubleValue = Double(value) {
                self.buy = doubleValue
            } else {
                self.buy = 0
            }
            if let value = try? container.decode(String.self, forKey: .sell), let doubleValue = Double(value) {
                self.sell = doubleValue
            } else {
                self.sell = 0
            }
        }
}
