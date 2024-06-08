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
    WithViewStore(self.store, observe: { ($0) }) { viewStore in
      ZStack {
        if viewStore.recipe != nil {
          Content(
            store: self.store
          )
        } else {
          Text("Choose a recipe")
            .onAppear {
              viewStore.send(.showAlert(RecipeError.noneRecipe.description))
            }
            .navigationTitle("")
        }
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
    WithViewStore(self.store, observe: { ($0) }) { viewStore in
      ScrollView {
        ViewThatFits(in: .horizontal) {
          wideDetails
          narrowDetails
        }
        .padding()
      }
      .navigationTitle(viewStore.recipe?.name ?? "무제")
    }
  }
  
  private var wideDetails: some View {
    WithViewStore(self.store, observe: { ($0) }) { viewStore in
      VStack(alignment: .leading) {
        HStack(alignment: .top) {
          image
          ingredients
          Spacer()
        }
//        relatedRecipes
      }
    }
  }
  
  private var narrowDetails: some View {
    WithViewStore(self.store, observe: { ($0) }) { viewStore in
      let alignment: HorizontalAlignment = .center
      
      return VStack(alignment: alignment) {
        image
        ingredients
//        relatedRecipes
      }
    }
  }
  
  private var image: some View {
    WithViewStore(self.store, observe: { ($0) }) { viewStore in
      if let recipe = viewStore.recipe {
        RecipePhoto(recipe: recipe)
          .frame(width: 300, height: 300)
      }
    }
  }
  
  private var ingredients: some View {
    WithViewStore(self.store, observe: { ($0) }) { viewStore in
      let padding = EdgeInsets(top: 16, leading: 0, bottom: 8, trailing: 0)
      VStack(alignment: .leading) {
        Text("Ingredients")
          .font(.headline)
          .padding(padding)
        VStack(alignment: .leading) {
          if let recipe = viewStore.recipe {
            ForEach(recipe.ingredients) { ingredient in
              Text(ingredient.description)
            }
          }
        }
      }
      .frame(minWidth: 300, alignment: .leading)
    }
  }
  
  var relatedRecipes: some View {
    WithViewStore(self.store, observe: { ($0) }) { viewStore in
      let padding = EdgeInsets(top: 16, leading: 0, bottom: 8, trailing: 0)
      
      if let recipe = viewStore.recipe,
        !recipe.related.isEmpty {
        VStack(alignment: .leading) {
          Text("Related Recipes")
            .font(.headline)
            .padding(padding)
          LazyVGrid(columns: columns, alignment: .leading) {
//            let relatedRecipes = recipe
//              .filter { recipe.related.contains($0.id) }
//              .sorted { $0.name < $1.name }
//            ForEach(relatedRecipes) { relatedRecipe in
//              relatedLink(relatedRecipe)
//            }
          }
        }
      }
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
