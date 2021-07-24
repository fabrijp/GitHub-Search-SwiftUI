//
//  noResultView.swift
//  github Search
//
//  Created by Alexandre Fabri on 2021/07/24.
//

import SwiftUI

struct NoResultView: View {
    var body: some View {
        Text("No results")
            .font(.title)
            .foregroundColor(.gray)
    }
}

struct NoResultView_Previews: PreviewProvider {
    static var previews: some View {
        NoResultView()
    }
}
