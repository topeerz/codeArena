//
//  ContentView.swift
//  SwiftUIShowDateList
//
//  Created by topeerz on 21/08/2024.
//

import SwiftUI

struct ContentView: View {
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

    // TODO: add some navigation
    // TODO: what about SwiftData?
    // TODO: try profiling this in instruments
    var body: some View {
        NavigationView {
            List(vm.currentDates.enumerated().map { $0 }, id: \.1) { index, date in
                Text("\(index + 1) \(date.date)")
                SubView()

            }.listStyle(.plain)
            .navigationTitle("My List")
            .navigationBarItems(trailing: Button(action: {
                Task {
                    await vi.onReloadButton()
                }
            }, label: {
                Image(systemName: "arrow.clockwise.circle")
            }))
            .task {
                await vi.onInit()
            }
            .alert("!!!", isPresented: $vm.loading) {
                Button("Cancel", role: .cancel) {
                    Task {
                        await vi.onCancelButton()
                    }
                }
            } message: {
                Text("loading...")
            }
            .environmentObject(appI) // so it can be later used in subviews if needed
            .environmentObject(appM) // so it can be later used in subviews if needed
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

#Preview {
    @Previewable @State var appM = AppM()
    let appI = AppI(appM: appM)
    ContentView(appM: appM, appI: appI)
}
