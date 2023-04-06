//
//  ContentView.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 5.04.23.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @State private var isPresented = false
    
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
                    .padding(40)
                    
                    Button("Log-In") {
                        self.isPresented.toggle()
                    }
                    .sheet(isPresented: $isPresented, content: {
                        LoginView()
                    })
                    .buttonStyle(.bordered)
                    .tint(.green)
                    .cornerRadius(10)
                    .foregroundColor(.black)
                    .controlSize(.large)
                    .font(.system(size: 20, weight: .heavy, design: .serif))
                    
                    Button("Register") {
                        print("Register")
                    }
                    .buttonStyle(.bordered)
                    .tint(.red)
                    .cornerRadius(10)
                    .foregroundColor(.black)
                    .controlSize(.large)
                    .font(.system(size: 20, weight: .heavy, design: .serif))
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
