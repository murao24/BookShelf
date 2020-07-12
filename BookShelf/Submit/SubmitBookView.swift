//
//  SubmitBookView.swift
//  BookShelf
//
//  Created by 村尾慶伸 on 2020/07/09.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct SubmitBookView: View {

    @ObservedObject var submitBookVM = SubmitBookViewModel()

    @Environment(\.presentationMode) var presentatinoMode

    @State var isNavigationBarHidden = false


    var body: some View {
        NavigationView {
            Form {
                Section(header: SectionHeader(text: "Book information(required)")) {
                    TextField("Title", text: $submitBookVM.title)
                    TextField("Author", text: $submitBookVM.author)
                }
                Section(header: Text("Rating")) {
                    RatingsView(rating: $submitBookVM.rating)
                }
                Section(header: Text("Date")) {
                    DatePicker("Start Date", selection: $submitBookVM.start, displayedComponents: .date)
                    DatePicker("Ends Date", selection: $submitBookVM.end, displayedComponents: .date)
                }
                Section(header: Text("Book reviews")) {
                    MultilineTextField(text: $submitBookVM.reviews, isNavigationBarHidden: self.$isNavigationBarHidden)
                        .frame(width: UIScreen.main.bounds.width * 0.9, height: 200)
                        .onTapGesture {
                            self.isNavigationBarHidden = true
                    }
                }
            }
            .navigationBarTitle("Submit a book")
            .navigationBarHidden(isNavigationBarHidden)
            .navigationBarItems(
                leading:
                Button(action: {
                    self.presentatinoMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                }, trailing:
                Button(action: {
                    //　firebaseに追加
                    self.submitBookVM.submitBook()
                    self.presentatinoMode.wrappedValue.dismiss()
                }) {
                    if submitBookVM.isValidated {
                        Text("Done")
                    }
                }
            )
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
    @Binding var isNavigationBarHidden: Bool

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

        func textViewDidEndEditing(_ textView: UITextView) {
            self.parent.isNavigationBarHidden = false
        }

    }

}

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

struct SectionHeader: View {
    let text: String
    var body: some View {
        Text(text)
            .padding()
            .frame(width: UIScreen.main.bounds.width, height: 28,alignment: .leading)
            .foregroundColor(Color.red)
    }
}
