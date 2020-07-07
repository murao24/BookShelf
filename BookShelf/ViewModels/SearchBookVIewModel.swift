//
//  SearchBookVIewModel.swift
//  BookShelf
//
//  Created by 村尾慶伸 on 2020/07/07.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import Combine
import SwiftyJSON

class SearchBookViewModel: ObservableObject {

    @Published var data = [SearchedBook]()

    var commponents: URLComponents {
        var commponents = URLComponents()
        commponents.scheme = "https"
        commponents.host = "www.googleapis.com"
        commponents.path = "/books/v1/volumes"
        commponents.queryItems = [URLQueryItem(name: "q", value: "伊坂幸太郎")]
        return commponents
    }


    init() {

        let urlSession = URLSession(configuration: .default)

        urlSession.dataTask(with: commponents.url!) { (data, _, error) in
            guard error == nil else  {
                print((error?.localizedDescription)!)
                return
            }

            let json = try! JSON(data: data!)
            let items = json["items"].array!

            for i in items {
                let id = i["id"].stringValue
                let title = i["volumeInfo"]["title"].stringValue
                let authors = i["volumeInfo"]["authors"].array!
                var author = ""

                for j in authors {
                    author += "\(j.stringValue)"
                }

                let description = i["volumeInfo"]["description"].stringValue
                let imageURL = i["volumeInfo"]["imageLinks"]["thumbnail"].stringValue

                DispatchQueue.main.async {
                    self.data.append(SearchedBook(id: id, title: title, authors: author, description: description, imageURL: imageURL))
                }
            }

        }.resume()

    }

}


