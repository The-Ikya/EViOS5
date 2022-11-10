//
//  SearchViewModel.swift
//  EViOS5
//
//  Created by Mavrik on 10/11/2022.
//

import Combine
import Foundation

class SearchViewModel : ObservableObject {
	@Published var movies = [Movie]()
	
	var currentPage = 1
	var currentSearchStr = ""
	
	private let api = Api()
	private var canLoadMorePages = true
	
	func getMovies() {
		guard canLoadMorePages else { return }
		guard let url = api.urlSearchMovies(search: currentSearchStr) else { return }
		
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
