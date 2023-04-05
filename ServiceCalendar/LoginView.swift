//
//  LoginView.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 5.04.23.
//

import SwiftUI

struct LoginView: View {
    @State private var userName = ""
    @State private var password = ""
    @Environment(\.dismiss) private var dismiss

    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.red, Color.purple, Color.blue], startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                
                TextField("Username", text: $userName)
                    //.textFieldStyle(.roundedBorder)
                    .padding(15)
                    .background(.clear)
                
                TextField("Password", text: $password)
                    //.textFieldStyle(.roundedBorder)
                    .padding(15)
                    .background(.clear)
                            
                Button("Log In") {
                    print("Succesfuly login\n \(userName) - \(password)")
                    dismiss()
                    
                }
                .foregroundColor(.black)
                .padding(25)
                
                Button("Forget password") {
                    print("Succesfuly login\n \(userName) - \(password)")
                    dismiss()
                    
                }
                .foregroundColor(.black)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
