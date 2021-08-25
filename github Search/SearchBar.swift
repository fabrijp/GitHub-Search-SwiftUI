//
//  SearchBar.swift
//  github Search
//
//  Created by Alexandre Fabri on 2021/07/23.
//

import SwiftUI
import Combine

struct SearchBar: View {

    @Binding var searchText: String
    var api = API()

    var body: some View {
        HStack {
            Image("github-logo")
                .resizable()
                .frame(width: 30, height: 30)
            Text("Search:")
                .fontWeight(.medium)
            TextField("Repositories", text: $searchText)
                .foregroundColor(.gray)
        }
        .padding()

    }

}
