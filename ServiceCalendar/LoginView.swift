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

    
    var body: some View {
        VStack{
            TextField("Username", text: $userName)
                .textFieldStyle(.roundedBorder)
                .padding(15)
            
            TextField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .padding(15)
            Spacer()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
