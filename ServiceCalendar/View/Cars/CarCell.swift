//
//  CarCell.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 7.04.23.
//

import SwiftUI
import SDWebImageSwiftUI

struct CarCell: View {
    var car: Car
    
    var body: some View {
        ZStack {
            VStack {
                if car.carImage.isEmpty {
                    Image(systemName: "car.fill")
                        .foregroundColor(.black)
                        .cornerRadius(20)
                        .frame(height: 270,alignment: .center)
                    .padding(10)
                } else {
                    WebImage(url: URL(string: car.carImage[0]))
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(20)
                        .frame(height: 300,alignment: .center)
                    .padding(10)
                }

            }
            Text("\(car.carName)" + " - \(car.carModel)")
                .font(.custom("Snell Roundhand", size: 30))
                .fontWeight(.thin)
                .foregroundColor(.black)
                .offset(y: -90)
            
            
            Text( "Milage - \(car.carMileage)")
                .font(.custom("Snell Roundhand", size: 30))
                .fontWeight(.thin)
                .foregroundColor(.black)
                .offset(y: 100)
        }
    }
}

struct CarCell_Previews: PreviewProvider {
    static var previews: some View {
        CarCell(car: FireBaseHelper().mockCar)
    }
}
