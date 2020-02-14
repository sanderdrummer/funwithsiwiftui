//
//  Days.swift
//  PipiKaka
//
//  Created by Tobias Pickel on 31.01.20.
//  Copyright © 2020 Tobias Pickel. All rights reserved.
//

import SwiftUI

let dayPath = "days_v2.json"

struct Day: Codable, Identifiable, Hashable, Comparable {
    static func < (lhs: Day, rhs: Day) -> Bool {
        return lhs.date < rhs.date
    }

    var id: String = getDay(date: Date())
    var date = Date()
    var title: String {
        return formatTime(date)
    }
}

let dayFormatter = DateFormatter()

func getDay(date: Date) -> String {
    dayFormatter.dateFormat = "DD_MM_yyyy"
    return dayFormatter.string(from: date)
}

func formatTime(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter.string(for: date) ?? ""
}

struct DayPicker: View {
    @State var days: [String: Day] = [:]

    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    List(days.values.sorted()) { day in
                        NavigationLink(destination: LogView(state: LogState(fileName: day.id, title: day.title)), label: {
                            Text(day.title)
                            HStack { Text("Hi") }
                        })
                    }
                }.navigationBarItems(trailing:
                    Button(action: {
                        let nextDay = Day()
                        self.days.updateValue(nextDay, forKey: nextDay.id)
                        saveJSON(named: dayPath, object: self.days)
                    }, label: { Text("heute tracken") })
                ).navigationBarTitle("Logs")
            }
        }.onAppear {
            if self.days.isEmpty {
                let savedDays = readJSON(named: dayPath, [String: Day].self)
                self.days = savedDays ?? [:]
            }
        }
    }
}

struct Days_Previews: PreviewProvider {
    static var previews: some View {
        DayPicker()
    }
}
