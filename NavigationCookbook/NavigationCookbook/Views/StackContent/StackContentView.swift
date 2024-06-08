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
  var body: some View {
    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
  }
}

#Preview {
  StackContentView(dataModel: .shared)
    .environmentObject(NavigationModel())
  
  StackContentView(dataModel: .shared)
    .environmentObject(NavigationModel(
      selectedCategory: .dessert,
      recipePath: [.mock]))
}

struct StackContentView: View {
  @EnvironmentObject private var navigationModel: NavigationModel
  var dataModel = DataModel.shared
  
  var body: some View {
    NavigationStack(path: $navigationModel.recipePath) {
      List(Category.allCases) { category in
        Section {
          ForEach(dataModel.recipes(in: category)) { recipe in
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
  
  func showRecipeOfTheDay() {
    navigationModel.recipePath = [dataModel.recipeOfTheDay]
  }
  
  func showCategories() {
    navigationModel.recipePath.removeAll()
  }
}

struct StackContentView_Previews: PreviewProvider {
  static var previews: some View {

  }
}
