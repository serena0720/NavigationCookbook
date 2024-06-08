//
//  NavigationFeature.swift
//  NavigationCookbook
//
//  Created by Hyun A Song on 6/8/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct NavigationFeature: Reducer {
	@ObservableState
  struct State: Equatable {
    var path = StackState<Path.State>()
    var stackContent = StackContentFeature.State()
  }
  enum Action: Equatable {
    case path(StackAction<Path.State, Path.Action>)
    case stackContent(StackContentFeature.Action)
  }
  
	@Reducer
  struct Path: Reducer {
		@ObservableState
    enum State: Equatable {
      case recipeDetail(RecipeDetailFeature.State)
    }
    enum Action: Equatable {
      case recipeDetail(RecipeDetailFeature.Action)
    }
    var body: some ReducerOf<Self> {
      Scope(state: /State.recipeDetail,
            action: /Action.recipeDetail) {
        RecipeDetailFeature()
      }
    }
  }
  
  var body: some ReducerOf<Self> {
    Scope(state: \.stackContent,
          action: /Action.stackContent) {
      StackContentFeature()
    }
    
    Reduce { state, action in
      switch action {
      case .path(.element(id: _, action: .recipeDetail)):
        return .none
      case .path(.popFrom(id: let id)):
        return .none
      case .path(.push(id: let id, state: let state)):
        return .none
      case .stackContent(_):
        return .none
      }
    }
		.forEach(\.path, action: \.path) {
			Path()
		}
  }
}
