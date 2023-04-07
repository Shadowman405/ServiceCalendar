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
        VStack {
            Text(car.carName)
            
            Image(car.carImage)
                .resizable()
                .cornerRadius(20)
                .frame(height: 270,alignment: .center)
                .padding(10)
            
            Text("Current Milage - \(car.carMileage)")
        }
    }
}

struct CarCell_Previews: PreviewProvider {
    static var cars = Car(id: 0, carName: "Mercedes-Benz", carImage: "MB", carMileage: 205000)
    
    static var previews: some View {
        CarCell(car: cars)
    }
}
