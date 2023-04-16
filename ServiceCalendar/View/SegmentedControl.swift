//
//  SegmentedControl.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 16.04.23.
//

import SwiftUI

struct SegmentedControl: View {
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Button {
                    
                } label: {
                    Text("Service")
                }
                
                Spacer()

                Button {
                    
                } label: {
                    Text("Spended Money")
                }
            }
            .font(.subheadline.weight(.semibold))
            .foregroundColor(.black)
        }
        .padding(.top, 25)
    }
}

struct SegmentedControl_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedControl()
    }
}
