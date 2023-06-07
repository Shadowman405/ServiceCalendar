//
//  ServiceDetailView.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 8.05.23.
//

import SwiftUI

struct ServiceDetailView: View {
    var selectedService : Service
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
            ZStack {
                LinearGradient(colors: [Color.clear,Color.blue, Color.purple], startPoint: .top, endPoint: .bottom)
                VStack(alignment: .leading) {
                    HStack(spacing: 50) {
                        Text("Service at mileage :")
                        Text("\(selectedService.mileage) Km")
                    }
                    .padding()
                    
                    HStack(spacing: 50) {
                        Text("Date :")
                        Text(selectedService.date, style: .date)
                        Text(selectedService.date, style: .time)
                    }
                    .padding()
                    
                    HStack(spacing: 50) {
                        Text("Spended money :")
                        Text("\(selectedService.checkMoney)$")
                    }
                    .padding()
                }
            }
        .ignoresSafeArea()
    }
}

struct ServiceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceDetailView(selectedService: Service(mileage: 200000, date: .now, doneService: false, checkMoney: 200,serviceType: "Documents", serviceDescription: "Insurance"))
    }
}
