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
  @Bindable var store: StoreOf<RecipeDetailFeature>
  
  var body: some View {
    ZStack {
        Content(
          store: self.store
        )
    }
  }
}

// MARK: - CustomViews
private struct Content: View {
  @Bindable var store: StoreOf<RecipeDetailFeature>
  
  var body: some View {
    ScrollView {
      ViewThatFits(in: .horizontal) {
        wideDetails
        narrowDetails
      }
      .padding()
    }
    .navigationTitle(store.recipe.name)
  }
  
  private var wideDetails: some View {
    VStack(alignment: .leading) {
      HStack(alignment: .top) {
        image
        ingredients
        Spacer()
      }
			relatedRecipes
    }
  }
  
  private var narrowDetails: some View {
    let alignment: HorizontalAlignment = .center
    
    return VStack(alignment: alignment) {
      image
      ingredients
			relatedRecipes
    }
  }
  
  @ViewBuilder
  private var image: some View {
		RecipePhoto(recipe: store.recipe)
        .frame(width: 300, height: 300)
    
  }
  
  private var ingredients: some View {
    let padding = EdgeInsets(top: 16, leading: 0, bottom: 8, trailing: 0)
    
    return VStack(alignment: .leading) {
      Text("Ingredients")
        .font(.headline)
        .padding(padding)
      VStack(alignment: .leading) {
				ForEach(store.recipe.ingredients) { ingredient in
            Text(ingredient.description)
          }
      }
    }
    .frame(minWidth: 300, alignment: .leading)
  }
  
  @ViewBuilder
  var relatedRecipes: some View {
    let padding = EdgeInsets(top: 16, leading: 0, bottom: 8, trailing: 0)
    
		if !store.recipe.related.isEmpty {
      VStack(alignment: .leading) {
        Text("Related Recipes")
          .font(.headline)
          .padding(padding)
        LazyVGrid(columns: columns, alignment: .leading) {
					let relatedRecipes = getRelatedRecipes(with: store.recipes, for: store.recipe)
					ForEach(relatedRecipes) { relatedRecipe in
						NavigationLink(state: NavigationFeature.Path.State.recipeDetail(.init(recipe: relatedRecipe))) {
							RecipeTile(recipe: relatedRecipe)
						}
					}
        }
      }
    } else {
      EmptyView()
    }
  }
	
	func getRelatedRecipes(with recipes: [Recipe], for recipe: Recipe) -> [Recipe] {
		recipes
				.filter { recipe.related.contains($0.id) }
				.sorted { $0.name < $1.name }
	}
  
  private var columns: [GridItem] {
    [ GridItem(.adaptive(minimum: 120, maximum: 120)) ]
  }
}

// MARK: - Preview
#Preview {
  return Group {
		RecipeDetailView(store: Store(initialState: RecipeDetailFeature.State(recipe: .mock), reducer: {
      RecipeDetailFeature()
        ._printChanges()
    }))
  }
}
