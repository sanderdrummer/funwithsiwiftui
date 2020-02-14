//
//  Components.swift
//  PipiKaka
//
//  Created by Tobias Pickel on 02.02.20.
//  Copyright © 2020 Tobias Pickel. All rights reserved.
//

import SwiftUI

struct Components: View {
    var body: some View {
        VStack {
            Text("ok Cool")
            Text("Ok nice")
        }.padding().foregroundColor(Color(.white)).background(Color(.systemBlue)).cornerRadius(4)
    }
}

struct Counter: View {
    var counter: String
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(.white)).opacity(0)
                .overlay(
                    Circle()
                        .stroke(Color(.systemTeal), lineWidth: 5)
                )
                .frame(width: 350, height: 350, alignment: .center)

            Text(counter).font(.largeTitle)
        }.padding()
    }
}

struct Components_Previews: PreviewProvider {
    static var previews: some View {
        Counter(counter: "3920408234029834")
    }
}