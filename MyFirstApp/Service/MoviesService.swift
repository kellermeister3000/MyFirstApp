//
//  MoviesService.swift
//  MyFirstApp
//
//  Created by Philip Keller on 3/1/23.
//

import Foundation

class MoviesService {
    
    let apiKey = "f4d69b48f73adedaf5748434948ae61c"
    
    func getMoviesFromApi() async throws -> [Movie] {
        let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)")!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
            
        let decoded = try decoder.decode(MovieResponse.self, from: data)
        
        return decoded.results
    }
}
