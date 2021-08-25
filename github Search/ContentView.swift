//
//  ContentView.swift
//  github Search
//
//  Created by Alexandre Fabri on 2021/07/23.
//

import SwiftUI

struct ContentView: View {

    let api = API()
    @State var searchText: String = ""
    @State var repositories: Items = Items()
    // Helpers
    @State var pendingRequestWorkItem: DispatchWorkItem?
    @State var showNoResultView = false
    @State var isFetching = false

    var body: some View {

        VStack {

            // Show views
            SearchBar(searchText: $searchText)

            if isFetching { ProgressView() }

            if showNoResultView {
                NoResultView()
            } else {
                ListView(repositories: $repositories.items)
            }

            Spacer()

        }
        .onChange(of: searchText, perform: { typedText in

            // We may call a function to execute this and move the code elsewhere but since the
            // project are so simple, its better readable here.

            // Remove items when there is a new search in the works and cancel any previous WorkItem
            repositories.items = []
            pendingRequestWorkItem?.cancel()

            // Return from here if there is nothing to search
            if typedText.count == 0 { return }

            // Wrap API request in a work item for the throttle sake
            let requestWorkItem = DispatchWorkItem {
                isFetching.toggle()
                api.request(search: typedText) { result in
                    isFetching.toggle()
                    repositories = result
                    showNoResultView = result.items.count == 0
                }
            }

            // Assign the WorkItem and set the delayed execution
            pendingRequestWorkItem = requestWorkItem
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: requestWorkItem)

        })

    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
