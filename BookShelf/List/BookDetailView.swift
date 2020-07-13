//
//  BookDetailView.swift
//  BookShelf
//
//  Created by 村尾慶伸 on 2020/07/12.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct EditBookView: View {

    @ObservedObject var bookCellVM: BookCellViewModel
    @ObservedObject var submitBookVM = SubmitBookViewModel()
    @State var isNavigationBarHidden = false

    var body: some View {
        Form {
            Section(header: Text("book infomation")) {
                TextField(bookCellVM.book.title, text: $submitBookVM.title)
                TextField(bookCellVM.book.author, text: $submitBookVM.author)
            }
            Section(header: Text("rating")) {
                RatingsView(rating: $submitBookVM.rating)
            }
            Section(header: Text("Date")) {
                DatePicker("Start Date", selection: $submitBookVM.start, displayedComponents: .date)
                DatePicker("Ends Date", selection: $submitBookVM.end, displayedComponents: .date)
            }
            Section(header: Text("review")) {
                MultilineTextField(text: $submitBookVM.review, isNavigationBarHidden: $isNavigationBarHidden)
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 200)
                    .onTapGesture {
                        self.isNavigationBarHidden = true
                }
            }
        }
        .navigationBarBackButtonHidden(isNavigationBarHidden)
        .navigationBarItems(trailing:
            Button(action: {}) {
                Text("Update")
            }
        )
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EditBookView(bookCellVM: BookCellViewModel(book: Book(title: "String", author: "", rating: 4, review: "", start: Date(), end: Date())))
    }
}
