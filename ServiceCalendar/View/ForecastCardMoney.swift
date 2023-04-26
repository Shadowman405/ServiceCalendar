//
//  ForecastCardMoney.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 26.04.23.
//

import SwiftUI

struct ForecastCardMoney: View {
    var service: Service
    var segmentedControlChoice: ServiceSegmentedControlModel
    var isActive = true
    
    var body: some View {
        ZStack {
            //MARK: - Card
            RoundedRectangle(cornerRadius: 30)
                .fill(Gradient(colors: [Color.purple, Color.blue]).opacity(isActive ? 1 : 0.2))
                .frame(width: 90, height: 140)
                .shadow(color: .black.opacity(0.25), radius: 10,x: 5, y: 4)
                .overlay {
                    RoundedRectangle(cornerRadius: 30)
                        .strokeBorder(.white.opacity(isActive ? 0.5 : 0.2))
                        .blendMode(.overlay)
                }
                .innerShadow(shape: RoundedRectangle(cornerRadius: 30), color: .white.opacity(0.25),lineWidth: 1,offsetX: 1,offsetY: 1,blur: 0,blendMode: .overlay)
            
            //MARK: - Content
            VStack(spacing: 16) {
                Text(service.date, format: segmentedControlChoice == ServiceSegmentedControlModel.service ? .dateTime.month() : .dateTime.year())
                    .font(.subheadline.weight(.semibold))
                
                VStack(spacing: -4) {
                    Image(systemName: service.icon)
                        .foregroundColor(service.doneService ? .green : .red)
                        .padding()
                    
                    Text("\(service.checkMoney) $")
                }
                .frame(height: 42)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
            .frame(width: 90,height: 140)
        }
    }
}

struct ForecastCardMoney_Previews: PreviewProvider {
    static var previews: some View {
        ForecastCardMoney(service: ServiceSegmentedControlModel.mockService[0], segmentedControlChoice: .service)
    }
}
