//
//  ContentView.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 5.04.23.
//

import SwiftUI

struct ContentView: View {
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
                }
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
