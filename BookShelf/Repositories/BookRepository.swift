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

    init() {
        loadData()
    }

    func loadData() {

        db.collection("books")
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

}
