//
//  DateListViewModel.swift
//  SwiftUIShowDateList
//
//  Created by topeerz on 27/08/2024.
//

import Foundation
import Observation

@Observable
class AppM {
    var triangleMode
}

@MainActor
@Observable
class DateListVM {

    var text = "123"
    var currentDates = [CurrnetDate]()
    var loading = false
    // this will be created during initialization of swift ui - hence seems it will get called in UT (including sending requests) before we actually test anything?
    var dateService: DateServiceProtocol = DateService(urlSession: URLSession.shared)

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

class SubViewVM: ObservableObject {
    @Published var imageText = "circle"
}

class UUIDProvider {
    static var forge = { UUID() }
    class func uuid() -> UUID {
        forge()
    }
}

struct CurrnetDate: Decodable, Identifiable, Hashable {
    let date: String
    let id: UUID = UUIDProvider.uuid()

    private enum CodingKeys: String, CodingKey {
        case date
    }

    init(date: String) {
        self.date = date
    }
}
