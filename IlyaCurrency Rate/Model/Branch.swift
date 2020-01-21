//
//  Branch.swift
//  IlyaCurrency Rate
//
//  Created by Admin on 21.01.2020.
//  Copyright © 2020 Ilya Ilushenko. All rights reserved.
//

import Foundation

typealias Branches = [Branch]
struct Branch: Decodable {
    var name: String
    var state: String
    var id: String
    var country: String
    var city: String
    var index: String
    var phone: String
    var email: String
    var address: String
}
