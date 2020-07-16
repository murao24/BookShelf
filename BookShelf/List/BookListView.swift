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
    
    @State var isSubmitSheet: Bool = false
    @State var isPopup: Bool = false
    @State var isSortActionSheet: Bool = false
    @State var isSignInViewSheet: Bool = false
    @State var popupMessage: String = ""

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    SortCell(sortedName: $bookListVM.sortName, isSortActionSheet: $isSortActionSheet)
                    WaterfallGrid(self.bookListVM.bookCellViewModels) { bookCellVM in
                        NavigationLink(destination: EditBookView(bookCellVM: bookCellVM, isPopup: self.$isPopup, popupMessage: self.$popupMessage)) {
                            SpineView(bookCellVM: bookCellVM)
                        }
                    }
                    .gridStyle(
                        columns: 10,
                        spacing: 5,
                        padding: EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20),
                        animation: .easeInOut(duration: 0.5)
                    )
                        .scrollOptions(showsIndicators: true)
                        .border(Color.secondary, width: 8)
                        .actionSheet(isPresented: $isSortActionSheet) {
                            ActionSheet(title: Text(""), buttons:[
                                .default(Text("Default(Date Created)"), action: {
                                    self.bookListVM.sortBook(sortName: "createdTime")
                                }),
                                .default(Text("Author"), action: {
                                    self.bookListVM.sortBook(sortName: "author")
                                }),
                                .default(Text("Title"), action: {
                                    self.bookListVM.sortBook(sortName: "title")
                                }),
                                .cancel(Text("Cancel"))
                            ])
                    }
                    .navigationBarTitle("BookShelf")
                    .navigationBarItems(
                        leading:
                        Button(action: {
                            self.isSignInViewSheet.toggle()
                        }) {
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.orange)
                        }
                        .sheet(isPresented: self.$isSignInViewSheet) {
                            SignInView()
                        },
                        trailing:
                        Button(action: {
                            self.isSubmitSheet.toggle()
                        }) {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.orange)
                        }
                        .sheet(isPresented: self.$isSubmitSheet) {
                            SubmitBookView(isPopup: self.$isPopup, popupMessage: self.$popupMessage)
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

struct SortCell: View {

    @Binding var sortedName: String
    @Binding var isSortActionSheet: Bool

    var body: some View {
        HStack{
            Spacer()
            Text(sortedName)
                .font(.subheadline)
                .foregroundColor(.orange)
            Button(action: {
                self.isSortActionSheet.toggle()
            }) {
                Image(systemName: "chevron.down")
                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 25))
            }
            .foregroundColor(.orange)
        }
    }
}
