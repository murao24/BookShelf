//
//  SignInView.swift
//  BookShelf
//
//  Created by 村尾慶伸 on 2020/07/15.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    
    @State var coordinator: SignInWithAppleCoordinator?
    
    var body: some View {
        NavigationView {
            VStack {
                SignInWithAppleButton()
                    .frame(width: 200, height: 45)
                    .onTapGesture {
                        self.coordinator = SignInWithAppleCoordinator()
                        if let coordinator = self.coordinator {
                            coordinator.startSignInWithAppleFlow {
                                print("You successfully signed in.")
                            }
                        }
                }
                .navigationBarTitle("Sign In")
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
