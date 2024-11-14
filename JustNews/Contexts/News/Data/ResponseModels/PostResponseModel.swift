//
//  PostResponseModel.swift
//  JustNews
//
//  Created by Bawenang RPP on 14/11/24.
//

struct PostResponseModel: Decodable {
    let id: Int
    let slug: String
    let title: String
    let content: String
    let publishedAt: String
    let thumbnail: String
    let image: String
}
