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
                .background(Color.accentColor)
                .cornerRadius(3)
                Spacer()
                Text(data.description)
                    .font(.caption)
                    .lineLimit(4)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}

