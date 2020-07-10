//
//  DogListRow.swift
//  WTechTestMVI
//
//  Created by Jae Kwang Lee on 2020/07/05.
//  Copyright © 2020 Jae Kwang Lee. All rights reserved.
//

import SwiftUI

struct DogListRowView: View {
    var model: DogListRowViewModel
    var cache: ImageCache?
    
    var body: some View {
        HStack {
            AsyncImage(
                url: URL(string: model.photoURL)!,
                cache: self.cache,
                placeholder: Text("Loading"),
                configuration: { $0.resizable() }
            )
                .frame(width: 80, height: 80, alignment: .center)
            VStack(alignment: .leading) {
                Text(model.name)
                Text(model.lifespanFormatted).foregroundColor(.gray)
            }
            Spacer()
        }
    }
}

struct DogListRowView_Previews: PreviewProvider {
    static var previews: some View {
        let model = DogListRowViewModel(id: "234", name: "Puppy", photoURL: "", lifespanFormatted: "3 years", desc: "Very nice dog.")
        return DogListRowView(model: model, cache: nil)
    }
}
