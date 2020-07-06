//
//  ContentView.swift
//  BookShelf
//
//  Created by 村尾慶伸 on 2020/07/05.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    let books = testDataBooks

    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    BookCell(book: book)
                }
            }
            .navigationBarTitle("BookShelf")
            .navigationBarItems(trailing:
                Button(action: {
                    print("Button Tapped")
                }) {
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
        ContentView()
    }
}


struct BookCell: View {
    let book: Book

    var body: some View {
        HStack {
            Text(book.title)
            Spacer()
            Text(book.author)
        }
    }
}
