//
//  SelectedCar.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 11.04.23.
//

import SwiftUI
import BottomSheet

enum BotomSheetPosition: CGFloat, CaseIterable {
    case top = 0.82
    case middle = 0.385
}

struct SelectedCar: View {
    @State var bottomSheetPosition: BotomSheetPosition = .middle
    var selectedCar: Car
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text(selectedCar.carName)
                        .padding(25)
                    
                    Image(selectedCar.carImage)
                        .resizable()
                        .frame(height: 250)
                        .cornerRadius(20)
                        .padding()
                    
                    Spacer()
                }
                
                
                BottomSheetView(position: $bottomSheetPosition) {
                    
                } content: {
                    ForecastView()
                }

                
                TabBar(action: {})
            }
        }
        //.navigationBarHidden(true)
    }
}

struct SelectedCar_Previews: PreviewProvider {
    
    static var previews: some View {
        SelectedCar(selectedCar: Car(id: 0, carName: "Mercedes-Benz", carImage: "MB", carMileage: 205000))
    }
}
