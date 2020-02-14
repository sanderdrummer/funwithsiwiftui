//
//  saveJson.swift
//  PipiKaka
//
//  Created by Tobias Pickel on 11.01.20.
//  Copyright © 2020 Tobias Pickel. All rights reserved.
//

import Foundation
import UIKit

func saveJSON<T: Codable>(named: String, object: T) {
    do {
        let fileURL = try FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent(named)
        let encoder = try JSONEncoder().encode(object)

        try encoder.write(to: fileURL)
    } catch {
        print("JSONSave error of \(error)")
    }
}

func readJSON<T: Codable>(named: String, _ object: T.Type) -> T? {
    do {
        let fileURL = try FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent(named)
        let data = try Data(contentsOf: fileURL)

        let object = try JSONDecoder().decode(T.self, from: data)

        return object
    } catch {
        return nil
    }
}
