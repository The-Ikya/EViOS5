//
//  DetailViewModel.swift
//  EViOS5
//
//  Created by Mavrik on 10/11/2022.
//

import Foundation

class DetailViewModel : ObservableObject {
	@Published var movie: Movie {
		didSet {
			getMovies()
		}
	}
	@Published var similarMovies = [Movie]()
	
	private let api = Api()
	
	init(movie: Movie) {
		self.movie = movie
		getMovies()
	}
	
	func getMovies() {
		guard let url = api.urlRecommendations(movie: movie.id) else { return }
		
		api.fetch(url: url) { [weak self] response in
			switch response {
			case .success(let data):
				guard let self else { return }
				self.similarMovies = data.results
			case .failure(let error):
				dump(error)
			}
		}
	}
}
