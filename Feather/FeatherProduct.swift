//
//  FeatherProduct.swift
//  Feather
//
//  Created by Kristina Tran on 11/6/19.
//  Copyright © 2019 CSC308_309. All rights reserved.
//

import Foundation

import MongoSwift

struct FeatherProduct: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, ingredients
    }
    let id: ObjectId
    let name: String
    let ingredients: [String]
    
}
