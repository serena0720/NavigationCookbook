//
//  DataMangerError.swift
//  NavigationCookbook
//
//  Created by Hyun A Song on 6/8/24.
//  Copyright © 2024 Apple. All rights reserved.
//

enum DataMangerError: Error {
  case failToLoad
  case fileNotFound
  
  var discription: String {
    switch self {
    case .failToLoad:
      "Data 로딩에 실패했습니다."
    case .fileNotFound:
      "Data 파일을 찾을 수 없습니다."
    }
  }
}
