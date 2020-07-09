//
//  SubmitBookView].swift
//  BookShelf
//
//  Created by 村尾慶伸 on 2020/07/07.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import WebKit

struct SearchBookView: View {

    @ObservedObject var searchBookViewModel = SearchBookViewModel()

    @State private var searchText: String = ""
    @State var url = ""
    @State var isSheetShown = false

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, placeholder: "Search books", onCommit: searchBooks)
                Spacer()
                List {
                    ForEach(searchBookViewModel.data, id: \.self) { data in
                        SearchedBookCell(data: data)
                            .onTapGesture {
                                self.url = data.previewLink
                                print(self.url)
                                self.isSheetShown.toggle()
                        }
                    }
                }
                .sheet(isPresented: self.$isSheetShown) {
                    WebView(urlString: self.url)
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


struct SearchedBookCell: View {

    var data: SearchedBook

    var body: some View {
        HStack {
            if data.imageURL != "" {
                WebImage(url: URL(string: data.imageURL)!)
                    .resizable()
                    .frame(width: 120, height: 170)
                    .cornerRadius(10)
            } else {
                VStack {
                    Image(systemName: "exclamationmark.triangle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .cornerRadius(10)
                    Text("No Image")
                        .font(.subheadline)
                }
                .frame(width: 120, height: 170)
            }
            VStack(alignment: .center) {
                Spacer()
                Text(data.title)
                Text(data.authors)
                Spacer()
                Text(data.description)
                    .font(.caption)
                    .lineLimit(4)
                    .multilineTextAlignment(.leading)
            }
        }
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


struct WebView: UIViewRepresentable {

    let urlString: String?

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let urlString = urlString {
            if let url = URL(string: urlString) {
                let request = URLRequest(url: url)
                uiView.load(request)
            }
        }
    }

}
