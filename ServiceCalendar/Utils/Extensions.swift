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


extension View {
    func innerShadow<S: Shape, SS: ShapeStyle>(shape: S, color: SS, lineWidth: CGFloat = 1, offsetX: CGFloat = 0, offsetY: CGFloat = 0, blur: CGFloat = 4, blendMode: BlendMode = .normal) -> some View {
        return self
            .overlay(content: {
                //MARK: - Inner Shadow
                RoundedRectangle(cornerRadius: 44)
                    .stroke(Color.bottomSheetBorderMiddle, lineWidth: 1)
                    .blendMode(.overlay)
                    .offset(y: 1)
                    .blur(radius: 0)
                    .mask {
                        RoundedRectangle(cornerRadius: 44)
                    }
            })
    }
}
