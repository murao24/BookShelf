//
//  BookRepository.swift
//  BookShelf
//
//  Created by 村尾慶伸 on 2020/07/07.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class BookRepository: ObservableObject {
    
    let db = Firestore.firestore()
    
    @Published var books = [Book]()
    @Published var sortedName = "createdTime"
    @Published var descending: Bool = true
    
    init() {
        loadData(sortedName: sortedName, descending: descending)
    }
    
    func loadData(sortedName: String, descending: Bool) {
        
        let userId = Auth.auth().currentUser?.uid

        db.collection("books")
            .order(by: sortedName, descending: descending)
            .whereField("userId", isEqualTo: userId!)
            .addSnapshotListener { (querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                    self.books = querySnapshot.documents.compactMap { document in
                        do {
                            let x = try document.data(as: Book.self)
                            return x
                        } catch {
                            print(error.localizedDescription)
                        }
                        return nil
                    }
                }
        }
        
    }
    
    func addBook(_ book: Book) {
        do {
            var addedBook = book
            addedBook.userId = Auth.auth().currentUser?.uid
            let _ = try db.collection("books").addDocument(from: addedBook)
        } catch {
            fatalError("Unable to encode book: \(error.localizedDescription)")
        }
    }

    func update(_ book: Book) {
        if let bookID = book.id {
            do {
                var updatedBook = book
                updatedBook.userId = Auth.auth().currentUser?.uid
                try db.collection("books").document(bookID).setData(from: updatedBook)
            } catch {
                fatalError("Unable to encode book: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteBook(bookID: String) {
        db.collection("books").document(bookID).delete() { error in
            if let error = error {
                print("Error removing document: \(error)")
            } else {
                print("Document successfully deleted.")
            }
        }
    }
    
}
