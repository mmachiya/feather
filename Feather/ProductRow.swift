//
//  productViewRow.swift
//  Feather
//
//  Created by Kristina Tran on 3/9/20.
//  Copyright © 2020 CSC308_309. All rights reserved.
//

import SwiftUI

struct ProductRow: View {

    var product: ProductInfo

    var body: some View {
        if product.name == "nil" {
            return HStack{
                Text("Nothing here")
            }
        }
        else {
            return HStack{
                Text(product.name)
                Spacer()
            }
        }
    }
}


struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        let mine = ViewController.SignUpUser.myProducts
        if !mine.isEmpty {
            let keyArr = Array(mine.keys)
            let first = keyArr[0]
            let values = mine[first]
            let nothing = ProductInfo(name: "nil", ingredients: ["nil"], brand: "nil", category: "nil")
            return ProductRow(product: (values?[0] ?? nil) ?? nothing)
        }
        else {
            return ProductRow(product: ProductInfo(name: "nil", ingredients: ["nil"], brand: "nil", category: "nil"))
        }
    }
}
