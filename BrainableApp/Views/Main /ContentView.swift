//
//  ContentView.swift
//  BrainableApp
//
//  Created by Vu Tran Hoang on 11/08/2023.
//

import SwiftUI

struct ContentView: View {
    @State var toMain:Bool = false;
    var body: some View {
        if (!toMain) {
            WelcomeView(toMain: $toMain)
        }
        else {
            MainView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
