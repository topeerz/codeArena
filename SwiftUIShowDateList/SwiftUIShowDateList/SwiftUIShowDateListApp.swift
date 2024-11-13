//
//  SwiftUIShowDateListApp.swift
//  SwiftUIShowDateList
//
//  Created by topeerz on 21/08/2024.
//

import Observation
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
    @State private var appR: RootRouter = RootRouter()
    @State private var appM: AppM = AppM()
    private var appI: AppI!

    init() {
        self.appI = AppI(appM: self.appM, appR: self.appR)
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appR.navPath) {
                RootView(appM: appM, appI: appI)
                // TODO: the navigationDestination could be moved inside RootView. Which one is better? Probably it depends is it sub-view or ohter-feature view.
                .navigationDestination(for: RootRouter.Destination.self) { destination in
                    switch(destination) {
                        case .one:
                            OtherView()

                        case .two:
                            OtherView()
                    }
                }
                .environmentObject(appI)  // so it can be later used in subviews if needed?
                .environmentObject(appM)  // so it can be later used in subviews if needed?
            }
        }
    }
}

