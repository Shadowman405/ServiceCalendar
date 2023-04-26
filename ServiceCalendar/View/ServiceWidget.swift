//
//  ServiceWidget.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 26.04.23.
//

import SwiftUI

struct ServiceWidget: View {
    var service: Service
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Trapezoid()
                .fill(LinearGradient(colors: [Color.blue, Color.purple], startPoint: .trailing, endPoint: .leading))
                .frame(width: 342,height: 174)
            
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("\(service.checkMoney) $")
                        .font(.system(size: 60))
                    
                    VStack(alignment: .leading, spacing: 2 ) {
                        Text("At mileage: \(service.mileage)")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                }
                
                VStack(alignment: .trailing) {
                    Image(systemName: "creditcard")
                        .frame(width: 60,height: 60)
                        .foregroundColor(service.doneService ? .green : .red)
                        .padding()
                }
            }
        }
        .frame(width: 342, height: 184,alignment: .bottom)
    }
}

struct ServiceWidget_Previews: PreviewProvider {
    static var previews: some View {
        ServiceWidget(service: ServiceSegmentedControlModel.mockService[0])
            .preferredColorScheme(.dark)
    }
}
