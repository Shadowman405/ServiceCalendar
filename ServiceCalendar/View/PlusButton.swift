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
                .foregroundColor(Color.blue)
                .padding()
            .frame(width: 100, height: 100)
            
            Image(systemName: "plus.circle")
                .resizable()
                .frame(width: 70,height: 70)
            
            Button {
                print("Beep")
            } label: {
                Image(systemName: "plus.circle")
                    .resizable()
                    .frame(width: 70,height: 70)
            }

        }
    }
}

struct PlusButton_Previews: PreviewProvider {
    static var previews: some View {
        PlusButton()
    }
}
