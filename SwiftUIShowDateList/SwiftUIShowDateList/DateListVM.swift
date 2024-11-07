//
//  DateListViewModel.swift
//  SwiftUIShowDateList
//
//  Created by topeerz on 27/08/2024.
//

import Foundation
import Observation

// TODO: update objects ownership and add `weak` where necessary
class AppI: ObservableObject {
    var appM: AppM?

    init(appM: AppM) {
        self.appM = appM
    }
}

@Observable
class AppM: ObservableObject {
    var triangleMode = false
}

@MainActor
class DateListI {
    var appI: AppI
    var vm: DateListVM
    // this will be created during initialization of swift ui - hence seems it will get called in UT (including sending requests) before we actually test anything?
    var dateService: DateServiceProtocol = DateService(urlSession: URLSession.shared)

    init(appI: AppI, vm: DateListVM) {
        self.appI = appI
        self.vm = vm
    }

    func populateList() async {
        vm.loading = true

        vm.currentDates.removeAll()
        for _ in (1...3) {
            guard let date = try? await dateService.getDate() else {
                return
            }

            vm.currentDates.append(date)
        }

        vm.loading = false
    }

    func onInit() async {
        await populateList()
    }

    func onReloadButton() async {
        await populateList()
        appI.appM?.triangleMode = true
    }

    func onCancelButton() async {
        appI.appM?.triangleMode = false
    }
}

@MainActor
@Observable
class DateListVM {
    var text = "123"
    var currentDates = [CurrnetDate]()
    var loading = false
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
