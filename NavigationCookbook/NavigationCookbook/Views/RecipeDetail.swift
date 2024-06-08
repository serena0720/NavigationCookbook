/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 A detail view the app uses to display the metadata for a given recipe,
 as well as its related recipes.
 */

import SwiftUI
import ComposableArchitecture

// MARK: - Reducer
struct RecipeDetailFeature: Reducer {
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

// MARK: - RecipeDetailView
struct RecipeDetail<Link: View>: View {
  typealias RecipeState = RecipeDetailFeature.State
  typealias RecipeAction = RecipeDetailFeature.Action
  
  let store: StoreOf<RecipeDetailFeature>
  var relatedLink: (Recipe) -> Link
  
  
  var body: some View {
    WithViewStore(self.store, observe: { ($0) }) { viewStore in
      ZStack {
        if viewStore.recipe != nil {
          Content(
            store: self.store,
            relatedLink: relatedLink
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

private struct Content<Link: View>: View {
  typealias RecipeState = RecipeDetailFeature.State
  typealias RecipeAction = RecipeDetailFeature.Action
  
  let store: Store<RecipeState, RecipeAction>
  var dataModel = DataModel.shared
  var relatedLink: (Recipe) -> Link
  
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
        title
        HStack(alignment: .top) {
          image
          ingredients
          Spacer()
        }
        relatedRecipes
      }
    }
  }
  
  private var narrowDetails: some View {
    WithViewStore(self.store, observe: { ($0) }) { viewStore in
      let alignment: HorizontalAlignment = .center
      
      return VStack(alignment: alignment) {
        title
        image
        ingredients
        relatedRecipes
      }
    }
  }
  
  private var title: some View {
    EmptyView()
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
            let relatedRecipes = dataModel.recipes(relatedTo: recipe)
            ForEach(relatedRecipes) { relatedRecipe in
              relatedLink(relatedRecipe)
            }
          }
        }
      }
    }
  }
  
  private var columns: [GridItem] {
    [ GridItem(.adaptive(minimum: 120, maximum: 120)) ]
  }
}

#Preview {
  return Group {
    RecipeDetail(store: Store(initialState: RecipeDetailFeature.State(), reducer: {
      RecipeDetailFeature()
        ._printChanges()
    }), relatedLink: link)
  }
  
  func link(recipe: Recipe) -> some View {
    EmptyView()
  }
}
