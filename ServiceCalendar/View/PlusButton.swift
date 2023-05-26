//
//  PlusButton.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 25.05.23.
//

import SwiftUI

struct PlusButton: View {
//    var service: Service
//    var segmentedControlChoice: ServiceSegmentedControlModel
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
                Text("Add new")
                
                Image(systemName: "plus.circle")
                    .resizable()
                    .frame(width: 40,height: 40)
                    .foregroundColor(.black)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
            .frame(width: 90,height: 140)
        }
    }
}

struct PlusButton_Previews: PreviewProvider {
    static var previews: some View {
        PlusButton()
    }
}
