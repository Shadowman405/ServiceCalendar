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
        NavigationView {
            ZStack {
                VStack {
                    Text(selectedCar.carName)
                    
                    Image(selectedCar.carImage)
                        .resizable()
                        .frame(height: 300)
                        .cornerRadius(20)
                        .padding()
                }
                
                
                
                TabBar(action: {})
            }
        }
        .navigationBarHidden(true)
    }
}

struct SelectedCar_Previews: PreviewProvider {
    
    static var previews: some View {
        SelectedCar(selectedCar: Car(id: 0, carName: "Mercedes-Benz", carImage: "MB", carMileage: 205000))
    }
}
