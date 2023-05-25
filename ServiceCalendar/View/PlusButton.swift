//
//  PlusButton.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 25.05.23.
//

import SwiftUI

struct PlusButton: View {
    var body: some View {
        
        ZStack {
            Circle()
                .foregroundColor(.blue)
                .padding()
            .frame(width: 110, height: 110)
            
            Image(systemName: "plus.circle")
                .resizable()
                .frame(width: 70,height: 70)
        }
    }
}

struct PlusButton_Previews: PreviewProvider {
    static var previews: some View {
        PlusButton()
    }
}
