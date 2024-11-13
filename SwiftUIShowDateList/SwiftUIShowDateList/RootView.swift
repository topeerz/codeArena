//
//  ContentView.swift
//  SwiftUIShowDateList
//
//  Created by topeerz on 21/08/2024.
//

import Observation
import SwiftUI

struct RootView: View {
    @State private var appM: AppM
    private let appI: AppI

    @State private var vm: DateListVM
    private var vi: DateListI

    init(appM: AppM, appI: AppI) {
        self.appM = appM
        self.appI = appI

        let vm = DateListVM()
        self.vm = vm
        self.vi = DateListI(appI: appI, vm: vm)
    }

    // TODO: what about SwiftData?
    // TODO: try profiling this in instruments
    var body: some View {
        List(vm.currentDates.enumerated().map { $0 }, id: \.1) { index, date in
            Text("\(index + 1) \(date.date)")
            SubView()

        }
        .listStyle(.plain)
        .navigationTitle("My List")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    Task {
                        await vi.onNavigateButton()
                    }
                }, label: {
                    Image(systemName: "arrow.clockwise.square")
                })
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    Task {
                        await vi.onReloadButton()
                    }
                }, label: {
                    Image(systemName: "arrow.clockwise.circle")
                })
            }
        }
        .task {
            await vi.onInit()
        }
        // TODO: alert seems to cease to work after switching views
        .alert("!!!", isPresented: $vm.loading) {
            Button("Cancel", role: .cancel) {
                Task {
                    await vi.onCancelButton()
                }
            }
        } message: {
            // TODO: add some animation ...
            Text("loading...")
        }
    }
}

struct SubView: View {
    @EnvironmentObject var appM: AppM

    var body: some View {
        Text("subView")
        Image(systemName: appM.triangleMode ? "triangle" : "")
    }
}

struct OtherView: View {
    @EnvironmentObject var appM: AppM

    var body: some View {
        Text("OtherView")
        Image(systemName: "triangle")
    }
}

#Preview {
    @Previewable @State var appM = AppM()
    @Previewable @State var appR = RootRouter()
    let appI = AppI(appM: appM, appR: appR)
    NavigationStack {
        RootView(appM: appM, appI: appI)
            .environmentObject(appI)  // so it can be later used in subviews if needed?
            .environmentObject(appM)  // so it can be later used in subviews if needed?
    }
}
