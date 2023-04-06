//
//  LoginView.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 5.04.23.
//

import SwiftUI
import Firebase

struct LoginView: View {
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
                    .padding(15)
                    .background(.clear)
                
                TextField("Password", text: $password)
                    //.textFieldStyle(.roundedBorder)
                    .padding(15)
                    .background(.clear)
                            
                Button("Login") {
                    login()
                    dismiss()
                    
                }
                .foregroundColor(.black)
                .padding(25)
                
                Button("Forget password") {
                    print("Succesfuly login\n \(email) - \(password)")
                    dismiss()
                    
                }
                .foregroundColor(.black)
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
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
