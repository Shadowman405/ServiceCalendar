//
//  ContentView.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 5.04.23.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresented = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                HStack {
                    Image("main-logo")
                        .scaledToFill()
                    .foregroundColor(.accentColor)
                }
                
                Button("Log-In") {
                    print("Hello")
                    self.isPresented.toggle()
                }
                .sheet(isPresented: $isPresented, content: {
                    LoginView()
                })
                .buttonStyle(.bordered)
                .tint(.indigo)
                .cornerRadius(10)
                .foregroundColor(.black)
                .controlSize(.large)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
