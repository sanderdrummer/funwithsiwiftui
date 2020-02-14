//
//  Log.swift
//  PipiKaka
//
//  Created by Tobias Pickel on 26.01.20.
//  Copyright © 2020 Tobias Pickel. All rights reserved.
//

import Combine
import Foundation

struct Log: Codable, Identifiable {
    var id = UUID()
    var type = ""
    var hours: Int
    var minutes: Int
    var seconds: Int
}

func getRandomLogs() -> [Log] {
    return [Log(type: "Arbeit", hours: 12, minutes: 32, seconds: 23), Log(type: "Arbeit", hours: 12, minutes: 32, seconds: 23), Log(type: "Arbeit", hours: 12, minutes: 32, seconds: 23)]
}

class LogState: ObservableObject {
    public var title: String
    public var fileName: String
    init(fileName: String, title: String) {
        self.fileName = fileName
        self.title = title
    }

    var isClosed: Bool {
        return title != formatTime(Date())
    }

    @Published var logs: [Log] = []
    @Published var metrics: [Metrics] = []
    @Published var formIsActive = false

    func addLog(log: Log) {
        logs.append(log)
        saveLogs()
    }

    func removeLog(index: Int) {
        logs.remove(at: index)
        saveLogs()
    }

    func loadLogs() {
        let savedLog = readJSON(named: "\(fileName).json", [Log].self)
        logs = savedLog ?? []
        metrics = mapLogs(savedLog ?? [])
    }

    func saveLogs() {
        saveJSON(named: "\(fileName).json", object: logs)
        metrics = mapLogs(logs)
    }

    func showForm(_: String) {
        formIsActive = true
    }
}

func getTimeDifference(startDate: Date, stopDate: Date) -> String {
    let intervalFormatter = DateComponentsFormatter()
    intervalFormatter.allowedUnits = [.hour, .minute, .second]
    intervalFormatter.unitsStyle = .abbreviated
    let string = intervalFormatter.string(from: startDate, to: stopDate)
    return string ?? ""
}

struct LogTime {
    var hours: Int
    var minutes: Int
    var seconds: Int
}

func getTimeDiff(start: Date, end: Date) -> LogTime {
    let currentCalendar = Calendar.current
    let components = currentCalendar.dateComponents([.hour, .minute, .second], from: start, to: end)
    return LogTime(hours: components.hour ?? 0, minutes: components.minute ?? 0, seconds: components.second ?? 0)
}

func mapLogs(_ logs: [Log]) -> [Metrics] {
    var dict: [String: LogTime] = [:]
    logs.forEach { log in
        if dict[log.type] == nil {
            dict[log.type] = LogTime(
                hours: log.hours, minutes: log.minutes, seconds: log.seconds
            )
        } else {
            let time = dict[log.type]
            dict[log.type] = normalize(LogTime(
                hours: log.hours + (time?.hours ?? 0), minutes: log.minutes + (time?.minutes ?? 0), seconds: log.seconds + (time?.seconds ?? 0)
            ))
        }
    }
    var metrics: [Metrics] = []
    for (key, value) in dict {
        metrics.append(Metrics(type: key, time: value))
    }

    return metrics
}

func normalize(_ time: LogTime) -> LogTime {
    var seconds = time.seconds
    var hours = time.hours
    var minutes = time.minutes
    if seconds > 60 {
        minutes = minutes + 1
        seconds = seconds % 60
    }
    if minutes > 60 {
        hours = hours + 1
        minutes = minutes % 60
    }

    return LogTime(hours: hours, minutes: minutes, seconds: seconds)
}