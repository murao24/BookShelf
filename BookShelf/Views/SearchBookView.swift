//
//  SubmitBookView].swift
//  BookShelf
//
//  Created by 村尾慶伸 on 2020/07/07.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct SearchBookView: View {

    @ObservedObject var searchBookViewModel = SearchBookViewModel()

    @State private var searchText: String = ""

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, placeholder: "Search books", onCommit: searchBooks)
                Spacer()
                List {
                    ForEach(searchBookViewModel.data, id: \.self) { data in
                        HStack {
                            if data.imageURL != "" {
                                WebImage(url: URL(string: data.imageURL)!)
                                .resizable()
                                .frame(width: 120, height: 170)
                                .cornerRadius(10)
                            } else {
                                VStack {
                                    Image(systemName: "book")
                                        .resizable()
                                        .frame(width: 110, height: 140)
                                        .cornerRadius(10)
                                    Text("No Image")
                                }
                            }
                            VStack {
                                Text(data.title)
                                Text(data.authors)
                                Text(data.description)
                                    .font(.caption)
                                    .lineLimit(4)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                    }
                }
                Spacer()
                    .navigationBarTitle("Search books")
            }
        }
    }

    func searchBooks(for searchText: String) {
        searchBookViewModel.searchText  = searchText
        searchBookViewModel.fetchData()
    }
}


struct SearchBookView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBookView()
    }
}

struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String

    var onCommit: (String) -> Void

    class Cordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String

        var onCommit: (String) -> Void

        init(text: Binding<String>, onCommit: @escaping (String) -> Void) {
            _text = text
            self.onCommit = onCommit
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
            searchBar.showsCancelButton = true
        }

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
            searchBar.showsCancelButton = false
            searchBar.endEditing(true)
            if let text = searchBar.text {
                onCommit(text)
            }
        }

        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.text = ""
            searchBar.resignFirstResponder()
            searchBar.showsCancelButton = false
            searchBar.endEditing(true)
        }

    }

    func makeCoordinator() -> SearchBar.Cordinator {
        return Cordinator(text: $text, onCommit: onCommit)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeholder
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context:  UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }

}


