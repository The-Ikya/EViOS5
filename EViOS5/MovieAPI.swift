//
//  MovieAPI.swift
//  EViOS5
//
//  Created by Mavrik on 10/11/2022.
//

import Foundation
import Alamofire
import Network


class Api {
	static let baseImageURL = "https://image.tmdb.org/t/p/w500"
	private let monitor = NWPathMonitor()
	var currentPage = 1 {
		didSet {
			if let items = urlComponents.queryItems{
				urlComponents.queryItems = items.filter{
					$0.name != "page"
				}
			}
			urlComponents.queryItems?.append(URLQueryItem(name: "page", value: "\(currentPage)"))
		}
	}
	private var urlComponents = URLComponents()
	
	init() {
		urlComponents.scheme = "https"
		urlComponents.host = "api.themoviedb.org"
		urlComponents.path = "/3/movie/now_playing"
		urlComponents.queryItems = [
			URLQueryItem(name: "api_key", value: "b2168bae3a2c67509eb6b97572f521c2"),
			URLQueryItem(name: "language", value: "fr"),
			URLQueryItem(name: "page", value: "\(currentPage)")
		]
	}
	
	
	
	//MARK: - Connection Network
	
	func isNetwork(connected: @escaping () -> Void, disconnected: @escaping () -> Void) {
		monitor.pathUpdateHandler = { path in
			if path.status == .satisfied {
				connected()
			}
			else {
				disconnected()
			}
		}
		monitor.start(queue: .global())
	}
	
	func urlNowPlaying() -> URL?{
		urlComponents.path = "/3/movie/now_playing"
		//        filterQuery()
		return urlComponents.url
		
	}
	
	func urlSearchMovies(search: String) -> URL?{
		urlComponents.path = "/3/search/movie"
		filterQuery()
		urlComponents.queryItems?.append(URLQueryItem(name: "query", value: "\(search)"))
		return urlComponents.url
	}
	
	func urlRecommendations(movie: Int) -> URL?{
		//        filterQuery()
		urlComponents.path = "/3/movie/\(movie)/similar"
		return urlComponents.url
	}
	
	private func filterQuery(){
		if let items = urlComponents.queryItems{
			urlComponents.queryItems = items.filter{
				$0.name != "query"
			}
		}
	}
}
// MARK: - Extenssion Api

extension Api {
	func fetch(url: URL, handler: @escaping (Result<MovieModel, AFError>) -> Void) {
		isNetwork(
			connected: {
				AF.request(url).responseDecodable(of: MovieModel.self) {
					handler($0.result)
				}
			}, disconnected: {
				print("Not connected")
			})
	}
}

