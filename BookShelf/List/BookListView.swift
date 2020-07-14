//
//  ContentView.swift
//  BookShelf
//
//  Created by 村尾慶伸 on 2020/07/05.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI
import QGrid
import ExytePopupView

struct BookListView: View {
    
    @ObservedObject var bookListVM = BookListViewModel()
    
    @State var isActionSheet: Bool = false
    @State var isShowPopup: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                QGrid(
                    bookListVM.bookCellViewModels,
                    columns: 10,
                    vSpacing: 30,
                    hSpacing: 2,
                    vPadding: 20,
                    hPadding: 20
                ) { bookCellVM in
                    NavigationLink(destination: EditBookView(bookCellVM: bookCellVM)) {
                        SpineView(bookCellVM: bookCellVM)
                    }
                }
                .border(Color.secondary, width: 10)
                .sheet(isPresented: self.$isActionSheet) {
                    SubmitBookView()
                }
                .navigationBarTitle("BookShelf")
                .navigationBarItems(
                    leading:
                    Button(action: {
                        self.isShowPopup.toggle()
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
            .popup(isPresented: $isShowPopup, autohideIn: 2) {
                Text("Pop UP!")
            }
        .frame(width: 200, height: 50)
        .background(Color(red: 0.85, green: 0.8, blue: 0.95))
        .cornerRadius(30.0)
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

