/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 A photo view for a given recipe, displaying the recipe's image or a placeholder.
 */

import SwiftUI

struct RecipePhoto: View {
  var url: String?
  
  var body: some View {
    if let url {
      AsyncImage(url: URL(string: url)) { phase in
        phase.image?.resizable()
          .aspectRatio(contentMode: .fit)
      }
    } else {
      ZStack {
        Rectangle()
          .fill(.tertiary)
        Image(systemName: "camera")
          .font(.system(size: 64))
          .foregroundStyle(.secondary)
      }
    }
  }
}

#Preview {
  RecipePhoto(url: nil)
}
