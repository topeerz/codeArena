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
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

