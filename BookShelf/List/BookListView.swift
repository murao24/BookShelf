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

    var body: some View {
        NavigationView {
            List {
                ForEach(bookListVM.bookCellViewModels) { bookCellVM in
                    NavigationLink(destination: BookDetailView()) {
                        BookCell(bookCellVM: bookCellVM)
                    }
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
            Text(bookCellVM.book.title)
            Spacer()
            Text(bookCellVM.book.author)
        }
    }
}


