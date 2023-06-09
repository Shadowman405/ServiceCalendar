//
//  ForecastView.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 12.04.23.
//

import SwiftUI

struct ForecastView: View {
    var bottomSheetTranslationProrated: CGFloat = 1
    @State private var selection = 0
    let serviceType = ServiceType()
    var selectedCar: Car?
    var selectedServices: [Service]?
    
    var body: some View {
        
        ScrollView {
            VStack() {
                SegmentedControl(selection: $selection)
                
                //MARK: - Service Cards
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 12) {
                        if selection == 0 {
                            HStack {
                                NavigationLink(destination: AddNewServiceView(selectedCar: selectedCar)) {
                                    PlusButton()
                                }
                                
                                ForEach(selectedServices!) { service in
    //                                ForecastCard(service: service, segmentedControlChoice: .service)
                                    NavigationLink(destination: ServiceDetailView(selectedService: service, selectedCar: selectedCar!)) {
                                        ForecastCard(service: service, segmentedControlChoice: .service)
                                    }
                                }
                                .transition(.offset(x: -430))
                            }
                        } else {
                            HStack {
                                NavigationLink(destination: AddNewServiceView(selectedCar: selectedCar)) {
                                    PlusButton()
                                }

                                ForEach(selectedServices!) { service in
                                    ForecastCardMoney(service: service, segmentedControlChoice: .service)
                                }
                                .transition(.offset(x: 430))
                            }
                        }
                    }
                    .padding(.vertical, 20)
                }
                .padding(.horizontal, 5)
                
                if selection == 1 {
                    //MARK: - Scroll view payments all time
                                        ScrollView(.horizontal) {
                                            HStack {
                                                ServicesCostAllWidget(descriptionText: "Spended money\n on service for all time:", sumText: "\(serviceType.allTimeCostOfServices(services: selectedServices ?? Service.mockService))", services: selectedServices ?? Service.mockService, serviceIcon: serviceType.serviceIcon)
                                                    .padding()
                                                
                                                ServicesCostAllWidget(descriptionText: "Spended money\n on gasoline for all time:", sumText: "\(serviceType.allTimeCostOfGasoline(services: selectedServices ?? Service.mockService))", services: selectedServices ?? Service.mockService, serviceIcon: serviceType.gasolineIcon)
                                                    .padding()
                                                
                                                ServicesCostAllWidget(descriptionText: "Spended money\n on documents for all time:", sumText: "\(serviceType.allTimeCostOfDocuments(services: selectedServices ?? Service.mockService))", services: selectedServices ?? Service.mockService, serviceIcon: serviceType.documentsIcon)
                                                    .padding()
                                                
                                                ServicesCostAllWidget(descriptionText: "Spended money\n on other for all time:", sumText: "\(serviceType.allTimeCostOfOther(services: selectedServices ?? Service.mockService))", services: selectedServices ?? Service.mockService, serviceIcon: serviceType.ohterIcon)
                                                    .padding()
                                            }
                                        }
                                        .padding(.top, 20)
                                    
                    //MARK: - Scroll view payments by month
                                    Divider()
                                        .background(.white)
                                    Text("Spended money monthly :")
                                         
                                    ScrollView(.horizontal) {
                                        HStack {
                                            ServicesCostAllWidget(descriptionText: "Spended money\n on services this month:", sumText: "\(serviceType.allTimeCostOfServicesMonth(services: selectedServices ?? Service.mockService))", services: selectedServices ?? Service.mockService, serviceIcon: serviceType.serviceIcon)
                                                .padding()
                                            
                                            ServicesCostAllWidget(descriptionText: "Spended money\n on gasoline this month:", sumText: "\(serviceType.allTimeCostOfGasolineMonth(services: selectedServices ?? Service.mockService))", services: selectedServices ?? Service.mockService, serviceIcon: serviceType.gasolineIcon)
                                                .padding()
                                            
                                            ServicesCostAllWidget(descriptionText: "Spended money\n on documents this month:", sumText: "\(serviceType.allTimeCostOfDocumentsMonth(services: selectedServices ?? Service.mockService))", services: selectedServices ?? Service.mockService, serviceIcon: serviceType.documentsIcon)
                                                .padding()
                                            
                                            ServicesCostAllWidget(descriptionText: "Spended money\n on other bills this month:", sumText: "\(serviceType.allTimeCostOfOtherMonth(services: selectedServices ?? Service.mockService))", services: selectedServices ?? Service.mockService, serviceIcon: serviceType.ohterIcon)
                                                .padding()
                                        }
                                    }
                }
            }
        }
        .backgroundBlur(radius: 25,opaque: true)
        .background(Gradient(colors: [Color.purple, Color.blue]))
        .clipShape(RoundedRectangle(cornerRadius: 44))
        .innerShadow(shape: RoundedRectangle(cornerRadius: 44), color: Color.bottomSheetBorderMiddle,lineWidth: 1,offsetX: 0,offsetY: 1,blur: 0,blendMode: .overlay,opacity: 1 - bottomSheetTranslationProrated)
        .overlay {
            Divider()
                .blendMode(.overlay)
                .background(Color.black)
                .frame(maxHeight: .infinity, alignment: .top)
                .clipShape(RoundedRectangle(cornerRadius: 44))
        }
        .overlay {
            //MARK: - Drag Indicator
            RoundedRectangle(cornerRadius: 10)
                .fill(.black)
                .opacity(0.3)
                .frame(width: 48,height: 5)
                .frame(height:20)
                .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView(selectedCar: FireBaseHelper().mockCar, selectedServices: Service.mockService)
    }
}
