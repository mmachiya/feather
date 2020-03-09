//
//  ProductInfo.swift
//  Feather
//
//  Created by Siriwan Sereesathien on 1/23/20.
//  Copyright © 2020 CSC308_309. All rights reserved.
//

import Foundation

struct ProductInfo:Decodable{
    let name: String
    let ingredients: [String]
    let brand: String
    let category: String
}
