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
            LinearGradient(colors: [Color.blue, Color.purple], startPoint: .top, endPoint: .bottom)
            HStack(spacing: 50) {
                Text("Service at mileage:")
                
                Text("\(selectedService.mileage)")
            }
        }
        .toolbar(content: {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
//                        Text("Back")
//                            .foregroundColor(.black)
                    Image(systemName: "arrowshape.turn.up.backward.2")
                        .foregroundColor(.black)
                }

            }
        })
        .ignoresSafeArea()
    }
}

struct ServiceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceDetailView(selectedService: Service(mileage: 200000, date: .now, doneService: false, checkMoney: 200))
    }
}
