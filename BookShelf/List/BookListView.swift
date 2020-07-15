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
    
    @State var isSheet: Bool = false
    @State var isPopup: Bool = false
    @State var isActionSheet: Bool = false
    @State var popupMessage: String = ""

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack{
                        Image(systemName: "magnifyingglass")
                    }
                    WaterfallGrid(self.bookListVM.bookCellViewModels) { bookCellVM in
                        NavigationLink(destination: EditBookView(bookCellVM: bookCellVM, isPopup: self.$isPopup, popupMessage: self.$popupMessage)) {
                            SpineView(bookCellVM: bookCellVM)
                        }
                    }
                    .gridStyle(columns: 10, spacing: 25, padding: EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20), animation: .easeInOut(duration: 0.5))
                    .scrollOptions(showsIndicators: true)
                    .border(Color.secondary, width: 8)
                    .actionSheet(isPresented: $isActionSheet) {
                        ActionSheet(title: Text(""), buttons:[
                            .default(Text("Default(Date Created)"), action: {self.bookListVM.sortBook(sortedName: "createdTime")}),
                            .default(Text("Author"), action: {self.bookListVM.sortBook(sortedName: "author")}),
                            .default(Text("Title"), action: {self.bookListVM.sortBook(sortedName: "title")}),
                            .cancel(Text("Cancel"))
                        ])
                    }
                    .sheet(isPresented: self.$isSheet) {
                        SubmitBookView(isPopup: self.$isPopup, popupMessage: self.$popupMessage)
                    }
                    .navigationBarTitle("BookShelf")
                    .navigationBarItems(
                        leading:
                        Button(action: {
                            self.isActionSheet.toggle()
                        }) {
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: 20, height: 20)
                        },
                        trailing:
                        Button(action: { self.isSheet.toggle() }) {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                    )
                }
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
