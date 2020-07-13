//
//  ContentView.swift
//  BookShelf
//
//  Created by 村尾慶伸 on 2020/07/05.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI
import QGrid

struct BookListView: View {

    @ObservedObject var bookListVM = BookListViewModel()

    @State var isActionSheet: Bool = false

    var body: some View {
        NavigationView {
            QGrid(
                bookListVM.bookCellViewModels,
                columns: 10,
                vSpacing: 20,
                hSpacing: 2,
                vPadding: 20,
                hPadding: 20
            ) { bookCellVM in
                NavigationLink(destination: EditBookView(bookCellVM: bookCellVM)) {
                    BookCell(bookCellVM: bookCellVM)
                }
            }
            .sheet(isPresented: self.$isActionSheet) {
                SubmitBookView()
            }
            .navigationBarTitle("BookShelf")
            .navigationBarItems(trailing:
                Button(action: { self.isActionSheet.toggle() }) {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            )
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
            SpineView(title: bookCellVM.book.title, author: bookCellVM.book.author)
        }
    }
}


