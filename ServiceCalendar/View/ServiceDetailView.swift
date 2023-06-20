//
//  ServiceDetailView.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 8.05.23.
//

import SwiftUI

struct ServiceDetailView: View {
    var selectedService : Service
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode
    
    @State var presentEditSheet = false
    
    var body: some View {
            ZStack {
                LinearGradient(colors: [Color.clear,Color.blue, Color.purple], startPoint: .top, endPoint: .bottom)
                
                VStack {
                    Form {
                        Section(header: Text("Service at mileage: " + "\(selectedService.mileage)")) {
                            Text("Service Type - " + selectedService.serviceType)
                            Text("Cost - " + "\(selectedService.checkMoney)$")
                            HStack {
                                Text("Is service done:")
                                if selectedService.doneService {
                                    Image(systemName: "checkmark.circle")
                                        .foregroundColor(.green)
                                } else {
                                    Image(systemName: "checkmark.circle.badge.xmark")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                        Section(header: Text("Date")) {
                            Text("\(dateString(date:selectedService.date))")
                                .lineLimit(nil)
                        }
                    }
                    .scrollDisabled(true)
                    .frame(height: UIScreen.main.bounds.height/3)
                    .cornerRadius(20)
                    
                    VStack {
                        Form{
                            Section(header: Text("Service Description")) {
                                Text(selectedService.serviceDescription)
                            }
                        }
                        .cornerRadius(20)
                    }
                    .frame(height: UIScreen.main.bounds.height/3)
                    .padding(.top, 20)
                    }
                .padding()
            }.toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Edit"){
                        self.presentEditSheet.toggle()
                    }
                }
            }
            .sheet(isPresented: self.$presentEditSheet, content: {
                //ServiceDetailView(selectedService: self.selectedService)
                EditServiceView(selectedService: self.selectedService, mileage: "\(self.selectedService.mileage)")
            })
        .ignoresSafeArea()
    }
    
    func dateString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy HH:mm:ss"
        
        return formatter.string(from: date)
    }
}

struct ServiceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceDetailView(selectedService: Service(mileage: 200000, date: .now, doneService: true, checkMoney: 200,serviceType: "Documents", serviceDescription: "InsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsurance"))
    }
}
