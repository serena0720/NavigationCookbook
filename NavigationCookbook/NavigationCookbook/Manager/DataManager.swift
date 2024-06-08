//
//  DataManager.swift
//  NavigationCookbook
//
//  Created by Hyun A Song on 6/8/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import ComposableArchitecture
import Foundation

struct DataManager {
  var load: @Sendable (URL) throws -> Data
}

extension DataManager: DependencyKey {
  static let liveValue = Self(
    load: { url in try Data(contentsOf: url) }
  )
  
  static let failToLoad = Self(
    load: { _ in
      throw DataMangerError.failToLoad
    }
  )
  
  static func findRecipeOfTheDay(at recipes: [Recipe]) -> Recipe {
    recipes.first!
  }
  
  static func findRecipes(at recipes: [Recipe], in category: Category?) -> [Recipe] {
    recipes
      .filter { $0.category == category }
      .sorted { $0.name < $1.name }
  }
  
  static func mock(initialData: Data? = nil) -> Self {
    let data = LockIsolated(initialData)
    return Self(
      load: { _ in
        guard let data = data.value
        else {
          throw DataMangerError.fileNotFound
        }
        return data
      }
    )
  }
}

extension DependencyValues {
  var dataManager: DataManager {
    get { self[DataManager.self] }
    set { self[DataManager.self] = newValue }
  }
}
