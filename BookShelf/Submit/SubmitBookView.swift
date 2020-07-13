//
//  SubmitBookView.swift
//  BookShelf
//
//  Created by 村尾慶伸 on 2020/07/09.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct SubmitBookView: View {

    @ObservedObject var bookVM = BookViewModel()

    @Environment(\.presentationMode) var presentatinoMode

    @State var isNavigationBarHidden = false

    var body: some View {
        NavigationView {
            VStack {
                Text(bookVM.errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                Form {
                    Section(header: SectionHeader(text: "Book information(required)")) {
                        TextField("Title", text: $bookVM.title)
                        TextField("Author", text: $bookVM.author)
                    }
                    Section(header: Text("Rating")) {
                        RatingsView(rating: $bookVM.rating)
                    }
                    Section(header: Text("Date")) {
                        DatePicker("Start Date", selection: $bookVM.start, displayedComponents: .date)
                        DatePicker("Ends Date", selection: $bookVM.end, displayedComponents: .date)
                    }
                    Section(header: Text("Book review")) {
                        MultilineTextField(text: $bookVM.review, isNavigationBarHidden: self.$isNavigationBarHidden)
                            .frame(width: UIScreen.main.bounds.width * 0.9, height: 200)
                            .onTapGesture {
                                self.isNavigationBarHidden = true
                        }
                    }
                }
                .navigationBarTitle("Submit a book", displayMode: .automatic)
                .navigationBarHidden(isNavigationBarHidden)
                .navigationBarItems(
                    leading:
                    Button(action: {
                        self.presentatinoMode.wrappedValue.dismiss()
                    }) {
                        Text("Cancel")
                    }, trailing:
                    Button(action: {
                        //　firebaseに追加
                        self.bookVM.submitBook()
                        self.presentatinoMode.wrappedValue.dismiss()
                    }) {
                        Text("Done")
                    }
                    .disabled(!bookVM.isValidated)
                )
            }
        }
    }
}

struct SubmitBookView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitBookView()
    }
}


