//
//  ContentView.swift
//  Agenda Arterial Sin Arterial
//
//  Created by Gabriel Crisostomo on 25/09/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var loginShow : FirebaseViewController
    
    var body: some View {
        let medicamentosList = [
            Medicament(idPaciente: "1234", nombreMedicamento: "Paracetamol", informacion: "skdf", fechaInicio: Date.now, vecesOlvidado: 0),
            Medicament(idPaciente: "1234", nombreMedicamento: "Tempra", informacion: "skdf", fechaInicio: Date.now, vecesOlvidado: 0),
            Medicament(idPaciente: "1234", nombreMedicamento: "Sulfas", informacion: "skdf", fechaInicio: Date.now, vecesOlvidado: 0)
            
        ]
        
        let ejemplosPreguntas = [
            ["P: ¿Cómo puedo cerrer una sesión?", "R: Da clic en el butón 'Cerrar sesión'."],
            ["P: No tengo un médico vinculado. ¿Cómo puedo conseguir uno?", "R: Naviga a la página de Médico vinculado y da clic en el búton 'Registrar'."]
        ]
        var ejemploRecordatorios = [
            Remind(fecha: "28/2/19", eventos: ["Próxima cita"]),
            Remind(fecha: "29/2/19", eventos: ["Próxima medición", "Próxima toma de presión"])
        ]
        
        let ejemploMedicos = [
            Medic(correo: "tucorreo@hotmail.com", apellidoPaterno: "Perez", apellidoMaterno: "Corona", nombre: "Javier", foto: "Hi", id: "123456", cedulaProfesional: "123456abc"),
            Medic(correo: "micorreo@gmail.com", apellidoPaterno: "Narvaez", apellidoMaterno: "Soto", nombre: "Ivan", foto: "There", id: "12345677", cedulaProfesional: "abcdefgh123")
        ]
        
        return Group{
            if loginShow.show == "Home" {
                Home().edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            }else if loginShow.show == "Login"{
                Login().edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            }else if loginShow.show == "SignIn"{
                SignIn().edgesIgnoringSafeArea(.all)
            }else if loginShow.show == "CapturesView"{
                CapturesView().edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            }else if loginShow.show == "MedicamentsView"{
                MedicamentsView(medicamentosList: medicamentosList).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            }else if loginShow.show == "WeekReportView"{
                WeekReportView().edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            }else if loginShow.show == "RestorePasswordView"{
                RestorePasswordView().edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            }else if loginShow.show == "RestoreCodeView"{
                RestoreCodeView().edgesIgnoringSafeArea(.all)
            }else if loginShow.show == "ChangePasswordView"{
                ChangePasswordView().edgesIgnoringSafeArea(.all)
            }else if loginShow.show == "HealthStateView"{
                HealthStateView().edgesIgnoringSafeArea(.all)
            }else if loginShow.show == "RemindersView"{
                RemindersViews(listaRecordatorios: ejemploRecordatorios).edgesIgnoringSafeArea(.all)
            }else if loginShow.show == "FrecuentlyAskedQuestionsView"{
                FrecuentlyAskedCuestionsView(listaPreguntas: ejemplosPreguntas).edgesIgnoringSafeArea(.all)
            }else if loginShow.show == "LikYourMedicView"{
                LinkYourMedicView(listMedics: ejemploMedicos).edgesIgnoringSafeArea(.all)
            }else if loginShow.show == "GDV"{
                GeneralDataView().edgesIgnoringSafeArea(.all)
            }
            
        }
        
    }
}

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
