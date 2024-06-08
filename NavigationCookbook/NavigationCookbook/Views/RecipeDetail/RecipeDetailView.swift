//
//  RecipeDetailView.swift
//  NavigationCookbook
//
//  Created by Hyun A Song on 6/8/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct RecipeDetailView: View {
  typealias RecipeState = RecipeDetailFeature.State
  typealias RecipeAction = RecipeDetailFeature.Action
  
  let store: StoreOf<RecipeDetailFeature>
  
  var body: some View {
    ZStack {
      if store.recipe != nil {
        Content(
          store: self.store
        )
      } else {
        Text("Choose a recipe")
          .onAppear {
            store.send(.showAlert(RecipeError.noneRecipe.description))
          }
          .navigationTitle("")
      }
    }
  }
}

// MARK: - CustomViews
private struct Content: View {
  typealias RecipeState = RecipeDetailFeature.State
  typealias RecipeAction = RecipeDetailFeature.Action
  
  let store: Store<RecipeState, RecipeAction>
  
  var body: some View {
    ScrollView {
      ViewThatFits(in: .horizontal) {
        wideDetails
        narrowDetails
      }
      .padding()
    }
    .navigationTitle(store.recipe?.name ?? "무제")
  }
  
  private var wideDetails: some View {
    VStack(alignment: .leading) {
      HStack(alignment: .top) {
        image
        ingredients
        Spacer()
      }
    }
  }
  
  private var narrowDetails: some View {
    let alignment: HorizontalAlignment = .center
    
    return VStack(alignment: alignment) {
      image
      ingredients
    }
  }
  
  @ViewBuilder
  private var image: some View {
    if let recipe = store.recipe {
      RecipePhoto(recipe: recipe)
        .frame(width: 300, height: 300)
    } else {
      EmptyView()
    }
  }
  
  private var ingredients: some View {
    let padding = EdgeInsets(top: 16, leading: 0, bottom: 8, trailing: 0)
    
    return VStack(alignment: .leading) {
      Text("Ingredients")
        .font(.headline)
        .padding(padding)
      VStack(alignment: .leading) {
        if let recipe = store.recipe {
          ForEach(recipe.ingredients) { ingredient in
            Text(ingredient.description)
          }
        }
      }
    }
    .frame(minWidth: 300, alignment: .leading)
  }
  
  @ViewBuilder
  var relatedRecipes: some View {
    let padding = EdgeInsets(top: 16, leading: 0, bottom: 8, trailing: 0)
    
    if let recipe = store.recipe,
       !recipe.related.isEmpty {
      VStack(alignment: .leading) {
        Text("Related Recipes")
          .font(.headline)
          .padding(padding)
        LazyVGrid(columns: columns, alignment: .leading) {
        }
      }
    } else {
      EmptyView()
    }
  }
  
  private var columns: [GridItem] {
    [ GridItem(.adaptive(minimum: 120, maximum: 120)) ]
  }
}

// MARK: - Preview
#Preview {
  return Group {
    RecipeDetailView(store: Store(initialState: RecipeDetailFeature.State(), reducer: {
      RecipeDetailFeature()
        ._printChanges()
    }))
  }
}
