//
//  LogForm.swift
//  PipiKaka
//
//  Created by Tobias Pickel on 08.02.20.
//  Copyright © 2020 Tobias Pickel. All rights reserved.
//

import SwiftUI

struct LogTypeForm: View {
    @State var type = ""
    var types = ["Arbeit", "Pipi", "Kaffee", "Mittagspause"]
    var onSubmit: (Log) -> Void
    func reset() {
        type = ""
    }

    var body: some View {
        Group {
            if self.type != "" {
                LogForm(type: type, onCancel: {
                    self.reset()
                }, onSubmit: { log in
                    self.onSubmit(log)
                    self.reset()
                })
            } else {
                LogTypeSelector(types: types) { nextType in
                    self.type = nextType
                }.animation(.default)
            }
        }
    }
}

struct LogForm: View {
    var type: String
    var startDate = Date()
    var onCancel: () -> Void
    var onSubmit: (Log) -> Void

    var body: some View {
        VStack {
            Text(type).font(.largeTitle).padding()
            VStack {
                AnimatedTimer(date: self.startDate)
            }
            Spacer()
            HStack {
                Button(action: self.onCancel, label: {
                    Text("abbrechen").padding()
                }).foregroundColor(Color(.systemRed)).padding()
                Spacer()
                Button(action: {
                    let dayLog = getTimeDiff(start: self.startDate, end: Date())
                    let nextLog = Log(type: self.type, hours: dayLog.hours, minutes: dayLog.minutes, seconds: dayLog.seconds)
                    self.onSubmit(nextLog)
                }, label: {
                    Image(systemName: "plus")
                    Text("Timer stoppen")
                }).padding()

            }.padding()
        }
    }
}

struct LogTypeSelector: View {
    var types: [String] = []
    var onSelect: (_ label: String) -> Void

    var body: some View {
        VStack {
            Text("was machst du gerade ?").font(.largeTitle)
            ForEach(types, id: \.self) { type in
                VStack {
                    Button(action: {
                        self.onSelect(type)
                    }, label: {
                        Text(type).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100, alignment: .center).background(Color(.systemTeal)).foregroundColor(Color(.white))
                            .cornerRadius(8)
                    })
                }
            }.padding()
        }
    }
}

struct LogTypePicker: View {
    var types: [String] = []
    @Binding var selectedType: Int

    var body: some View {
        Picker(selection: $selectedType, label: Text("Select your activity")) {
            ForEach(0 ..< types.count) {
                Text(self.types[$0]).padding().shadow(radius: 3).background(Color(.lightGray))
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}

struct AnimatedTimer: View {
    var date: Date
    @State var counter = "0"
    @State var isRunning = false

    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.counter = getTimeDifference(startDate: self.date, stopDate: Date())

            if self.isRunning == false {
                timer.invalidate()
            }
        }
    }

    var body: some View {
        Counter(counter: self.counter).onAppear {
            self.isRunning = true
            self.startTimer()
        }.onDisappear {
            self.isRunning = false
        }
    }
}

struct LogForm_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LogTypeSelector(types: ["Arbeit", "Pipi"], onSelect: { _ in })
            LogForm(type: "Arbeit", onCancel: {}, onSubmit: { _ in })
        }
    }
}
