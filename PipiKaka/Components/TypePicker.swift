//
//  TypePicker.swift
//  PipiKaka
//
//  Created by Tobias Pickel on 26.01.20.
//  Copyright © 2020 Tobias Pickel. All rights reserved.
//

import SwiftUI

struct TypePicker: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(LinearGradient(gradient: Gradient(colors: [Color(.blue), Color(.systemBlue)]), startPoint: .leading, endPoint: .trailing))
                .frame(width: 200, height: 200, alignment: .center)
                .shadow(radius: 5)
            Text("1 minute 10 seconds 7 hours").foregroundColor(Color(.white)).font(.headline)
        }.padding()
    }
}

struct TypePicker_Previews: PreviewProvider {
    static var previews: some View {
        TypePicker()
    }
}