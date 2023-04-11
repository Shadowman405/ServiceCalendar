//
//  SelectedCar.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 11.04.23.
//

import SwiftUI

struct SelectedCar: View {
    var selectedCar: Car
    
    var body: some View {
        Text(selectedCar.carName)
    }
}

struct SelectedCar_Previews: PreviewProvider {
    
    static var previews: some View {
        SelectedCar(selectedCar: Car(id: 0, carName: "Mercedes-Benz", carImage: "MB", carMileage: 205000))
    }
}
