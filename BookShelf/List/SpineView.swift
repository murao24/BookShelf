//
//  SpineVIew.swift
//  BookShelf
//
//  Created by 村尾慶伸 on 2020/07/13.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI
import CoreText
import UIKit

struct SpineView: View {

    @ObservedObject var bookCellVM: BookCellViewModel

    var body: some View {
        TategakiText(text: """
            \(bookCellVM.book.title)
            """
            )
            .frame(width: 30, height: 120)
            .border(Color.orange, width: 2)
            .background(Color.orange)
            .shadow(radius: 5)
            .cornerRadius(5)
    }
}

struct SpineVIew_Previews: PreviewProvider {
    static var previews: some View {
        SpineView(bookCellVM: BookCellViewModel(book: Book(title: "", author: "", rating: 4, review: "", start: Date(), end: Date())))
            .previewLayout(.fixed(width: 35, height: 120))
    }
}


public struct TategakiText: UIViewRepresentable {
    public var text: String?

    public func makeUIView(context: Context) -> TategakiTextView {
        let uiView = TategakiTextView()
        uiView.isOpaque = false
        uiView.text = text
        return uiView
    }

    public func updateUIView(_ uiView: TategakiTextView, context: Context) {
        uiView.text = text
    }
}

public class TategakiTextView: UIView {
    public var text: String? = nil {
        didSet {
            ctFrame = nil
        }
    }
    private var ctFrame: CTFrame? = nil

    override public func draw(_ rect: CGRect) {
        guard let context:CGContext = UIGraphicsGetCurrentContext() else {
            return
        }
        context.scaleBy(x: 1, y: -1)
        context.translateBy(x: -7, y: -rect.height-3)

        let baseAttributes: [NSAttributedString.Key : Any] = [
            .verticalGlyphForm: true,
            .font: UIFont.italicSystemFont(ofSize: 15),
            .foregroundColor: UIColor.label
        ]
        let attributedText = NSMutableAttributedString(string: text ?? "", attributes: baseAttributes)
        let setter = CTFramesetterCreateWithAttributedString(attributedText)
        let path = CGPath(rect: rect, transform: nil)
        let frameAttrs = [
            kCTFrameProgressionAttributeName: CTFrameProgression.rightToLeft.rawValue,
        ]
        let ct = CTFramesetterCreateFrame(setter, CFRangeMake(0, 0), path, frameAttrs as CFDictionary)
        ctFrame = ct

        CTFrameDraw(ct, context)
    }
}
