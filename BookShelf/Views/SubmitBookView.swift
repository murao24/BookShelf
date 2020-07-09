//
//  SubmitBookView.swift
//  BookShelf
//
//  Created by 村尾慶伸 on 2020/07/09.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct SubmitBookView: View {
    @State var title: String = ""
    @State var author: String = ""
    @State var rating: String = ""
    @State var reviews: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Book information")) {
                    TextField("Title", text: self.$title)
                    TextField("Author", text: self.$author)
                    TextField("Ratring", text: self.$rating)
                }
                Section(header: Text("Book reviews")) {
                    MultilineTextField(text: self.$reviews)
                        .frame(width: UIScreen.main.bounds.width * 0.9, height: 200)
                }
            }
            .navigationBarTitle("Submit a book")
        }
    }
}

struct SubmitBookView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitBookView()
    }
}

struct MultilineTextField: UIViewRepresentable {

    @Binding var text: String

    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.delegate = context.coordinator
        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.font = UIFont.systemFont(ofSize: 16)
        return view
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        if uiView.text != text {
            uiView.text = text
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: MultilineTextField

        init(_ textView: MultilineTextField) {
            self.parent = textView
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return true
        }

        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
        }

    }

}
