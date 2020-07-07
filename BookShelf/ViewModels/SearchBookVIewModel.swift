//
//  SearchBookVIewModel.swift
//  BookShelf
//
//  Created by 村尾慶伸 on 2020/07/07.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import Combine

class SearchBookViewModel {

    var commponents: URLComponents {
        var commponents = URLComponents()
        commponents.scheme = "https"
        commponents.host = "www.googleapis.com"
        commponents.path = "/books/v1/volumes"
        commponents.queryItems = [URLQueryItem(name: "q", value: "マリアビートル")]
        return commponents
    }

//    func fetchData() -> AnyPublisher<BookContainer, Error> {
//        return URLSession.shared.dataTaskPublisher(for: commponents.url!)
//            .map { $0.data }
//            .decode(type: BookContainer.self, decoder: JSONDecoder())
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
//    }

}


