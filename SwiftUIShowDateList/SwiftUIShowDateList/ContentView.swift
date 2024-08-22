//
//  ContentView.swift
//  SwiftUIShowDateList
//
//  Created by topeerz on 21/08/2024.
//

import SwiftUI

struct CurrnetDate: Decodable {
    let date: String
}

struct ContentView: View {

    @State private var currentDates: [CurrnetDate] = []

    private func getDate() async throws -> CurrnetDate? {
        guard let url = URL(string: "https://aluminum-accidental-tray.glitch.me/testme") else {
            fatalError("url failed")
        }

        let (data, response)  = try await URLSession.shared.data(from: url)
        return try? JSONDecoder().decode(CurrnetDate.self, from: data)
    }

    private func populateDates() async {
        currentDates.removeAll()
        for _ in (1...3) {
            guard let date = try? await getDate() else {
                return
            }

            currentDates.append(date)
        }
    }

    private func getDateFor(_ index: Int) -> CurrnetDate? {
        if currentDates.count > index {
            return currentDates[index]

        } else {
            return nil
        }
    }

    var body: some View {
        NavigationView {
            List(1...3, id: \.self) { index in
                Text("\(index) \(getDateFor(index - 1)?.date ?? "None")")
            }.listStyle(.plain)

            .navigationTitle("My List")
            .navigationBarItems(trailing: Button(action: {
                Task {
                    await populateDates()
                }
            }, label: {
                Image(systemName: "arrow.clockwise.circle")
            }))
            .task {
                await populateDates()
            }
        }
    }
}

#Preview {
    ContentView()
}
