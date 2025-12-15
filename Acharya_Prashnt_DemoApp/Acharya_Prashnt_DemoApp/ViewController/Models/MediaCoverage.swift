//
//  MediaCoverage.swift
//  Acharya_Prashnt's_DemoApp
//
//  Created by Mayank on 13/12/25.
//

import Foundation

// MARK: - MediaCoverage Model

struct MediaCoverage: Codable, Identifiable {
    let id: String
    let title: String?
    let language: String?
    let thumbnail: Thumbnail
    let mediaType: Int?
    let coverageURL: String?
    let publishedAt: String?
    let publishedBy: String?
    let backupDetails: BackupDetails?
    let description: String?
    let seoSlugWithId: String?
}

// MARK: - Thumbnail

struct Thumbnail: Codable {
    let id: String?
    let version: Int?
    let domain: String
    let basePath: String
    let key: String
    let qualities: [Int]?
    let aspectRatio: Double?
    
    /// Constructed image URL per assignment:
    /// imageURL = domain + "/" + basePath + "/0/" + key
    var imageURL: URL? {
        let s = domain.trimmingCharacters(in: .whitespacesAndNewlines) + "/" +
                basePath.trimmingCharacters(in: .whitespacesAndNewlines) + "/0/" +
                key.trimmingCharacters(in: .whitespacesAndNewlines)
        return URL(string: s)
    }
}


// MARK: - BackupDetails

struct BackupDetails: Codable {
    let pdfLink: String?
    let screenshotURL: String?
}
