//
//  NewsItemRepository.swift
//  JustNews
//
//  Created by Bawenang RPP on 14/11/24.
//

import RxSwift

private let jsonFilename = "iOS Test.postman_collection"

enum DataSourceError: LocalizedError {
    case selfNotFound
    case fileNotFound
    
    var errorDescription: String? {
        switch self {
        case .selfNotFound: return "Self is nil"
        case .fileNotFound: return "JSON file not found"
        }
    }
}

protocol NewsItemRepositoring {
    func getAllPosts() -> Observable<[NewsItem]>
}

final class NewsItemRepository: NewsItemRepositoring {
    func getAllPosts() -> Observable<[NewsItem]> {
        return Observable.create { observer in
            do {
                let data = try openFileData()
                let response = try ResponseResponseModel.decode(from: data,
                                                                keyDecodeStrategy: .convertFromSnakeCase)
                let items = response.item
                if let postData = items[0].response[0].body.data(using: .utf8) {
                    let posts = try [PostResponseModel].decode(from: postData, keyDecodeStrategy: .convertFromSnakeCase)
                    let newsItem = transformNews(from: posts)
                    observer.onNext(newsItem)
                    observer.onCompleted()
                } else {
                    observer.onNext([])
                    observer.onCompleted()
                }
                
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
}

private func openFileData() throws -> Data {
    guard let url = Bundle.main.url(forResource: jsonFilename, withExtension: "json") else {
        throw DataSourceError.fileNotFound
    }
        
    return try Data(contentsOf: url)
}

private func transformNews(from items: [PostResponseModel]) -> [NewsItem] {
    items.map { item in
        return NewsItem(id: item.id,
                        title: item.slug,
                        headline: item.title,
                        content: item.content,
                        publishDate: item.publishedAt,
                        thumbnail: URL(string: item.thumbnail),
                        image: URL(string: item.image))
    }
}
