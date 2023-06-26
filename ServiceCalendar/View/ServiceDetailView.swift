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
    var selectedService : Service
    var selectedCar: Car
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode
    
    @State var presentEditSheet = false
    @ObservedObject var vm: ServiceDetailViewModel
    
    init(selectedService: Service, selectedCar: Car) {
        self.selectedService = selectedService
        self.selectedCar = selectedCar
        self.vm = .init(decodedService: selectedService, selectedCar: selectedCar)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.clear,Color.blue, Color.purple], startPoint: .top, endPoint: .bottom)
            
            VStack {
                Form {
                    Section(header: Text("Service at mileage: " + "\(vm.decodedService.mileage)")) {
                        Text("Service Type - " + vm.decodedService.serviceType)
                        Text("Cost - " + "\(vm.decodedService.checkMoney)$")
                        HStack {
                            Text("Is service done:")
                            if vm.decodedService.doneService {
                                Image(systemName: "checkmark.circle")
                                    .foregroundColor(.green)
                            } else {
                                Image(systemName: "checkmark.circle.badge.xmark")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    Section(header: Text("Date")) {
                        Text("\(dateString(date:vm.decodedService.date))")
                            .lineLimit(nil)
                    }
                }
                .scrollDisabled(true)
                .frame(height: UIScreen.main.bounds.height/3)
                .cornerRadius(20)
                
                VStack {
                    Form{
                        Section(header: Text("Service Description")) {
                            Text(vm.decodedService.serviceDescription)
                        }
                    }
                    .cornerRadius(20)
                }
                .frame(height: UIScreen.main.bounds.height/3)
                .padding(.top, 20)
            }
            .padding()
        }.toolbar{
//            ToolbarItem(placement: .navigationBarTrailing) {
//                                Button("Edit"){
//                                    self.presentEditSheet.toggle()
//                                }
//            }
            Menu {
                Button {
                    self.presentEditSheet.toggle()
                } label: {
                    Text("Edit")
                }

            } label: {
                Label("more", systemImage: "ellipsis.circle")
            }

        }
        .sheet(isPresented: self.$presentEditSheet){
                vm.updateCurrentService()
        } content: {
                    //ServiceDetailView(selectedService: self.selectedService)
                    EditServiceView(selectedCar: selectedCar, selectedService: self.vm.decodedService, mileage: "\(self.vm.decodedService.mileage)", date: self.vm.decodedService.date,  isDone: self.vm.decodedService.doneService, checkMoney: "\(self.vm.decodedService.checkMoney)", serviceType: self.vm.decodedService.serviceType, serviceDescription: self.vm.decodedService.serviceDescription)
                }
        .ignoresSafeArea()
        .onAppear(){
                vm.updateCurrentService()
        }
    }
}
    
    func dateString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy HH:mm:ss"
        
        return formatter.string(from: date)
    }
    
    class ServiceDetailViewModel: ObservableObject {
        @Published var decodedService: Service
        var selectedCar: Car?
        
        init(decodedService: Service, selectedCar: Car?) {
            self.selectedCar = selectedCar
            self.decodedService = decodedService
        }
        
        func updateCurrentService() {
            var someService = self.decodedService
            
            guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return }
            let uniqueID = "\(uid)\(selectedCar!.carName)\(selectedCar!.carModel)"
            let uniqueService = "\(uid)\(decodedService.date)"
            
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
                
                self.decodedService = someService
            }
        }
    }
    
    struct ServiceDetailView_Previews: PreviewProvider {
        static var previews: some View {
            ServiceDetailView(selectedService: Service(mileage: 200000, date: .now, doneService: true, checkMoney: 200,serviceType: "Documents", serviceDescription: "InsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsurance"), selectedCar: Car(carName: "Mercedes-Benz", carModel: "S203", carImage: ["MB"], carMileage: 205000) )
        }
    }
