//
//  StackContentFeature.swift
//  NavigationCookbook
//
//  Created by Hyun A Song on 6/8/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct StackContentFeature: Reducer {
  struct State: Equatable {
    var recipePath: [Recipe] = []
    var recipesByCategory: [Category: [Recipe]] = [:]
    var recipeOfTheDay: Recipe?
  }
  enum Action: Equatable {
    case selectCategory(Category)
    case selectRecipe(Recipe)
    case showRecipeOfTheDay
    case showCategories
  }
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case let .selectCategory(category):
        state.recipesByCategory[category] = DataManager.findRecipes(in: category)
        return .none
      case let .selectRecipe(recipe):
        state.recipePath.append(recipe)
        return .none
      case .showRecipeOfTheDay:
        if let recipeOfTheDay = DataManager.recipeOfTheDay {
          state.recipePath = [recipeOfTheDay]
        }
        return .none
      case .showCategories:
        state.recipePath.removeAll()
        return.none
      }
    }
  }
}
