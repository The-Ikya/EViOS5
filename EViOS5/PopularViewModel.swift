//
//  PopularViewModel.swift
//  EViOS5
//
//  Created by Mavrik on 10/11/2022.
//

import Combine
import Foundation

class PopularViewModel : ObservableObject {
	@Published var movies = [Movie]()
	
	var currentPage = 1
	
	private let api = Api()
	private var canLoadMorePages = true
	
	init() {
		getMovies()
	}
	
	func getMovies() {
		guard canLoadMorePages else { return }
		guard let url = api.urlNowPlaying() else { return }
		
		api.fetch(url: url) { [weak self] response in
			switch response {
			case .success(let data):
				guard let self else { return }
				if self.currentPage == data.totalPages {
					self.canLoadMorePages = false
				}
				self.movies.append(contentsOf: data.results)
			case .failure(let error):
				dump(error)
			}
		}
	}
}
