//
//  CarCell.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 7.04.23.
//

import SwiftUI

struct CarCell: View {
    var car: Car
    
    var body: some View {
        ZStack {
            VStack {
                Image(uiImage: UIImage(named: car.carImage[0])!)
                    .resizable()
                    .cornerRadius(20)
                    .frame(height: 270,alignment: .center)
                .padding(10)
            }
            Text(car.carName)
                .font(.custom("Snell Roundhand", size: 30))
                .fontWeight(.thin)
                .foregroundColor(.black)
                .offset(y: -90)
            
            
            Text( "Milage - \(car.carMileage)")
                .font(.custom("Snell Roundhand", size: 30))
                .fontWeight(.thin)
                .foregroundColor(.black)
                .offset(y: 110)
        }
    }
}

struct CarCell_Previews: PreviewProvider {
    static var cars = Car(carName: "Mercedes-Benz", carImage: ["MB"], carMileage: 205000)
    
    static var previews: some View {
        CarCell(car: cars)
    }
}
