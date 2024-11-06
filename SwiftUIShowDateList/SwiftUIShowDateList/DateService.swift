//
//  DateService.swift
//  SwiftUIShowDateList
//
//  Created by topeerz on 27/08/2024.
//

import Foundation

protocol DateServiceProtocol {
    func getDate() async throws -> CurrnetDate?
}

// TODO: add UT here - mock to URLProtocol level
struct DateService: DateServiceProtocol {
    func getDate() async throws -> CurrnetDate? {
        guard let url = URL(string: "https://aluminum-accidental-tray.glitch.me/testme") else {
            fatalError("url failed")
        }

        let (data, response)  = try await URLSession.shared.data(from: url)
        return try? JSONDecoder().decode(CurrnetDate.self, from: data)
    }
}
