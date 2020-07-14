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
    @ObservedObject var bookListVM = BookListViewModel()
    @State var isNavigationBarHidden = false
    @State var isAlertShown = false
    @Binding var isPopup: Bool
    @Binding var popupMessage: String

    var body: some View {
        VStack {
            if bookVM.errorMessage != "" {
                Text(bookVM.errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            Form() {
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
                    MultilineTextField(text: $bookCellVM.book.review, isNavigationBarHidden: self.$isNavigationBarHidden)
                        .frame(width: UIScreen.main.bounds.width * 0.9, height: 200)
                        .onTapGesture {
                            self.isNavigationBarHidden = true
                    }
                }
                Button(action: {
                    self.isAlertShown.toggle()
                }) {
                    Text("Delete")
                        .foregroundColor(.red)
                        .fontWeight(.bold)
                        .frame(alignment: .center)
                        .padding()
                        .frame(width: UIScreen.main.bounds.width - 30, height: 30, alignment: .center)
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
            .alert(isPresented: $isAlertShown) {
                Alert(
                    title: Text("Are you sure you want to delete it?"),
                    message: Text(""),
                    primaryButton: .cancel(Text("Cancel")),
                    secondaryButton: .destructive(Text("Delete"), action: {
                        self.bookListVM.deleteBook(self.bookCellVM.id)
                        self.isPopup.toggle()
                        self.popupMessage = "Book successfully deleted from your shelf!"
                        self.presentatinoMode.wrappedValue.dismiss()
                    })
                )
            }
            .navigationBarTitle("Edit a book", displayMode: .inline)
            .navigationBarItems(
                trailing:
                Button(action: {
                    self.bookVM.updateBook(self.bookCellVM.book.id)
                    self.isPopup.toggle()
                    self.popupMessage = "Book successfully updated!"
                    self.presentatinoMode.wrappedValue.dismiss()
                }) {
                    Text("Update")
                }
                .disabled(!bookVM.isValidated)
            )
        }
    }
}

//struct BookDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditBookView(bookCellVM: BookCellViewModel(book: Book(title: "String", author: "", rating: 4, review: "", start: Date(), end: Date())))
//    }
//}
