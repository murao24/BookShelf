//
//  SubmitBookView].swift
//  BookShelf
//
//  Created by 村尾慶伸 on 2020/07/07.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct SearchBookView: View {

    @State private var searchText: String = ""

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, placeholder: "Search books")
                Spacer()
                Text(searchText)
                Spacer()
                    .navigationBarTitle("Search books")
            }
        }

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


    class Cordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }

    }

    func makeCoordinator() -> SearchBar.Cordinator {
        return Cordinator(text: $text)
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
