//
//  RecipeDetailFeature.swift
//  NavigationCookbook
//
//  Created by Hyun A Song on 6/8/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct RecipeDetailFeature: Reducer {
  struct State: Equatable {
    var recipe: Recipe?
    var alert: AlertState<Action>?
  }
  
  enum Action: Equatable {
    case selectRecipe(Recipe)
    case delegate(Delegate)
    case showAlert(String)
    case dissmissAlert
    
    enum Delegate: Equatable {
      case deleteRecipe(Recipe)
    }
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case let .selectRecipe(recipe):
        state.recipe = recipe
        return .none
      case .delegate(_):
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
