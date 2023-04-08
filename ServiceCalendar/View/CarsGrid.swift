//
//  ServiceList.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 6.04.23.
//

import SwiftUI
import Firebase

struct CarsGrid: View {
    @State private var isUserLoggedIn = true
    @ObservedObject var carGrid: CarGrid
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 10, alignment: nil)
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(carGrid.cars){ car in
                            CarCell(car: car)
                        }
                    }
                }
                
//                Button("Sign Out") {
//                    signOut()
//                    self.isUserLoggedIn.toggle()
//                }
//                .sheet(isPresented: $isUserLoggedIn, content: {
//                    ContentView()
//                })
//                .buttonStyle(.bordered)
//                .tint(.red)
//                .cornerRadius(10)
//                .foregroundColor(.black)
//                .controlSize(.large)
//                .font(.system(size: 20, weight: .heavy, design: .serif))
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ContentView(logedIn: $isUserLoggedIn)) {
                        Button {
                            signOut()
                        } label: {
                            Text("SignOut")
                        }
                    }
                }
            }
        }
    }
    
    func signOut() {
        isUserLoggedIn = false
        print("Status - \(isUserLoggedIn)")
        do {
            try Auth.auth().signOut()
            print("signed out")
        } catch {
            print("Error")
        }
    }
}


struct ServiceList_Previews: PreviewProvider {
    static var previews: some View {
        CarsGrid(carGrid: CarGrid())
    }
}
