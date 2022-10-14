//
//  Home.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI

struct Home: View {
    
    var device = UIDevice.current.userInterfaceIdiom
    @State private var index = "Menu Principal"
    @State private var menu = false
    @State private var widthMenu = UIScreen.main.bounds.width
    @State var showApp = "Home"
    
    @StateObject var login = FirebaseViewController()
    @EnvironmentObject var loginShow : FirebaseViewController
    
    let medicamentosList = [
        Medicament(idPacient: "1234", medicamentName: "Paracetamol", information: "skdf", startDate: Date.now, forgetTimes: 0),
        Medicament(idPacient: "1234", medicamentName: "Tempra", information: "skdf", startDate: Date.now, forgetTimes: 0),
        Medicament(idPacient: "1234", medicamentName: "Sulfas", information: "skdf", startDate: Date.now, forgetTimes: 0)
    ]
    let ejemploRecordatorios = [
        Remind(date: "28/2/19", events: ["Proxima Cita"]),
        Remind(date: "29/2/19", events: ["Proxima medicion","Proxima toma de presion"])
    ]
    
    let ejemploMedicos = [
        Medic
//        Medic(email: "tucorreo@hotmail.com", patName: "Perez", matName: "Corona", name: "Javier", foto: "Hi", id: "123456", proflicense: "123456abc"),
//        Medic(email: "micorreo@gmail.com", patName: "Narvaez", matName: "Soto", name: "Ivan", foto: "There", id: "12345677", proflicense: "abcdefgh123")
    ]()
    
    var body: some View {
        ZStack(alignment: .leading){
            VStack {
                
                NavBarHome(menu: $menu, index: $index)
                
                ZStack{
                    switch loginShow.showApp{
                    case "Home":
                        AppsView()
                    case "CapturesView":
                        CapturesView().edgesIgnoringSafeArea(.all)
                    case "MedicamentsView":
                        MedicamentsView(medicamentosList: medicamentosList).edgesIgnoringSafeArea(.all)
                    case "WeekReportView":
                        WeekReportView().edgesIgnoringSafeArea(.all)
                    case "HealthStateView":
                        HealthStateView().edgesIgnoringSafeArea(.all)
                    case "LikYourMedicView":
                        LinkYourMedicView(listMedics: ejemploMedicos).edgesIgnoringSafeArea(.all)
                    case "RemindersView":
                        RemindersView(remindersList: ejemploRecordatorios).edgesIgnoringSafeArea(.all)
                    default:
                        AppsView()
                    }
                    
                    
                }
                
            }
            .background(.white)
            .onTapGesture {
                withAnimation{
                    menu = false
                }
            }
            if menu{
                 NavBarMenu(index: $index, menu: $menu)
            }
            
        }
    }
}
