//
//  ContentView.swift
//  Abraxahs
//
//  Created by Shervin Lepinat on 25.08.22.
//

import SwiftUI
import UIKit
import FirebaseAuth

struct LoginView: View {
    @State private var email = "";
    @State private var password = "";
    @State private var wrongEmail = 0;
    @State private var wrongPassword = 0;
    @State private var showingLoginScreen = false;
    
    var body: some View {
        NavigationView {
            ZStack {
                Color
                    .blue
                    .ignoresSafeArea();
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15));
                Circle()
                    .scale(1.35)
                    .foregroundColor(.white);
                
                VStack {
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .padding();
                    TextField("Email", text: $email)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongEmail));
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongPassword));
                    
                    Button("Login") {
                        authenticateUser(email: email, password: password);
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10);
                    
                    NavigationLink(destination: GroupsView(), isActive: $showingLoginScreen) {
                    }
                }
            }
        }
    }
    
    func authenticateUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let user = user {
                wrongEmail = 0;
                wrongPassword = 0;
                showingLoginScreen = true;
            } else {
                wrongEmail = 2;
                wrongPassword = 2
            }
        }
    }
}

struct GroupsView: View {
    var body: some View {
        VStack {
            Text("Hello World ok");
            
        }.navigationTitle("Gruppen")
            .toolbar {
                NavigationLink(destination: LoginView(), label: {
                    Text("Logout")
                        .bold()
                })
            }.navigationBarBackButtonHidden(true);
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .previewDevice("iPhone 11 Pro")
            .previewInterfaceOrientation(.portrait)
    }
}
