//
//  HowToPlayView.swift
//  BrainableApp
//
//  Created by Lê Ngọc Trâm on 01/09/2023.
//

import SwiftUI

struct HowToPlayView: View {
    var body: some View {
            VStack {
                ScrollView(.horizontal) {
                    HStack {
                        Image("cup1")
                        Image("cup1")
                        Image("cup1")
                        Image("cup1")
                    }
                    HStack {
                        Image("cup1")
                    }
                    HStack {
                        Image("cup1")
                    }
                }
                Spacer()
            }
    }
}

struct HowToPlayView_Previews: PreviewProvider {
    static var previews: some View {
        HowToPlayView()
    }
}
