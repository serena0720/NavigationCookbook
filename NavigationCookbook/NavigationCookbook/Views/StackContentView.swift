/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 The content view for the navigation stack view experience.
 */

import SwiftUI
import ComposableArchitecture

// MARK: - StackContentReducer
struct StackContentFeature: Reducer {
  struct State: Equatable {
    
  }
  enum Action: Equatable {
    
  }
  var body: some ReducerOf<Self> {
    
  }
}

// MARK: - StackContentView
struct StackContentView: View {
  var body: some View {
    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
  }
}

// MARK: - CustomViews

// MARK: - Preview
#Preview {
  StackContentView()
}

//struct StackContentView: View {
//  @EnvironmentObject private var navigationModel: NavigationModel
//  var dataModel = DataModel.shared
//  
//  var body: some View {
//    NavigationStack(path: $navigationModel.recipePath) {
//      List(Category.allCases) { category in
//        Section {
//          ForEach(dataModel.recipes(in: category)) { recipe in
//            NavigationLink(recipe.name, value: recipe)
//          }
//        } header: {
//          Text(category.localizedName)
//        }
//      }
//      .navigationTitle("Categories")
//      .navigationDestination(for: Recipe.self) { relatedRecipe in
//        NavigationLink(value: relatedRecipe) {
//          RecipeTile(recipe: relatedRecipe)
//        }
//        .buttonStyle(.plain)
//      }
//    }
//  }
//  
//  func showRecipeOfTheDay() {
//    navigationModel.recipePath = [dataModel.recipeOfTheDay]
//  }
//  
//  func showCategories() {
//    navigationModel.recipePath.removeAll()
//  }
//}

struct StackContentView_Previews: PreviewProvider {
  static var previews: some View {
    StackContentView(dataModel: .shared)
      .environmentObject(NavigationModel())
    
    StackContentView(dataModel: .shared)
      .environmentObject(NavigationModel(
        selectedCategory: .dessert,
        recipePath: [.mock]))
  }
}
