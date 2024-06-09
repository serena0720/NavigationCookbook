//
//  RecipeDetailFeature.swift
//  NavigationCookbook
//
//  Created by Hyun A Song on 6/8/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct RecipeDetailFeature: Reducer {
  @ObservableState
  struct State: Equatable {
    var recipe: Recipe
		var recipes: [Recipe]
    var alert: AlertState<Action.Alert>?
    var image: String?
		
		init(
			recipe: Recipe,
			recipes: [Recipe] = BuiltInRecipes.examples,
			alert: AlertState<Action.Alert>? = nil,
			image: String? = nil
		) {
			self.recipe = recipe
			self.recipes = recipes
			self.alert = alert
      self.image = image
		}
  }
  
  enum Action {
    case selectRecipe(Recipe)
    case showAlert(String)
    case dismissAlert
    case onAppear
    case getImage(Result<String, Error>)
    
    enum Alert: Equatable {}
  }
  
  @Dependency(\.imageSearchClient) var imageSearchClient
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case let .selectRecipe(recipe):
        state.recipe = recipe
        return .none
      case let .showAlert(message):
        state.alert = AlertState(title: TextState(message))
        return .none
      case .dismissAlert:
        state.alert = nil
        return .none
      case .onAppear:
        return .run { [state] send in
          await send(.getImage(Result<String, Error> {
            try await self.imageSearchClient.getImage(query: state.recipe.name)
          }))
        }
      case let .getImage(.success(image)):
        state.image = image
        return .none
      case let .getImage(.failure(error)):
        return .none
      }
    }
  }
}
