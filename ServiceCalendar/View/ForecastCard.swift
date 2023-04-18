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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ForecastCard_Previews: PreviewProvider {
    static var previews: some View {
        ForecastCard(service: ServiceSegmentedControlModel.mockService[0], segmentedControlChoice: .service)
    }
}
