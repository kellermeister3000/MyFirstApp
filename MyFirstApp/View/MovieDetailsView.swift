//
//  MovieDetailsView.swift
//  MyFirstApp
//
//  Created by Philip Keller on 3/1/23.
//

import SwiftUI

struct MovieDetailsView: View {
    
    let movie: Movie
    
    @State var cast : [MovieCastMember] = []
    
    var body: some View {
        List {
            Section {
                VStack {
                    AsyncImage(url: movie.posterURL) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Text(movie .overview)
                }
                .padding()
            }
        
            ForEach(cast) { cast in
                VStack(alignment: .leading) {
                    Text(cast.character)
                    Text(cast.name)
                        .font(.caption)
                }
            }
        }
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            do {
                let service = CastService()
                cast = try await service.getCast(of: movie)
            } catch {}
        }
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(movie: .mock, cast: .mock)
    }
}
