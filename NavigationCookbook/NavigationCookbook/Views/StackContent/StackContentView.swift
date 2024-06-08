//
//  StackContentView.swift
//  NavigationCookbook
//
//  Created by Hyun A Song on 6/8/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct StackContentView: View {
  let store: Store<StackContentFeature.State, StackContentFeature.Action>
  
  var body: some View {
    List(Category.allCases) { category in
      Section {
        ForEach(store.recipesByCategory[category] ?? []) { recipe in
          NavigationLink(recipe.name, value: recipe)
        }
      } header: {
        Text(category.localizedName)
      }
    }
    .navigationTitle("Categories")
    .navigationDestination(for: Recipe.self) { relatedRecipe in
      NavigationLink(value: relatedRecipe) {
        RecipeTile(recipe: relatedRecipe)
      }
      .buttonStyle(.plain)
    }
  }
}

#Preview {
  StackContentView(store: Store(initialState: StackContentFeature.State(), reducer: {
    StackContentFeature()
      ._printChanges()
  }))
}
