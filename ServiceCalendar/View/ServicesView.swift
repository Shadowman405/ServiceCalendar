//
//  ServicesView.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 22.04.23.
//

import SwiftUI

struct ServicesView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.clear, Color.blue, Color.black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    ForEach(ServiceSegmentedControlModel.mockService){ service in
                        ServiceWidget(service: service)
                    }
                }
            }
            .safeAreaInset(edge: .top) {
                EmptyView()
                    .frame(height: 90)
            }
        }
        .overlay(content: {
            NavigationBar()
        })
        .navigationBarHidden(true)
    }
}

struct ServicesView_Previews: PreviewProvider {
    static var previews: some View {
        ServicesView()
    }
}
