//
//  ServicesView.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 22.04.23.
//

import SwiftUI

struct ServicesView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.blue, Color.purple, Color.black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        }
        .overlay(content: {
            NavigationBar()
        })
        .navigationBarHidden(true)
    }
}

struct ServicesView_Previews: PreviewProvider {
    static var previews: some View {
        ServicesView()
    }
}
