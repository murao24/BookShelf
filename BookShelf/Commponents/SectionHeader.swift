//
//  SectionHeader.swift
//  BookShelf
//
//  Created by 村尾慶伸 on 2020/07/13.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import SwiftUI

struct SectionHeader: View {
    let text: String
    let color: Color = .red

    var body: some View {
        Text(text)
            .padding()
            .frame(width: UIScreen.main.bounds.width, height: 28,alignment: .leading)
            .foregroundColor(color)
    }
}


