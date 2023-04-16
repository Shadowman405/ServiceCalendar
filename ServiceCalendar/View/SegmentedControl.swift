//
//  SegmentedControl.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 16.04.23.
//

import SwiftUI

struct SegmentedControl: View {
    @Binding var selection: Int
    
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Button {
                    selection = 0
                } label: {
                    Text("Service")
                }
                .frame(minWidth: 0, maxWidth: .infinity)

                
                Button {
                    selection = 1
                } label: {
                    Text("Spended Money")
                }
                .frame(minWidth: 0, maxWidth: .infinity)

            }
            .font(.subheadline.weight(.semibold))
            .foregroundColor(.black)
        }
        .padding(.top, 25)
    }
}

struct SegmentedControl_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedControl(selection: .constant(0))
    }
}
