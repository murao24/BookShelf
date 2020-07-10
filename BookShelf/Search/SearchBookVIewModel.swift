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

    @Published var searchText: String = ""

    var commponents: URLComponents {
        var commponents = URLComponents()
        commponents.scheme = "https"
        commponents.host = "www.googleapis.com"
        commponents.path = "/books/v1/volumes"
        commponents.queryItems = [URLQueryItem(name: "q", value: searchText), URLQueryItem(name: "maxResults", value: "40")]
        return commponents
    }


    func fetchData()  {
        guard let url = commponents.url else { return }

        data = [SearchedBook]()

        let urlSession = URLSession(configuration: .default)

        urlSession.dataTask(with: url) { (data, _, error) in
            guard error == nil else  {
                print((error?.localizedDescription)!)
                return
            }

            let json = try! JSON(data: data!)
            if let items = json["items"].array {

                for i in items {
                    let id = i["id"].stringValue
                    let title = i["volumeInfo"]["title"].stringValue

                    var author = ""
                    if let authors = i["volumeInfo"]["authors"].array {
                        author = authors.description.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "")
                    } else {
                        author = "No author information is available."
                    }

                    let description = i["volumeInfo"]["description"].stringValue
                    var imageURL = i["volumeInfo"]["imageLinks"]["thumbnail"].stringValue
                    var previewLink = i["volumeInfo"]["previewLink"].stringValue

                    // http -> https
                    if imageURL != "" {
                        let insertIndexToImageURL = imageURL.index(imageURL.startIndex, offsetBy: 4)
                        imageURL.insert(contentsOf: "s", at: insertIndexToImageURL)
                    }
                    if previewLink != "" {
                        let insertIndexToPreviewLink = previewLink.index(previewLink.startIndex, offsetBy: 4)
                        previewLink.insert(contentsOf: "s", at: insertIndexToPreviewLink)
                    }

                    DispatchQueue.main.async {
                        self.data.append(SearchedBook(id: id, title: title, authors: author, description: description, imageURL: imageURL, previewLink: previewLink))
                    }
                }
            }
        }.resume()
    }

}


