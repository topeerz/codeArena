//
//  DateListViewModel.swift
//  SwiftUIShowDateList
//
//  Created by topeerz on 27/08/2024.
//

import Foundation
import Observation
import SwiftUI // for NavigationPath


// TODO: should I merge this with Interactor or just use from ineractor?
@Observable
class RootRouter {
    public enum Destination: Codable, Hashable {
        case one
        case two
    }

    var navPath = NavigationPath()

    func navigate(to destination: Destination) {
        navPath.append(destination)
    }

    func navigateBack() {
        navPath.removeLast()
    }

    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}

class AppI: ObservableObject { // ObservableObject so I can pass it via env ...
    var appM: AppM?
    var appR: RootRouter?

    init(appM: AppM, appR: RootRouter) {
        self.appM = appM
        self.appR = appR
    }

    init() {
    }
}

@Observable
class AppM {
    var triangleMode = false
}

@MainActor
class DateListI {
    var appI: AppI!
    weak var vm: DateListVM!
    // this will be created during initialization of swift ui - hence seems it will get called in UT (including sending requests) before we actually test anything?
    var dateService: DateServiceProtocol = DateService(urlSession: URLSession.shared)

    init() {
    }

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

    func onClick() {
        vm.clicks += 1
    }

    func onInit() async {
        await populateList()
    }

    func onReloadButton() async {
        await populateList()
        appI.appM?.triangleMode = true
    }

    func onNavigateButton() async {
        appI.appR?.navigate(to: .two)
    }

    func onCancelButton() async {
        appI.appM?.triangleMode = false
    }
}

@MainActor
@Observable
class DateListVM  {
    var text = "123"
    var currentDates = [CurrnetDate]()
    var loading = false
    var clicks: Int = 0
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
