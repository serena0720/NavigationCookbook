//
//  ImageSearchClient.swift
//  NavigationCookbook
//
//  Created by YangJoonHyeok on 6/8/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import ComposableArchitecture
import Foundation

@DependencyClient
public struct ImageSearchClient {
	public var getImage: @Sendable (_ query: String) async throws -> String
}

extension ImageSearchClient: DependencyKey {
	public static var liveValue: ImageSearchClient {
		return ImageSearchClient(
			getImage: { query in
				guard let percentEncodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
					throw NSError(domain: "EncodingError", code: -1, userInfo: nil)
				}
				var urlReqeust = URLRequest(url: URL(string: "https://dapi.kakao.com/v2/search/image?query=\(percentEncodedQuery)")!)
				urlReqeust.httpMethod = "GET"
				urlReqeust.allHTTPHeaderFields = [
					"Authorization": "KakaoAK 5363ff2aa13b9956ace377d6a6b06857"
				]
        let (data, _) = try await URLSession.shared.data(for: urlReqeust)
				guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
							let jsonDict = jsonObject as? [String: Any],
							let documents = jsonDict["documents"] as? [[String: Any]],
							let firstDocument = documents.first,
							let imageUrl = firstDocument["image_url"] as? String else {
					throw NSError(domain: "ParsingError", code: -1, userInfo: nil)
				}
				return imageUrl
			}
		)
	}
	
	public static var testValue: ImageSearchClient {
		return ImageSearchClient()
	}
  
  public static var previewValue: ImageSearchClient {
    return ImageSearchClient { query in
      return query
    }
  }
}

extension DependencyValues {
	public var imageSearchClient: ImageSearchClient {
		get { self[ImageSearchClient.self] }
		set { self[ImageSearchClient.self] = newValue }
	}
}
