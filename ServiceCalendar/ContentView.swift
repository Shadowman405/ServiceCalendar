//
//  ContentView.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 5.04.23.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @State private var isPresentedReg = false
    @State private var isUserLoggedIn = false
    @State private var email = ""
    @State private var password = ""

    
    var body: some View {
        
        ZStack {
            LinearGradient(colors: [Color.red, Color.purple, Color.blue], startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            ZStack {
                VStack(alignment: .center) {
                    Text("Service Calendar")
                        .font(.system(size: 36, weight: .heavy, design: .serif))
                    
                    HStack {
                        Image("logo_v2fix")
                            .scaledToFill()
                        .foregroundColor(.accentColor)
                        
                    }
                    .padding(10)
                    
                    VStack {
                        TextField("Email", text: $email)
                            //.textFieldStyle(.roundedBorder)
                            .padding(5)
                        .background(.clear)
                        
                        TextField("Password", text: $password)
                            //.textFieldStyle(.roundedBorder)
                            .padding(5)
                            .background(.clear)
                    }
                    .padding(25)
                                
                    Button("Login") {
                        login()
                        
                    }
                    .buttonStyle(.bordered)
                    .tint(.red)
                    .cornerRadius(10)
                    .foregroundColor(.black)
                    .controlSize(.large)
                    .font(.system(size: 20, weight: .heavy, design: .serif))
                    
                    Button("Register") {
                        self.isPresentedReg.toggle()

                    }
                    .sheet(isPresented: $isPresentedReg, content: {
                        RegisterView()
                    })
                    .buttonStyle(.bordered)
                    .tint(.red)
                    .cornerRadius(10)
                    .foregroundColor(.black)
                    .controlSize(.large)
                    .font(.system(size: 20, weight: .heavy, design: .serif))
                }
            }
            .padding()
            .onAppear {
                Auth.auth().addStateDidChangeListener { auth, user in
                    if user != nil {
                        isUserLoggedIn.toggle()
                    }
                }
            }
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("Loged In")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
