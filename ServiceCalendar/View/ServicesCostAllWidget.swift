//
//  ServicesCostAllWidget.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 7.06.23.
//

import SwiftUI

struct ServicesCostAllWidget: View {
    var descriptionText = "Test"
    var sumText = "Test"
    var services = [Service]()
    var serviceIcon = "pipe"
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Gradient(colors: [Color.purple, Color.blue]).opacity(1))
                .frame(width: 220, height: 140)
                .shadow(color: .black.opacity(0.25), radius: 10,x: 5, y: 4)
                .overlay {
                    RoundedRectangle(cornerRadius: 30)
                        .strokeBorder(.white.opacity(0.5))
                        .blendMode(.overlay)
                }
                .innerShadow(shape: RoundedRectangle(cornerRadius: 30), color: .white.opacity(0.25),lineWidth: 1,offsetX: 1,offsetY: 1,blur: 0,blendMode: .overlay)
            
            VStack {
                Text(descriptionText)
                    .padding()
                HStack {
                    Text(sumText + " $")
                    Image(serviceIcon)
                        .resizable()
                        .frame(width: 40, height: 40)
                }
            }
        }
    }
}

struct ServicesCostAllWidget_Previews: PreviewProvider {
    static var previews: some View {
        ServicesCostAllWidget(services: Service.mockService)
    }
}
