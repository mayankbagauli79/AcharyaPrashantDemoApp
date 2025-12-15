//
//  ContentView.swift
//  Acharya_Prashnt_DemoApp
//
//  Created by Mayank on 13/12/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ImageGridViewModel()
    
    private let columns = [
        GridItem(.adaptive(minimum: 110), spacing: 8)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(viewModel.items) { item in
                        if let url = item.thumbnail.imageURL {

                            GridImageCell(
                                url: url,
                                cacheKey: item.id
                            )
                            .aspectRatio(1, contentMode: .fit)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Media Coverages")
            .onAppear {
                viewModel.loadImages()
            }
            .alert(
                "Error",
                isPresented: Binding(
                    get: { viewModel.errorMessage != nil },
                    set: { _ in viewModel.errorMessage = nil }
                )
            ) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
        }
    }
}
