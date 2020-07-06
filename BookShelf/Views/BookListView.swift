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
        NavigationView {
            List {
                ForEach(bookListVM.bookCellViewModels) { bookCellVM in
                    BookCell(bookCellVM: bookCellVM)
                }
            }
            .navigationBarTitle("BookShelf")
            .navigationBarItems(trailing:
                Button(action: {
                    self.isActionSheet.toggle()
                }) {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                .sheet(isPresented: $isActionSheet, content: {
                    SubmitBookView()
                })
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
            Text(bookCellVM.book.title)
            Spacer()
            Text(bookCellVM.book.author)
        }
    }
}

struct SubmitBookView: View {
    @State private var title: String = ""
    @State private var author: String = ""

    var body: some View {
        Form {
            TextField("Enter book title", text: $title)
            TextField("Enter book author", text: $author)
        }
    }

}
