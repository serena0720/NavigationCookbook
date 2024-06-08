//
//  NavigationView.swift
//  NavigationCookbook
//
//  Created by Hyun A Song on 6/8/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct NavigationView: View {
  @Binding var store: StoreOf<NavigationFeature>
  
  var body: some View {
    NavigationStackStore(self.store.scope(state: \.path, action: { .path($0) })) {
      StackContentView(store: Store(
        initialState: StackContentFeature.State(),
        reducer: {
          StackContentFeature()
        }))
    } destination: { state in
    }
    
  }
}

#Preview {
  NavigationView(store: Store(initialState: NavigationFeature.State(), reducer: {
    NavigationFeature()
  }))
}
