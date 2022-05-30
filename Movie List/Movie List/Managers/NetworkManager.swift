//
//  NetworkManager.swift
//  Movie List
//
//  Created by Al-Amin on 30/5/22.
//

import Foundation

final class NetworkManager: NSObject {
    
    var films: [ResultsInfo] = []
    
    func fetchMovies(completionHandler: @escaping ([ResultsInfo]) -> Void) {
        
        let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=38e61227f85671163c275f9bd95a8803&query=marvel")!
        let urlSession = URLSession.shared
        
        let task = urlSession.dataTask(with: url, completionHandler: { (data, response, error) in
            guard error == nil else {
                NSLog("Error in fetching movies: \(String(describing: error))")
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                NSLog("Error in response, status code: \(String(describing: response))")
                return
            }
            
            if let data = data {
                do {
                    let movieInfo = try JSONDecoder().decode(MovieInfo.self, from: data)
                    completionHandler(movieInfo.results ?? [])
                } catch {
                    NSLog(String(describing: error))
                }
            }
        })
        task.resume()
    }
}
