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
    @State var isPopup: Bool = false
    @State var popupMessage: String = ""
    @State var isSortPopup: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                WaterfallGrid(self.bookListVM.bookCellViewModels) { bookCellVM in
                    NavigationLink(destination: EditBookView(bookCellVM: bookCellVM, isPopup: self.$isPopup, popupMessage: self.$popupMessage)) {
                        SpineView(bookCellVM: bookCellVM)
                    }
                }
                .gridStyle(columns: 10, spacing: 5, padding: EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20), animation: .easeInOut)
                .scrollOptions(showsIndicators: true)
                .border(Color.secondary, width: 10)
                .sheet(isPresented: self.$isActionSheet) {
                    SubmitBookView(isPopup: self.$isPopup, popupMessage: self.$popupMessage)
                }
                .navigationBarTitle("BookShelf")
                .navigationBarItems(
                    leading:
                    Button(action: {
                        self.isSortPopup.toggle()
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
            .popup(isPresented: $isSortPopup, type: .toast, position: .top, animation: .default, closeOnTap: false, closeOnTapOutside: true) {
                HStack() {
                    Spacer()
                    Button(action: {
                        self.bookListVM.sortBook(sortedName: "author", descending: false)
                        self.isSortPopup.toggle()
                    }) { Text("author").padding(3)}
                        .background(Color.accentColor)
                        .cornerRadius(5)
                    Spacer()
                    Button(action: {
                        self.bookListVM.sortBook(sortedName: "title", descending: false)
                        self.isSortPopup.toggle()
                    }) { Text("title").padding(3)}
                        .background(Color.accentColor)
                        .cornerRadius(5)
                    Spacer()
                    Button(action: {
                        self.bookListVM.sortBook(sortedName: "createdTime")
                        self.isSortPopup.toggle()
                    }) { Text("date").padding(3)}
                        .background(Color.accentColor)
                        .cornerRadius(5)
                    Spacer()
                }
                .foregroundColor(Color.primary)
                .frame(width: 350, height: 50)
                .background(Color.primary)
                .cornerRadius(30)
                .position(x: UIScreen.main.bounds.width / 2, y: 180)
            }
            .popup(isPresented: $isPopup, animation: .easeOut, autohideIn: 2, closeOnTap: true) {
                HStack() {
                    Text(self.popupMessage)
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
