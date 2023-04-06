//
//  ServiceList.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 6.04.23.
//

import SwiftUI
import Firebase

struct ServiceList: View {
    @State private var isUserLoggedIn = false
    
    var body: some View {
        VStack {
            Text("Sone list")
            
            Button("Sign Out") {
                signOut()
                self.isUserLoggedIn.toggle()
            }
            .sheet(isPresented: $isUserLoggedIn, content: {
                ContentView()
            })
            .buttonStyle(.bordered)
            .tint(.red)
            .cornerRadius(10)
            .foregroundColor(.black)
            .controlSize(.large)
            .font(.system(size: 20, weight: .heavy, design: .serif))
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error")
        }
    }
}


struct ServiceList_Previews: PreviewProvider {
    static var previews: some View {
        ServiceList()
    }
}
