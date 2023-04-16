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
    @State var bottomSheetChange = false
    @State var bottomSheetTranslation: CGFloat = BotomSheetPosition.middle.rawValue
    var bottomSheetTranslationProrated: CGFloat {
        (bottomSheetTranslation - BotomSheetPosition.middle.rawValue) / (BotomSheetPosition.top.rawValue - BotomSheetPosition.middle.rawValue)
    }
    
    var selectedCar: Car
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                let screenHeight = geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom
                
                let imageOffset = screenHeight + 36
                
                ZStack {
                    LinearGradient(colors: [.blue ,.black], startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                        .opacity(0.8)
                    
                    VStack {
                        Text(selectedCar.carName)
                            .padding(25)
                            .offset(y: -bottomSheetTranslationProrated * imageOffset)
                        
                        Image(selectedCar.carImage)
                            .resizable()
                            .frame(height: 250)
                            .cornerRadius(20)
                            .padding()
                            .offset(y: -bottomSheetTranslationProrated * imageOffset)
                        
                        Spacer()
                    }
                    
                    
                    BottomSheetView(position: $bottomSheetPosition) {
                        Text(bottomSheetTranslationProrated.formatted())
                        
                    } content: {
                        ForecastView()
                    }
                    .onBottomSheetDrag { translation in
                        bottomSheetTranslation = translation / screenHeight
                    }

                    
                    TabBar(action: {
                        bottomSheetChange.toggle()
                        //bottomSheetPosition = .top
                        if bottomSheetChange {
                            bottomSheetPosition = .top
                        } else {
                            bottomSheetPosition = .middle
                        }
                    })
                }
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
