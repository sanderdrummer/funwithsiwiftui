//
//  LogMetrics.swift
//  PipiKaka
//
//  Created by Tobias Pickel on 08.02.20.
//  Copyright © 2020 Tobias Pickel. All rights reserved.
//

import SwiftUI

struct Metrics: Identifiable {
    var id = UUID()
    var type: String
    var time: LogTime
}

struct LogMetrics: View {
    var metrics: [Metrics]
    var body: some View {
        return Group {
            ScrollView(.horizontal) {
                HStack(alignment: .top) {
                    ForEach(metrics) { value in
                        VStack {
                            Text(value.type)
                            Text("\(value.time.hours)h \(value.time.minutes)m \(value.time.seconds)s ")
                        }.padding().foregroundColor(Color(.white)).background(Color(.systemTeal)).cornerRadius(12)
                    }
                }
            }
        }
    }
}

struct LogMetrics_Previews: PreviewProvider {
    static var previews: some View {
        LogMetrics(metrics: [Metrics(type: "Arbeit", time: LogTime(hours: 5, minutes: 43, seconds: 12)), Metrics(type: "Arbeit", time: LogTime(hours: 5, minutes: 43, seconds: 12)), Metrics(type: "Arbeit", time: LogTime(hours: 5, minutes: 43, seconds: 12)), Metrics(type: "Arbeit", time: LogTime(hours: 5, minutes: 43, seconds: 12))])
    }
}
