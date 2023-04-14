//
//  Extensions.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 14.04.23.
//

import SwiftUI

extension View {
    func backgroundBlur(radius: CGFloat = 3, opaque: Bool = false) -> some View {
        self
            .background(Blur(radius: radius,opaque: opaque))
    }
}

extension Color {
    static let bottomSheetBorderMiddle = LinearGradient(gradient: Gradient(stops: [.init(color: .white, location: 0), .init(color: .clear, location: 0.2)]), startPoint: .top, endPoint: .bottom)
}
