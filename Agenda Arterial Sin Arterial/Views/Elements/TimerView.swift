//
//  TimerView.swift
//  Agenda Arterial V2.0
//
//  Created by Gabriel Crisostomo on 30/09/22.
//

import SwiftUI

struct TimerView: View {
    @State var missingTime = 0
    @Binding var timerTime : Int
    @State var timerIsPaused = true
    @State var timer: Timer? = nil
    
    @Environment(\.presentationMode) var presentationMode
    
    func secToTime(missingTimeInSeconds : Int) -> String{
        let minutes = missingTimeInSeconds / 60
        let seconds = missingTimeInSeconds % 60
        return String(format:"%02i:%02i",minutes,seconds)
    }
    
    
    func startTimer(){
        timerIsPaused = false
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ _ in
            missingTime -= 1
            if missingTime < 0{
                timerIsPaused = true
                timer?.invalidate()
                missingTime = timerTime
            }
        }
    }
    
    func pauseTimer(){
        timerIsPaused = true
        timer?.invalidate()
        timer = nil
    }
    
    var body: some View {
        ZStack{
            Circle().fill(.cyan).frame(width: 250, height: 250, alignment: .center)
            
            VStack {
                Text(secToTime(missingTimeInSeconds: missingTime)).font(.system(size: 50))
                
                if timerIsPaused {
                    HStack(spacing : 50){
                        Button(action:{
                            startTimer()
                            print("START")
                        }){
                            Image(systemName: "play.fill").resizable().frame(width: 35, height: 40, alignment: .center)
                        }
                    }
                } else {
                    Button(action:{
                        print("STOP")
                        pauseTimer()
                    }){
                        Image(systemName: "stop.fill").resizable().frame(width: 40, height: 40, alignment: .center)
                    }
                }
                
            }.foregroundColor(.white)
            
        }.zIndex(2).onAppear{
            missingTime = timerTime
        }
        Button(action:{
            presentationMode.wrappedValue.dismiss()
        }){
            Text("Terminar")
        }
    }
}
