//
//  GetNews.swift
//  JustNews
//
//  Created by Bawenang RPP on 14/11/24.
//

import Foundation
import RxSwift

protocol GetNewsUseCase {
    func retrieveAll() -> Observable<[NewsItem]>
}

class GetNews: GetNewsUseCase {
    private let newsItemRepo: NewsItemRepositoring
    init(newsItemRepo: NewsItemRepositoring) {
        self.newsItemRepo = newsItemRepo
    }
    
    func retrieveAll() -> RxSwift.Observable<[NewsItem]> {
        return newsItemRepo.getAllPosts()
    }
}

class MockGetNews: GetNewsUseCase {
    func retrieveAll() -> RxSwift.Observable<[NewsItem]> {
        let mock = NewsItem(
            id: 1,
            title: "Test",
            headline: "Test Headline",
            content: "Teststststa",
            publishDate: "31/12/2019 05:40:30",
            thumbnail: URL(string: "https://dummyimage.com/200x200/753b01/suspendisse.png&text=jsonplaceholder.org"),
            image: URL(string: "https://dummyimage.com/800x430/753b01/suspendisse.png&text=jsonplaceholder.org")
        )
        return .just([mock])
    }
}
