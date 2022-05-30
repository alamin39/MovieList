//
//  Model.swift
//  Movie List
//
//  Created by Al-Amin on 30/5/22.
//

import Foundation

struct MovieInfo: Codable {
    var page: Int
    var results: [ResultsInfo]?
    var total_pages: Int
    var total_results: Int
}

struct ResultsInfo: Codable {
    var adult: Bool
    var backdrop_path: String?
    var genre_ids: [Int]
    var id: Int
    var original_language: String
    var original_title: String
    var overview: String
    var popularity: Double
    var poster_path: String
    var release_date: String
    var title: String
    var video: Bool
    var vote_average: Double
    var vote_count: Int
}
