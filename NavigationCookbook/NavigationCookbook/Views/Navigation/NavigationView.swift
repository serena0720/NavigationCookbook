//
//  NavigationView.swift
//  NavigationCookbook
//
//  Created by Hyun A Song on 6/8/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

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

#Preview {
  NavigationView(store: Store(initialState: NavigationFeature.State(), reducer: {
    NavigationFeature()
  }))
}
