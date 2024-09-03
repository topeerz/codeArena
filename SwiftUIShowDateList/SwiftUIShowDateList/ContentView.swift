//
//  ContentView.swift
//  SwiftUIShowDateList
//
//  Created by topeerz on 21/08/2024.
//

import SwiftUI

struct ContentView: View {

    private var vm2 = OldModel()
    @State private var viewModel = DateListViewModel()
    @Environment(DateListViewModel.self) var dlv

    @Bindable private var viewModel3 = DateListViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.currentDates.enumerated().map { $0 }, id: \.1) { index, date in
                    Text("\(index + 1) \(date.date)")
                    SubView()

            }.listStyle(.plain)
            .navigationTitle("My List")
            .navigationBarItems(trailing: Button(action: {
                Task {
                    await viewModel.popuplateListView()
                    vm2.imageText = "triangle"
                }
            }, label: {
                Image(systemName: "arrow.clockwise.circle")
            }))
            .task {
                await viewModel.popuplateListView()
            }
            .environmentObject(vm2)
        }
    }
}

struct SubView: View {
    @EnvironmentObject var vm2: OldModel

    var body: some View {
        Text("subView")
        Image(systemName: vm2.imageText)
    }
}

#Preview {
    ContentView()
        .environment(DateListViewModel()) // seems this needs to be injected on higher level
}
