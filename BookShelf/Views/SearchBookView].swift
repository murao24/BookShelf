//
//  SubmitBookView].swift
//  BookShelf
//
//  Created by 村尾慶伸 on 2020/07/07.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct SearchBookView: View {

    @ObservedObject var bookCellVM: BookCellViewModel

    var onCommit: (Book) -> (Void) = { _ in }

    var body: some View {
        TabView {
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
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search books")
            }
        }
    }

}

struct SearchBookView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBookView(bookCellVM: BookCellViewModel(book: Book(title: "", author: "")))
    }
}
