//
//  ListView.swift
//  github Search
//
//  Created by Alexandre Fabri on 2021/07/23.
//

import SwiftUI

struct ListView: View {
    
    @Binding var repositories:[Repository]
    
    var body: some View {
        
        // Only display the results.
        // Actions is out of escope for this project
        List(repositories, id: \.self) { item in
            
            // We may move the code below that construct the row to a separate view
            // in case more data or complex actions be inserted
            VStack(alignment:.leading) {
                
                HStack {
                    Text(item.fullName)
                    Spacer()
                    Text("⭐️\(item.starGazersCount)")
                        .font(.footnote)
                }
                
                if let language = item.language {
                    Text(language)
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                
            }
            
            
        }
        
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(repositories: .constant([]))
    }
}
