//
//  StackContentFeature.swift
//  NavigationCookbook
//
//  Created by Hyun A Song on 6/8/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct StackContentFeature: Reducer {
  @ObservableState
  struct State: Equatable {
		var recipes: [Recipe]
		
		init(recipes: [Recipe] = BuiltInRecipes.examples) {
			self.recipes = recipes
		}
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
//        state.recipesByCategory[category] = DataManager.findRecipes(at: BuiltInRecipes.examples, in: category)
        return .none
      case let .selectRecipe(recipe):
//        state.recipePath.append(recipe)
        return .none
      case .showRecipeOfTheDay:
//        let recipeOfTheDay = DataManager.findRecipeOfTheDay(at: BuiltInRecipes.examples)
//        state.recipePath = [recipeOfTheDay]
        
        return .none
      case .showCategories:
//        state.recipePath.removeAll()
        return.none
      }
    }
  }
}
