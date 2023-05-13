//
//  RegisterView.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 6.04.23.
//

import SwiftUI
import Firebase

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.red, Color.purple, Color.blue], startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                
                TextField("Email", text: $email)
                    //.textFieldStyle(.roundedBorder)
                    .keyboardType(.emailAddress)
                    .padding(15)
                    .background(.clear)
                
                TextField("Password", text: $password)
                    //.textFieldStyle(.roundedBorder)
                    .padding(15)
                    .background(.clear)
                            
                Button("Sign Up") {
                    register()
                    dismiss()
                    
                }
                .foregroundColor(.black)
                .padding(25)
            }
        }
    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("Registred new user\n Email - \(email)\n Password - \(password)")
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
