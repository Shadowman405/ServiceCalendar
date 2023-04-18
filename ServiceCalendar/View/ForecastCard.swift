//
//  ForecastCard.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 18.04.23.
//

import SwiftUI

struct ForecastCard: View {
    var service: Service
    var segmentedControlChoice: ServiceSegmentedControlModel
    var isActive = true
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Gradient(colors: [Color.purple, Color.blue]).opacity(isActive ? 1 : 0.2))
                .frame(width: 60, height: 140)
                .shadow(color: .black.opacity(0.25), radius: 10,x: 5, y: 4)
        }
    }
}

struct ForecastCard_Previews: PreviewProvider {
    static var previews: some View {
        ForecastCard(service: ServiceSegmentedControlModel.mockService[0], segmentedControlChoice: .service)
    }
}
