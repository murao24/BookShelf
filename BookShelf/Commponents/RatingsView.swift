//
//  RatingsView.swift
//  BookShelf
//
//  Created by 村尾慶伸 on 2020/07/13.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import SwiftUI

struct RatingsView: View {

    @Binding var rating: Int

    var body: some View {
        HStack(spacing: 12, content: {
            Text("Rating")
            Spacer()
            ForEach(0..<5) { i in
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(self.rating - 1 >= i ? .yellow : .gray)
                    .onTapGesture {
                        self.rating = i + 1
                }
            }
        })
    }
}
