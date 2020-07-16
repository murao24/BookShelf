//
//  TabView.swift
//  BookShelf
//
//  Created by 村尾慶伸 on 2020/07/08.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            BookListView()
                .tabItem {
                    Image(systemName: "book")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("BookShelf")
            }
            SearchBookView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Search")
            }
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
