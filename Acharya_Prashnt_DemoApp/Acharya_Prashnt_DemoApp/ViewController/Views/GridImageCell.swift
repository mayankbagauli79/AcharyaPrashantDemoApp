//
//  GridImageCell.swift
//  Acharya_Prashnt's_DemoApp
//
//  Created by Mayank on 13/12/25.
//

import SwiftUI

struct GridImageCell: View {
    let url: URL
    let cacheKey: String
    
    @State private var image: UIImage?
    @State private var isError = false
    
    private let loader = ImageLoader()
    
    var body: some View {
        ZStack {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                
            } else if isError {
                //Handle Error if no imge found or fatch from api a 50 X 50 image will show with Fail to load
                VStack(spacing: 6) {
                    Image("img_failed-load")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .padding(6)
                                .background(Color.white)
                                .cornerRadius(8)

                    Text("Failed to load")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
            } else {
                ProgressView()
            }
        }
        .background(Color.gray.opacity(0.1))
        .clipped()
        .onAppear {
            loader.load(from: url, key: cacheKey) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let img):
                        self.image = img
                    case .failure:
                        self.isError = true
                    }
                }
            }
        }
        .onDisappear {
            loader.cancel()
        }
    }
}
