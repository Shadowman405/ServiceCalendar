//
//  ContentView.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 5.04.23.
//

import SwiftUI
import Firebase

struct ContentView: View {
    //@Binding var logedIn: Bool
    @State private var isPresentedReg = false
    @State private var isUserLoggedIn = false
    @State private var email = ""
    @State private var password = ""

    
    var body: some View {
        if isPresentedReg {
            CarsGrid(carGrid: CarGrid())
        } else {
            content
        }
    }
    
    var content: some View {
        NavigationStack {
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
                        
                        NavigationLink {
                            LoginView(logedIn: $isPresentedReg)
                        } label: {
                            Text("GOOOOOOO")
                        }

                                    
//                        NavigationLink(destination: LoginView(logedIn: $isUserLoggedIn), label: {
//                            Text("")
//                            Button("Start") {
//
//                            }
//                            .buttonStyle(.bordered)
//                            .tint(.red)
//                            .cornerRadius(10)
//                            .foregroundColor(.black)
//                            .controlSize(.large)
//                        .font(.system(size: 20, weight: .heavy, design: .serif))
//                        })
                        
                        
                    }
                }
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @State private var testisPresentedReg = false
    
    
    static var previews: some View {
        ContentView()
    }
}
