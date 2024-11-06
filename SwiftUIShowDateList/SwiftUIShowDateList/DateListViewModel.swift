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
    var loading = false
    var dateService: DateServiceProtocol = DateService()

    // TODO: problem with this approach is that we have logic in view model. This shall be probably migrated to VIA.
    func popuplateListView() async {
        loading = true

        currentDates.removeAll()
        for _ in (1...3) {
            guard let date = try? await dateService.getDate() else {
                return
            }

            currentDates.append(date)
        }

        loading = false
    }
}

class OldModel: ObservableObject {
    @Published var imageText = "circle"
}

struct CurrnetDate: Decodable, Identifiable, Hashable {
    let date: String
    let id: UUID

    init(id: UUID = UUID(), date: String) {
        self.id = id
        self.date = date
    }
}
