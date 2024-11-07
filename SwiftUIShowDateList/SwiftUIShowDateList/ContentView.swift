//
//  ContentView.swift
//  SwiftUIShowDateList
//
//  Created by topeerz on 21/08/2024.
//

import SwiftUI

struct ContentView: View {

    private var subViewVM = SubViewVM() // that's just test to compare "older" approach

    @State private var am = AppM()
    @State private var vm = DateListVM()

    var body: some View {
        NavigationView {
            List(vm.currentDates.enumerated().map { $0 }, id: \.1) { index, date in
                    Text("\(index + 1) \(date.date)")
                    SubView()

            }.listStyle(.plain)
            .navigationTitle("My List")
            .navigationBarItems(trailing: Button(action: {
                Task {
                    await vm.popuplateListView()
                    subViewVM.imageText = "triangle"
                }
            }, label: {
                Image(systemName: "arrow.clockwise.circle")
            }))
            .task {
                await vm.popuplateListView()
            }

            .alert("!!!", isPresented: $vm.loading) {
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("loading...")
            }

            .environmentObject(subViewVM)
        }
    }
}

struct SubView: View {
    @EnvironmentObject var vm: SubViewVM

    var body: some View {
        Text("subView")
        Image(systemName: vm.imageText)
    }
}

#Preview {
    ContentView()
}
