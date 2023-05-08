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
                    .foregroundColor(.black)
                
                VStack(spacing: -4) {
                    Image(systemName: service.icon)
                        .foregroundColor(service.doneService ? .green : .red)
                        .padding()
                    
                    Text("\(service.mileage)")
                        .foregroundColor(.black)
                }
                .frame(height: 42)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
            .frame(width: 90,height: 140)
        }
    }
}

struct ForecastCard_Previews: PreviewProvider {
    static var previews: some View {
        ForecastCard(service: ServiceSegmentedControlModel.mockService[0], segmentedControlChoice: .service)
    }
}
