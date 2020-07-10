//
//  DogListView.swift
//  WTechTestMVI
//
//  Created by Jae Kwang Lee on 2020/07/05.
//  Copyright © 2020 Jae Kwang Lee. All rights reserved.
//

import SwiftUI

struct DogListView: View {
    @EnvironmentObject var intentWorker: DogListIntentHandler
    @EnvironmentObject var viewModel: DogListViewModel
    @Environment(\.imageCache) var imageCache: ImageCache
       
    struct LoadingView: View {
        var body: some View {
            ActivityIndicator(isAnimating: true) {
                $0.color = .gray
                $0.hidesWhenStopped = false
                $0.style = .large
            }
        }
    }

    struct SuccessView: View {
        @EnvironmentObject var intentWorker: DogListIntentHandler
        @EnvironmentObject var viewModel: DogListViewModel

        var body: some View {
            NavigationView {
                List(viewModel.rowModels) { rowModel in
                    DogListRowView(model: rowModel)
                }
                .navigationBarItems(trailing: Button(action: {
                    self.intentWorker.perform(.sort)
                }, label: {
                    Text(viewModel.sortText)
                }))
                .navigationBarTitle(Text("Dog List"))
            }
        }
    }

    struct FailedView: View {
        var body: some View {
            Text("Failed.")
        }
    }

    var body: some View {
        Group {
            if viewModel.state == .loading {
                LoadingView()
            }
            else if viewModel.state == .failed {
                FailedView()
            }
            else {
                SuccessView()
            }
        }
        .onAppear {
            self.intentWorker.perform(.viewAppeared)
        }
    }
}

struct DogListView_Previews: PreviewProvider {
    static var previews: some View {
        return DogListView()
    }
}

extension DogListView {
    static func make() -> some View {
        let intentHandler = DogListIntentHandler()
        let viewModel = DogListViewModel()
        viewModel.subscribe(action: intentHandler.action)
        return DogListView()
            .environmentObject(intentHandler)
            .environmentObject(viewModel)
    }
}
