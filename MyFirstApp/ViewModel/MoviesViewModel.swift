//
//  MoviesViewModel.swift
//  MyFirstApp
//
//  Created by Philip Keller on 3/1/23.
//

import Foundation

@MainActor
class MoviesViewModel: ObservableObject {
    
    @Published var movies: [Movie] = []
    
    let service = MoviesService()
    
    func loadMovies() async {
        do {
            movies = try await service.getMoviesFromApi()
        } catch {
            print(error.localizedDescription)
        }
        
    }
}
