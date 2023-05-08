//
//  ServiceDetailView.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 8.05.23.
//

import SwiftUI

struct ServiceDetailView: View {
    @Binding var selectedService : Service
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.blue, Color.purple], startPoint: .top, endPoint: .bottom)
            HStack(spacing: 50) {
                Text("Service at mileage:")
                
                Text("\(selectedService.mileage)")
            }
        }
        .ignoresSafeArea()
    }
}

struct ServiceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceDetailView(selectedService: .constant(Service(mileage: 200000, date: .now, doneService: false, checkMoney: 200)))
    }
}
