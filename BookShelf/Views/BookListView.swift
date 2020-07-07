//
//  ContentView.swift
//  BookShelf
//
//  Created by 村尾慶伸 on 2020/07/05.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct BookListView: View {

    @ObservedObject var bookListVM = BookListViewModel()

    @State var isActionSheet: Bool = false

    let books = testDataBooks

    var body: some View {
        TabView {
            NavigationView {
                List {
                    ForEach(bookListVM.bookCellViewModels) { bookCellVM in
                        BookCell(bookCellVM: bookCellVM)
                    }
                }
                .navigationBarTitle("BookShelf")
            }
            .tabItem {
                Image(systemName: "book")
                Text("BookShelf")
            }
            SearchBookView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView()
    }
}


struct BookCell: View {

    @ObservedObject var bookCellVM: BookCellViewModel

    var body: some View {
        HStack {
            Text(bookCellVM.book.title)
            Spacer()
            Text(bookCellVM.book.author)
        }
    }
}


