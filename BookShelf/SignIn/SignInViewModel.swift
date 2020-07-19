//
//  SignInViewModel.swift
//  BookShelf
//
//  Created by 村尾慶伸 on 2020/07/19.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import Combine
import FirebaseAuth

class SignInViewModel: ObservableObject {

    @Published var bookListVM = BookListViewModel()
    @Published var coordinator: SignInWithAppleCoordinator?
    @Published var popupMessage: String = ""
    @Published var isPopup: Bool = false

    func signIn() {
        self.coordinator = SignInWithAppleCoordinator()
        if let coordinator = self.coordinator {
            coordinator.startSignInWithAppleFlow {
                self.isPopup.toggle()
                self.popupMessage = "You successfully signed in. \n Please restart this app."
                print("You successfully signed in.")
            }
        }
    }

    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.isPopup.toggle()
            self.popupMessage = "You successfully signed out. \n Please restart this app."
            print("You successfully signed out.")
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }

}
