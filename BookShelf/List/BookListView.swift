//
//  ContentView.swift
//  BookShelf
//
//  Created by 村尾慶伸 on 2020/07/05.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI
import WaterfallGrid
import ExytePopupView

struct BookListView: View {
    
    @ObservedObject var bookListVM = BookListViewModel()
    
    @State var isActionSheet: Bool = false
    @State var isShowPopup: Bool = true
    
    var body: some View {
        NavigationView {
            ZStack {
//                QGrid(
//                    bookListVM.bookCellViewModels,
//                    columns: 10,
//                    vSpacing: 30,
//                    hSpacing: 2,
//                    vPadding: 20,
//                    hPadding: 20
//                ) { bookCellVM in
//                    NavigationLink(destination: EditBookView(bookCellVM: bookCellVM)) {
//                        SpineView(bookCellVM: bookCellVM)
//                    }
//                }
//                List {
//                    ForEach(self.bookListVM.bookCellViewModels) { bookCellVM in
//                        BookCell(bookCellVM: bookCellVM)
//                    }
//                }
                WaterfallGrid(self.bookListVM.bookCellViewModels) { bookCellVM in
                    SpineView(bookCellVM: bookCellVM)
                }
                .gridStyle(columns: 10, animation: .none)
//                .border(Color.secondary, width: 10)
                .sheet(isPresented: self.$isActionSheet) {
                    SubmitBookView()
                }
                .navigationBarTitle("BookShelf")
                .navigationBarItems(
                    leading:
                    Button(action: {

                    }) {
                        Image(systemName: "arrow.up.arrow.down")
                    },
                    trailing:
                    Button(action: { self.isActionSheet.toggle() }) {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                )
            }
            .popup(isPresented: $isShowPopup, animation: .easeOut, autohideIn: 2, closeOnTap: true) {
                HStack() {
                    Text("Book successfully added to your shelf!")
                }
                .frame(width: 350, height: 50)
                .background(Color(red: 0.85, green: 0.8, blue: 0.95))
                .cornerRadius(30.0)
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BookListView()
                .environment(\.colorScheme, .light)
            BookListView()
                .environment(\.colorScheme, .dark)
        }
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
