//
//  DateService.swift
//  SwiftUIShowDateList
//
//  Created by topeerz on 27/08/2024.
//

import Foundation

struct DateService {
    func getDate() async throws -> CurrnetDate? {
        guard let url = URL(string: "https://aluminum-accidental-tray.glitch.me/testme") else {
            fatalError("url failed")
        }

        let (data, response)  = try await URLSession.shared.data(from: url)
        return try? JSONDecoder().decode(CurrnetDate.self, from: data)
    }
}
