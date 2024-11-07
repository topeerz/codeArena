//
//  SwiftUIShowDateListApp.swift
//  SwiftUIShowDateList
//
//  Created by topeerz on 21/08/2024.
//

import SwiftUI

@main
struct Launcher {
    static func main() throws {
        if NSClassFromString("XCTestCase") == nil { // this seems to work now event for Testing framework and UI testing
            SwiftUIShowDateListApp.main()

        } else {
            TestApp.main()
        }
    }
}

struct TestApp: App {
    var body: some Scene {
        WindowGroup {
            Text("This is test ...")
        }
    }
}

struct SwiftUIShowDateListApp: App {
    
    @State private var appM: AppM
    private var appI: AppI

    init() {
        let appM = AppM()
        self.appM = appM
        self.appI = AppI(appM: appM)
    }

    var body: some Scene {
        WindowGroup {
            ContentView(appM: appM, appI: appI)
        }
    }
}

