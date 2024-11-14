//
//  ItemResponseModel.swift
//  JustNews
//
//  Created by Bawenang RPP on 14/11/24.
//

struct ItemResponseModel: Decodable {
    let name: String
    let response: [ItemResponseResponseModel]
}
