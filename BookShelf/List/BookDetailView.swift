//
//  BookDetailView.swift
//  BookShelf
//
//  Created by 村尾慶伸 on 2020/07/12.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct BookDetailView: View {

    @ObservedObject var bookListVM = BookListViewModel()

    var body: some View {
        Text("Hello, World!")
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView()
    }
}
