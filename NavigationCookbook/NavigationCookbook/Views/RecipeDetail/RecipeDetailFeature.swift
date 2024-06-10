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
		var allRecipes: [Recipe]
    var alert: AlertState<Action.Alert>?
    var imageURLString: String?
		var relatedRecipes: [Recipe]
    @Presents
    var destination: Destination.State?
		
		init(
			recipe: Recipe,
			allRecipes: [Recipe] = BuiltInRecipes.examples,
			alert: AlertState<Action.Alert>? = nil,
			imageURLString: String? = nil,
			relatedRecipes: [Recipe] = []
		) {
			self.recipe = recipe
			self.allRecipes = allRecipes
			self.alert = alert
      self.imageURLString = imageURLString
			self.relatedRecipes = relatedRecipes
		}
  }
  
  enum Action {
    case onAppear
		case recipeTileTapped(Recipe)
    case getImage(Result<String, Error>)
		case getRelatedRecipes([Recipe], Recipe)
		case setRelatedRecipes([Recipe])
    case destination(PresentationAction<Destination.Action>)

    enum Alert: Equatable {}
  }
  
  struct Destination: Reducer {
    enum State: Equatable {
      case relatedRecipe(RecipeDetailFeature.State)
    }
    
    enum Action {
      case showRelatedRecipe(RecipeDetailFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
      Scope(state: /State.relatedRecipe, action: /Action.showRelatedRecipe) {
        RecipeDetailFeature()
      }
    }
  }
  
  @Dependency(\.imageSearchClient) var imageSearchClient
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        return .run { [state] send in
					await send(.getRelatedRecipes(state.allRecipes, state.recipe))
					
          await send(.getImage(Result<String, Error> {
            try await self.imageSearchClient.getImage(query: state.recipe.name)
          }))
        }
				
			case let .recipeTileTapped(recipe):
        state.destination = .relatedRecipe(RecipeDetailFeature.State(recipe: recipe))
        return .none
        
      case .destination(_):
        return .none
				
      case let .getImage(.success(imageURLString)):
				state.recipe.imageURLString = imageURLString
        state.imageURLString = imageURLString
        return .none
				
      case let .getImage(.failure(error)):
				print(error)
        return .none
				
			case let .getRelatedRecipes(recipes, recipe):
				return .run { send in
					var relatedRecipes = recipes
						.filter { recipe.related.contains($0.id) }
						.sorted { $0.name < $1.name }
					
					for (index, recipe) in relatedRecipes.enumerated() {
						let imageURLString = try? await self.imageSearchClient.getImage(query: recipe.name)
						relatedRecipes[index].imageURLString = imageURLString
					}
					
					await send(.setRelatedRecipes(relatedRecipes))
				}
				
			case let .setRelatedRecipes(relatedRecipes):
				state.relatedRecipes = relatedRecipes
				return .none
      }
    }
    .ifLet(\.$destination, action: /Action.destination) {
      Destination()
    }
  }
}
