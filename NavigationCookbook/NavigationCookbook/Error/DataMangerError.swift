//
//  DataMangerError.swift
//  NavigationCookbook
//
//  Created by Hyun A Song on 6/8/24.
//  Copyright © 2024 Apple. All rights reserved.
//

enum DataMangerError: Error {
  case fileNotFound
  
  var discription: String {
    switch self {
    case .fileNotFound:
      "Data 파일을 찾을 수 없습니다."
    }
  }
}
