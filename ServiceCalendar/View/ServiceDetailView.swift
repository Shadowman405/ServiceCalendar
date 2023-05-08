//
//  ServiceDetailView.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 8.05.23.
//

import SwiftUI

struct ServiceDetailView: View {
    
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.blue, Color.purple], startPoint: .top, endPoint: .bottom)
            HStack {
                Text("Service at mileage")
                Text("")
            }
        }
        .ignoresSafeArea()
    }
}

struct ServiceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceDetailView()
    }
}
