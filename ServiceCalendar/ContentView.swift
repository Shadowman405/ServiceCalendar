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
                
                Text("New app")
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
