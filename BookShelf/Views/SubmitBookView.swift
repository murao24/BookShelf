//
//  SubmitBookView.swift
//  BookShelf
//
//  Created by 村尾慶伸 on 2020/07/09.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct SubmitBookView: View {
    @State var title: String = ""
    @State var author: String = ""
    @State var rating: String = ""
    @State var reviews: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Book information")) {
                    TextField("Title", text: self.$title)
                    TextField("Author", text: self.$author)
                    TextField("Ratring", text: self.$rating)
                }
                Section(header: Text("Book reviews")) {
                    TextField("Reviews", text: self.$reviews)
                }
            }
            .navigationBarTitle("Submit a book")
        }
    }
}

struct SubmitBookView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitBookView()
    }
}
