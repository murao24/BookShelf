//
//  BookDetailView.swift
//  BookShelf
//
//  Created by 村尾慶伸 on 2020/07/12.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct EditBookView: View {

    @Environment(\.presentationMode) var presentatinoMode

    @ObservedObject var bookCellVM: BookCellViewModel
    @ObservedObject var bookVM = BookViewModel()
    @State var isNavigationBarHidden = false

    var body: some View {
        Form {
            Section(header: Text("book infomation")) {
                TextField(bookCellVM.book.title, text: $bookVM.title)
                TextField(bookCellVM.book.author, text: $bookVM.author)
            }
            Section(header: Text("rating")) {
                RatingsView(rating: $bookVM.rating)
            }
            Section(header: Text("Date")) {
                DatePicker("Start Date", selection: $bookVM.start, displayedComponents: .date)
                DatePicker("Ends Date", selection: $bookVM.end, displayedComponents: .date)
            }
            Section(header: Text("review")) {
                MultilineTextField(text: $bookCellVM.book.review, isNavigationBarHidden: $isNavigationBarHidden)
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 200)
                    .onTapGesture {
                        self.isNavigationBarHidden = true
                }
            }
        }
        .onAppear {
            self.bookVM.title = self.bookCellVM.book.title
            self.bookVM.author = self.bookCellVM.book.author
            self.bookVM.rating = self.bookCellVM.book.rating
            self.bookVM.start = self.bookCellVM.book.start
            self.bookVM.end = self.bookCellVM.book.end
            self.bookVM.review = self.bookCellVM.book.review
        }
        .navigationBarBackButtonHidden(isNavigationBarHidden)
        .navigationBarItems(trailing:
            Button(action: {
                self.bookVM.updateBook(self.bookCellVM.book.id)
                self.presentatinoMode.wrappedValue.dismiss()
            }) {
                if self.bookVM.isValidated {
                    Text("Update")
                }
            }
        )
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EditBookView(bookCellVM: BookCellViewModel(book: Book(title: "String", author: "", rating: 4, review: "", start: Date(), end: Date())))
    }
}
