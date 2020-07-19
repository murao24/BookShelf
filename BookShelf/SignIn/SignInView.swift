//
//  SignInView.swift
//  BookShelf
//
//  Created by 村尾慶伸 on 2020/07/15.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import ExytePopupView

struct SignInView: View {
    
    @ObservedObject var signInVM = SignInViewModel()
    @Environment(\.presentationMode) var presentatinoMode

    let user = Auth.auth().currentUser
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {

                    if user?.isAnonymous ?? true {
                        Text("Thank you for using this app. Please sign in here.")
                        SignInWithAppleButton()
                            .frame(width: 200, height: 45)
                            .onTapGesture {
                                self.signInVM.signIn()
                        }
                    } else {
                        Text("You are logged in with apple.")
                            .padding()
                        Button(action: {
                            self.signInVM.signOut()
                        }) {
                            Text("Sign out.")
                                .font(.body)
                        }
                        .frame(width: 200, height: 45)
                        .background(Color.primary)
                        .cornerRadius(5)
                    }
                }
            }
            .popup(isPresented: self.$signInVM.isPopup, autohideIn: 3, closeOnTap: true, closeOnTapOutside: true) {
                HStack {
                    Text(self.signInVM.popupMessage)
                }
                .frame(width: 350, height: 50)
                .background(Color(red: 0.85, green: 0.8, blue: 0.95))
                .cornerRadius(30)
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .environment(\.colorScheme, .light)
    }
}
