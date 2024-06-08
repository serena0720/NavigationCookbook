//
//  Navigation.swift
//  NavigationCookbook
//
//  Created by Hyun A Song on 6/8/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

// MARK: - NavigationReducer
struct NavigationFeature: Reducer {
  struct State: Equatable {
    var path = StackState<Path.State>()
    var stackContent = StackContentFeature.State()
  }
  enum Action: Equatable {
    case path(StackAction<Path.State, Path.Action>)
    case stackContent(StackContentFeature.Action)
  }
  
  struct Path: Reducer {
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
      case .path(.element(id: _, action: .recipeDetail(.delegate(.deleteRecipe(<#T##Recipe#>)))))
      }
    }
  }
}

// MARK: - NavigationView
struct NavigationView: View {
  let store: StoreOf<NavigationFeature>
  
  var body: some View {
    NavigationStackStore(self.store.scope(state: \.path, action: { .path($0) })) {
      StackContentView()
    } destination: { state in
      switch state {
      case .recipeDetail:
        CaseLet(/NavigationFeature.Path.State.recipeDetail(),
                 action: NavigationFeature.Path.Action.recipeDetail(),
                 then: RecipeDetail.init(store:))
      }
    }

  }
}

// MARK: - CustomViews

// MARK: - Preview
#Preview {
  NavigationView()
}
