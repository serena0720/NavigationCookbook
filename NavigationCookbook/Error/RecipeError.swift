//
//  RecipeError.swift
//  NavigationCookbook
//
//  Created by Hyun A Song on 6/8/24.
//  Copyright © 2024 Apple. All rights reserved.
//

enum RecipeError: Error {
  case noneRecipe
  
  var description: String {
    switch self {
    case .noneRecipe:
      "존재하지 않는 Recipe"
    }
  }
}
