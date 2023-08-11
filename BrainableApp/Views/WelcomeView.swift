//
//  WelcomeView.swift
//  BrainableApp
//
//  Created by Vu Tran Hoang on 11/08/2023.
//

import Foundation
import SwiftUI

struct WelcomeView: View {
    @Binding var toMain: Bool
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            VStack{
                Spacer()
                HStack{
                    Text("Swift Left")
                        .foregroundColor(.white)
                    Image(systemName: "arrow.left.to.line")
                        .foregroundColor(.white)
                }
            }
        }
        .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .local)
            .onEnded({ value in
                if value.translation.width < 0 {
                    withAnimation(.easeIn(duration: 1)){
                        toMain = true
                    }
                }
            }))
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(toMain: .constant(false))
    }
}
