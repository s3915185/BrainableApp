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
                HStack {
                    Spacer(minLength: 40)
                    ScrollView(.horizontal) {
                        HStack {
                            HStack {
                                HStack {
                                    VStack {
                                        Spacer()
                                        Text("instruction-0")
                                            .frame(width: 260)
                                        Image("instruction0")
                                            .resizable()
                                            .frame(width: 300, height: 700)
                                            .zIndex(-1)
                                    }
                                }
                                Spacer(minLength: 40)
                            }
                            HStack {
                                HStack {
                                    VStack {
                                        Spacer()

                                        Text("instruction-1")
                                            .frame(width: 260)
                                        Image("instruction1")
                                            .resizable()
                                            .frame(width: 300, height: 700)
                                            .zIndex(-1)
                                    }
                                }
                                Spacer(minLength: 40)
                            }
                            HStack {
                                HStack {
                                    VStack {
                                        Spacer()

                                        Text("instruction-2")
                                            .frame(width: 260)
                                        Image("instruction2")
                                            .resizable()
                                            .frame(width: 300, height: 700)
                                            .zIndex(-1)
                                    }
                                }
                                Spacer(minLength: 40)
                            }
                            HStack {
                                HStack {
                                    VStack {
                                        Spacer()

                                        Text("instruction-3")
                                            .frame(width: 260)
                                        Image("instruction3")
                                            .resizable()
                                            .frame(width: 300, height: 700)
                                            .zIndex(-1)
                                    }
                                }
                                Spacer(minLength: 40)
                            }
                            HStack {
                                HStack {
                                    VStack {
                                        Spacer()

                                        Text("instruction-4")
                                            .frame(width: 260)
                                        Image("instruction4")
                                            .resizable()
                                            .frame(width: 300, height: 700)
                                            .zIndex(-1)
                                    }
                                }
                                Spacer(minLength: 40)
                            }
                        }
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
