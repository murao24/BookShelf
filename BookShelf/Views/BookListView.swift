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
                    SubmitBookView(bookCellVM: BookCellViewModel(book: Book(title: "", author: ""))) { book in
                        self.bookListVM.submitBook(book: book)
                        self.isActionSheet.toggle()
                    }
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

    @ObservedObject var bookCellVM: BookCellViewModel

    var onCommit: (Book) -> (Void) = { _ in }

    var body: some View {
        NavigationView {
            Form {
                TextField("Enter book title", text: $bookCellVM.book.title)
                TextField("Enter book author", text: $bookCellVM.book.author)
            }
        .navigationBarTitle("Submit a book")
            .navigationBarItems(trailing:
                Button(action: {
                    self.onCommit(self.bookCellVM.book)
                }) {
                    Text("done")
                }
            )
        }
    }

}
