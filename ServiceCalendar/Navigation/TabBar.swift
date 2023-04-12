//
//  TabBar.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 11.04.23.
//

import SwiftUI

struct TabBar: View {
    var action: () -> Void
    
    var body: some View {
        ZStack {
            Arc()
                .fill(Gradient(colors: [Color.purple, Color.blue]))
                .frame(height: 88)
                .overlay {
                    Arc()
                        .stroke(Color.pink, lineWidth: 0.7)
                }
            
            HStack {
                Button {
                    action()
                } label: {
                    Image(systemName: "mappin.and.ellipse")
                        .frame(width: 44,height: 44)
                }
                
                Spacer()

                NavigationLink {
                    
                } label: {
                    Image(systemName: "list.star")
                        .frame(width: 44,height: 44)
                }

            }
            .font(.title2)
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 20, leading: 32, bottom: 24, trailing: 32))
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(action: {})
    }
}
