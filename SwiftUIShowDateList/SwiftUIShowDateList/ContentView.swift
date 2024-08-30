//
//  ContentView.swift
//  SwiftUIShowDateList
//
//  Created by topeerz on 21/08/2024.
//

import SwiftUI

struct ContentView: View {

    // TODO: how could I use Observation framework here?
    @State private var viewModel = DateListViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.currentDates.enumerated().map { $0 }, id: \.1) { index, date in
                Text("\(index + 1) \(date.date)")

            }.listStyle(.plain)
            .navigationTitle("My List")
            .navigationBarItems(trailing: Button(action: {
                Task {
                    await viewModel.popuplateListView()
                }
            }, label: {
                Image(systemName: "arrow.clockwise.circle")
            }))
            .task {
                await viewModel.popuplateListView()
            }
        }
    }
}

#Preview {
    ContentView()
}
