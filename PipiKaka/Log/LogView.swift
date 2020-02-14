//
//  LogView.swift
//  PipiKaka
//
//  Created by Tobias Pickel on 26.01.20.
//  Copyright © 2020 Tobias Pickel. All rights reserved.
//

import SwiftUI

struct LogView: View {
    @ObservedObject var state: LogState
    
    var body: some View {
        VStack{
            VStack{
                VStack {
                    LogMetrics(metrics: state.metrics).padding()
                    Divider()
                }
                if (state.isClosed){
                    LogList(logs: state.logs)
                } else {
                    LogTypeForm(onSubmit: {log in
                        self.state.addLog(log: log)
                        self.state.formIsActive.toggle()
                    })
                }
                
            }
        }.onAppear(){
            self.state.loadLogs()
        }
    }
}

struct LogList: View {
    var logs: [Log]
    var body: some View {
        ForEach(logs) {log in
            VStack(alignment: .center) {
                Text("\(log.type) - \(log.hours)h \(log.minutes)m \(log.seconds)s ")
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading).padding()
        }
    }
}


struct LogView_Previews: PreviewProvider {
    static var previews: some View {
        LogView(state: LogState(fileName: "", title: "hi"))
        //        LogList(logs: getRandomLogs())
    }
}
