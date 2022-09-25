//
//  TimerView.swift
//  Agenda Arterial V1
//
//  Created by Gabriel Crisostomo on 19/09/22.
//

import SwiftUI

struct TimerView: View {
    @State var tiempoRestante = 0
    @Binding var timerTime : Int
    @State var timerIsPaused = true
    @State var timer: Timer? = nil
    
    @Environment(\.presentationMode) var presentationMode
    
    func convertirSegundosATiempo(tiempoRestanteSegundos : Int) -> String{
        let minutos = tiempoRestanteSegundos / 60
        let segundos = tiempoRestanteSegundos % 60
        return String(format:"%02i:%02i",minutos,segundos)
    }
    
    
    func empiezaTemporizador(){
        timerIsPaused = false
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ _ in
            tiempoRestante -= 1
            if tiempoRestante < 0{
                timerIsPaused = true
                timer?.invalidate()
                tiempoRestante = timerTime
            }
        }
    }
    
    func pausaTemporizador(){
        timerIsPaused = true
        timer?.invalidate()
        timer = nil
    }
    
    var body: some View {
        ZStack{
            Circle().fill(.cyan).frame(width: 250, height: 250, alignment: .center)
            
            VStack {
                Text(convertirSegundosATiempo(tiempoRestanteSegundos: tiempoRestante)).font(.system(size: 50))
                
                if timerIsPaused {
                    HStack(spacing : 50){
                        Button(action:{
                            empiezaTemporizador()
                            print("START")
                        }){
                            Image(systemName: "play.fill").resizable().frame(width: 35, height: 40, alignment: .center)
                        }
                    }
                } else {
                    Button(action:{
                        print("STOP")
                        pausaTemporizador()
                    }){
                        Image(systemName: "stop.fill").resizable().frame(width: 40, height: 40, alignment: .center)
                    }
                }
                
            }.foregroundColor(.white)
            
        }.zIndex(2).onAppear{
            tiempoRestante = timerTime
        }
        Button(action:{
            presentationMode.wrappedValue.dismiss()
        }){
            Text("Terminar")
        }
    }
}
