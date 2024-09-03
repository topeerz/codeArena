//
//  DateListViewModel.swift
//  SwiftUIShowDateList
//
//  Created by topeerz on 27/08/2024.
//

import Foundation
import Observation

@MainActor
@Observable
class DateListViewModel {

    var text = "123"
    var currentDates = [CurrnetDate]()

    func popuplateListView() async {
        let dateService = DateService()

        currentDates.removeAll()
        for _ in (1...3) {
            guard let date = try? await dateService.getDate() else {
                return
            }

            currentDates.append(date)
        }
    }
}

class OldModel: ObservableObject {
    @Published var imageText = "circle"
}

struct CurrnetDate: Decodable, Identifiable, Hashable {
    let date: String
    let id = UUID()
}
