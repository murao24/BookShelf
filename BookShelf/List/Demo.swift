//
//  Demo.swift
//  BookShelf
//
//  Created by 村尾慶伸 on 2020/07/13.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct Demo: View {
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach((0...39), id: \.self) { row in
                    HStack {
                        ForEach((1...8), id: \.self) { column in
                            SpineVIew(title: "夜のピクニック", author: "恩田陸")
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .border(Color.red, width: 2)
                }
            }
        }
    }
}

struct Demo_Previews: PreviewProvider {
    static var previews: some View {
        Demo()
    }
}
