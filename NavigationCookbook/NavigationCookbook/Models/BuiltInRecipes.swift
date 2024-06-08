//
//  BuiltInRecipes.swift
//  NavigationCookbook
//
//  Created by Hyun A Song on 6/8/24.
//  Copyright © 2024 Apple. All rights reserved.
//

struct BuiltInRecipes {
  static let examples: [Recipe] = {
    let applePie = """
        ¾ cup white sugar
        2 Tbsp. all-purpose flour
        ½ tsp. ground cinnamon
        ¼ tsp. ground nutmeg
        ½ tsp. lemon zest
        7 cups thinly sliced apples
        2 tsp. lemon juice
        1 Tbsp. butter
        1 recipe pastry for a 9-inch double-crust pie
        4 Tbsp. milk
        """

    let pieCrust = """
        2 ½ cups all-purpose flour
        1 Tbsp. powdered sugar
        1 tsp. sea salt
        ½ cup shortening
        ½ cup butter (cold, cut into small pieces)
        ⅓ cup cold water (plus more as needed)
        """
    
    var recipes = [
      "Apple Pie": Recipe(
        name: "Apple Pie", category: .dessert,
        ingredients: applePie.ingredients),
      "Baklava": Recipe(
        name: "Baklava", category: .dessert,
        ingredients: []),
      "Bolo de Rolo": Recipe(
        name: "Bolo de Rolo", category: .dessert,
        ingredients: []),
      "Chocolate Crackles": Recipe(
        name: "Chocolate Crackles", category: .dessert,
        ingredients: []),
      "Crème Brûlée": Recipe(
        name: "Crème Brûlée", category: .dessert,
        ingredients: []),
      "Fruit Pie Filling": Recipe(
        name: "Fruit Pie Filling", category: .dessert,
        ingredients: []),
      "Kanom Thong Ek": Recipe(
        name: "Kanom Thong Ek", category: .dessert,
        ingredients: []),
      "Mochi": Recipe(
        name: "Mochi", category: .dessert,
        ingredients: []),
      "Marzipan": Recipe(
        name: "Marzipan", category: .dessert,
        ingredients: []),
      "Pie Crust": Recipe(
        name: "Pie Crust", category: .dessert,
        ingredients: pieCrust.ingredients),
      "Shortbread Biscuits": Recipe(
        name: "Shortbread Biscuits", category: .dessert,
        ingredients: []),
      "Tiramisu": Recipe(
        name: "Tiramisu", category: .dessert,
        ingredients: []),
      "Crêpe": Recipe(
        name: "Crêpe", category: .pancake,
        ingredients: []),
      "Jianbing": Recipe(
        name: "Jianbing", category: .pancake,
        ingredients: []),
      "American": Recipe(
        name: "American", category: .pancake,
        ingredients: []),
      "Dosa": Recipe(
        name: "Dosa", category: .pancake,
        ingredients: []),
      "Injera": Recipe(
        name: "Injera", category: .pancake,
        ingredients: []),
      "Acar": Recipe(
        name: "Acar", category: .salad,
        ingredients: []),
      "Ambrosia": Recipe(
        name: "Ambrosia", category: .salad,
        ingredients: []),
      "Bok L'hong": Recipe(
        name: "Bok L'hong", category: .salad,
        ingredients: []),
      "Caprese": Recipe(
        name: "Caprese", category: .salad,
        ingredients: []),
      "Ceviche": Recipe(
        name: "Ceviche", category: .salad,
        ingredients: []),
      "Çoban Salatası": Recipe(
        name: "Çoban Salatası", category: .salad,
        ingredients: []),
      "Fiambre": Recipe(
        name: "Fiambre", category: .salad,
        ingredients: []),
      "Kachumbari": Recipe(
        name: "Kachumbari", category: .salad,
        ingredients: []),
      "Niçoise": Recipe(
        name: "Niçoise", category: .salad,
        ingredients: [])
    ]
    
    recipes["Apple Pie"]!.related = [
      recipes["Pie Crust"]!.id,
      recipes["Fruit Pie Filling"]!.id
    ]
    
    recipes["Pie Crust"]!.related = [recipes["Fruit Pie Filling"]!.id]
    recipes["Fruit Pie Filling"]!.related = [recipes["Pie Crust"]!.id]
    
    return Array(recipes.values)
  }()
}
