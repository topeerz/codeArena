//
//  DataListViewModelTest.swift
//  SwiftUIShowDateListTests
//
//  Created by topeerz on 06/11/2024.
//

import Testing
import Foundation
@testable import SwiftUIShowDateList

// TODO: conver to test plans
struct DateServiceMock: DateServiceProtocol {
    var dateMock: SwiftUIShowDateList.CurrnetDate?

    func getDate() async throws -> SwiftUIShowDateList.CurrnetDate? {
        dateMock
    }
}

@MainActor
struct DataListViewModelTest {
    let sut = DateListViewModel()

    @Test func test_populateListView_shouldPopulateCurrentDates() async throws {
        // given
        let testUUID = try #require(UUID(uuidString: "00000000-0000-0000-0000-000000000001"))
        let expectedCurrentDate = CurrnetDate(id: testUUID, date: "12345")

        var dateServiceMock = DateServiceMock()
        dateServiceMock.dateMock = expectedCurrentDate
        sut.dateService = dateServiceMock

        // when
        await sut.popuplateListView()

        // then
        #expect(sut.currentDates.contains(expectedCurrentDate))
    }

}
