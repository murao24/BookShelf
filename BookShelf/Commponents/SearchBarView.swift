//
//  SearchBarView.swift
//  BookShelf
//
//  Created by 村尾慶伸 on 2020/07/09.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

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

        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = true
        }

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
            if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
                cancelButton.isEnabled = true
            }
            searchBar.endEditing(true)
            if let text = searchBar.text {
                onCommit(text)
            }
        }

        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            text = ""
            searchBar.resignFirstResponder()
            searchBar.showsCancelButton = false
            searchBar.endEditing(true)
            onCommit("")
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
