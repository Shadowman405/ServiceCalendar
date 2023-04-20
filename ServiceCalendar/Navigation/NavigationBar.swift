//
//  NavigationBar.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 20.04.23.
//

import SwiftUI

struct NavigationBar: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                //MARK: - Back Button
                Button {
                    
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 23).weight(.medium))
                        .foregroundColor(.secondary)
                    
                    Text("My Car")
                        .font(.title)
                        .foregroundColor(.primary)
                }

            }
            .frame(height: 52)
        }
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar()
    }
}
