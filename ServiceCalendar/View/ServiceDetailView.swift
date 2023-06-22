//
//  ServiceDetailView.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 8.05.23.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct ServiceDetailView: View {
    @State var selectedService : Service
    var selectedCar: Car
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode
    
    @State var presentEditSheet = false
    
//    init(selectedService: Service, selectedCar: Car, presentEditSheet: Bool = false) {
//        self.selectedService = selectedService
//        self.selectedCar = selectedCar
//        self.presentEditSheet = presentEditSheet
//        
//        self.selectedService = updateCurrentService()
//    }
    
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
//                Button("Edit"){
//                    self.presentEditSheet.toggle()
//                }
                
                NavigationLink(destination: EditServiceView(selectedCar: selectedCar, selectedService: self.selectedService, mileage: "\(self.selectedService.mileage)", date: self.selectedService.date,  isDone: self.selectedService.doneService, checkMoney: "\(self.selectedService.checkMoney)", serviceType: self.selectedService.serviceType, serviceDescription: self.selectedService.serviceDescription)) {
                    Text("Edit")
                }
            }
        }
//        .sheet(isPresented: self.$presentEditSheet, content: {
//            //ServiceDetailView(selectedService: self.selectedService)
//            EditServiceView(selectedCar: selectedCar, selectedService: self.selectedService, mileage: "\(self.selectedService.mileage)", date: self.selectedService.date,  isDone: self.selectedService.doneService, checkMoney: "\(self.selectedService.checkMoney)", serviceType: self.selectedService.serviceType, serviceDescription: self.selectedService.serviceDescription)
//        })
        .ignoresSafeArea()
    }
    
    func dateString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy HH:mm:ss"
        
        return formatter.string(from: date)
    }
    
    func updateCurrentService() -> Service {
        var someService = self.selectedService
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return someService}
        let uniqueID = "\(uid)\(selectedCar.carName)\(selectedCar.carModel)"
        let uniqueService = "\(uid)\(selectedService.date)"
        
        FirebaseManager.shared.firestore.collection("users").document(uid).collection("cars").document(uniqueID).collection("Services").document(uniqueService).addSnapshotListener { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            let data = snapshot!.data()
            
            let mileage = data!["mileage"] as? String ?? ""
            let checkmoney = data!["checkMoney"] as? String ?? ""
            let time = data!["date"] as? Timestamp
            let date = time?.dateValue()
            let isDone = data!["isDone"] as? Bool ?? false
            let serviceType = data!["serviceType"] as? String ?? ""
            let serviceDescription = data!["serviceDescription"] as? String ?? ""
            
            someService = Service(mileage: Int(mileage) ?? 1, date: date ?? Date.now, doneService: isDone, checkMoney: Int(checkmoney) ?? 1, serviceType: serviceType, serviceDescription: serviceDescription)
        }
        
        return someService
    }
    
    struct ServiceDetailView_Previews: PreviewProvider {
        static var previews: some View {
            ServiceDetailView(selectedService: Service(mileage: 200000, date: .now, doneService: true, checkMoney: 200,serviceType: "Documents", serviceDescription: "InsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsurance"), selectedCar: Car(carName: "Mercedes-Benz", carModel: "S203", carImage: ["MB"], carMileage: 205000)   )
        }
    }
}
