//
//  DataListViewModelTest.swift
//  SwiftUIShowDateListTests
//
//  Created by topeerz on 06/11/2024.
//

import Testing
import Foundation
@testable import SwiftUIShowDateList

// this one is better for testing list
struct DateServiceMock: DateServiceProtocol {
    var dateStub: SwiftUIShowDateList.CurrnetDate?

    func getDate() async throws -> SwiftUIShowDateList.CurrnetDate? {
        dateStub
    }
}

// this one is better for testing DateService itself
class URLProtocolMock: URLProtocol {
    static var receivedDataStub: Data?

    override class func canInit(with request: URLRequest) -> Bool {
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        let response = HTTPURLResponse(
            url: request.url!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!

        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        client?.urlProtocol(self, didLoad: Self.receivedDataStub!)
        client?.urlProtocolDidFinishLoading(self)

        // TODO: handle networkign errors
//        client?.urlProtocol(self, didFailWithError: NSError(domain: "12345", code: -1))
    }

    override func stopLoading() {
    }
}

@MainActor
struct DataListViewModelTest {
    let sut = DateListViewModel()

    @Test mutating func test_populateListView_shouldPopulateCurrentDates() async throws {
        // given
        let testUUID = try #require(UUID(uuidString: "00000000-0000-0000-0000-000000000001"))
        UUIDProvider.forge = { testUUID }

        // TODO: handle invalid data
        let dateDataJSON = "{\"date\":\"Thu Nov 07 2024 11:41:22 GMT+0000 (Coordinated Universal Time)\"}"
        let dateData = try #require(dateDataJSON.data(using: .utf8))
        let expectedCurrentDate = try #require(try? JSONDecoder().decode(CurrnetDate.self, from: dateData))

        let urlSessionConfiguration = URLSessionConfiguration.ephemeral
        urlSessionConfiguration.protocolClasses = [URLProtocolMock.self]
        let urlSession = URLSession(configuration: urlSessionConfiguration)

        URLProtocolMock.receivedDataStub = dateDataJSON.data(using: .utf8)

        sut.dateService = DateService(urlSession: urlSession)

        // when
        await sut.popuplateListView()

        // then
        #expect(sut.currentDates.contains(expectedCurrentDate))
    }

}
