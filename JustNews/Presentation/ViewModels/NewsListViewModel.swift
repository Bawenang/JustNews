//
//  NewsListViewModel.swift
//  JustNews
//
//  Created by Bawenang RPP on 14/11/24.
//

import Foundation
import RxSwift
import RxCocoa

protocol NewsListViewModelInputs {
    var viewLoad: PublishRelay<Void> { get }
}

protocol NewsListViewModelOutputs {
    var newsList: Driver<[NewsItem]> { get }
}

final class NewsListViewModel: NewsListViewModelInputs, NewsListViewModelOutputs {
    let viewLoad = PublishRelay<Void>()
    
    let newsList: Driver<[NewsItem]>
    
    init(getNews: GetNewsUseCase) {
        newsList = getNews.retrieveAll().asDriver(onErrorJustReturn: [])
    }
}
