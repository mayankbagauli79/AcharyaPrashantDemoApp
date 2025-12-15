//
//  ImageGridViewModel.swift
//  Acharya_Prashnt's_DemoApp
//
//  Created by Mayank on 13/12/25.
//

import SwiftUI

@MainActor
final class ImageGridViewModel: ObservableObject {
    @Published var items: [MediaCoverage] = []
    @Published var errorMessage: String?
    
    func loadImages() {
        Task {
            do {
                items = try await APIService.shared.fetchCoverages(limit: 200)
            } catch {
                errorMessage = "Unable to load images. Please check your internet connection."
            }
        }
    }
}
