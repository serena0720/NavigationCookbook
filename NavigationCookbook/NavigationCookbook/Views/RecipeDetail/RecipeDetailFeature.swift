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
    var recipe: Recipe?
    var alert: AlertState<Action>?
  }
  
  enum Action: Equatable {
    case selectRecipe(Recipe)
    case showAlert(String)
    case dissmissAlert
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case let .selectRecipe(recipe):
        state.recipe = recipe
        return .none
      case let .showAlert(message):
        state.alert = AlertState(title: TextState(message))
        return .none
      case .dissmissAlert:
        state.alert = nil
        return .none
      }
    }
  }
}
