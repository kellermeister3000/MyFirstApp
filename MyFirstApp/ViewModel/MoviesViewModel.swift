//
//  MoviesViewModel.swift
//  MyFirstApp
//
//  Created by Philip Keller on 3/1/23.
//

import Foundation

@MainActor
class MoviesViewModel: ObservableObject {
    enum State {
        case loading
        case loaded(movies: [Movie])
        case error(Error)
    }
    
    @Published var state: State = .loaded(movies: .mock)
    
    let service = MoviesService()
    
    func loadMovies() async {
        do {
            let movies = try await service.getMoviesFromApi()
            state = .loaded(movies: movies)
        } catch {
            state = .error(error)
        }
        
    }
}
