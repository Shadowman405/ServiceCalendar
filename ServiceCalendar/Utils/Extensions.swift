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
