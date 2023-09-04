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
                                    Spacer()
                                    VStack {
                                        Text("To begin with all cells are unknown. I will mark a known black cell with a black square (no surprises there!) and any known white cells with a dot.")
                                            .frame(width: 260)
                                            .offset(y: 31)
                                        Image("instruction0")
                                            .resizable()
                                            .frame(width: 300, height: 600)
                                            .zIndex(-1)
                                    }
                                }
                                Spacer(minLength: 40)
                            }
                            HStack {
                                HStack {
                                    Spacer()
                                    VStack {
                                        Text("1. First find any solid lines. The 0 means there are no black cells in that row, so we mark every cell in the row with a dot (they are known white cells).")
                                            .frame(width: 260)
                                        Image("instruction1")
                                            .resizable()
                                            .frame(width: 320, height: 540)
                                    }
                                }
                                Spacer(minLength: 40)
                            }
                            HStack {
                                HStack {
                                    Spacer()
                                    VStack {
                                        Text("2. The 5 means that every cell in the row is black, so we color them all in.")
                                            .frame(width: 260)
                                            .offset(y: -23)
                                        Image("instruction2")
                                            .resizable()
                                            .frame(width: 320, height: 540)
                                            .offset(y: 22)
                                    }
                                }
                                Spacer(minLength: 40)
                            }
                            HStack {
                                HStack {
                                    Spacer()
                                    VStack {
                                        Text("3. The 2 / 2 row will be a complete row. There is only one possible way of filling it in – a block of 2 black followed by one white and then another block of two black.")
                                            .frame(width: 260)
                                        Image("instruction3")
                                            .resizable()
                                            .frame(width: 320, height: 540)
                                    }
                                }
                                Spacer(minLength: 40)
                            }
                            HStack {
                                HStack {
                                    Spacer()
                                    VStack {
                                        Text("4. First column has completed its block of two black. That means every other cell in this column must be white. So we can fill in the remaining cells with a dot.")
                                            .frame(width: 260)
                                        Image("instruction4")
                                            .resizable()
                                            .frame(width: 320, height: 540)
                                    }
                                }
                                Spacer(minLength: 40)
                            }
                            HStack {
                                HStack {
                                    Spacer()
                                    VStack {
                                        Text("5. Then I start from the bottom to see the bottom-most these blocks can go.")
                                            .frame(width: 260)
                                            .offset(y: -23)
                                        Image("instruction5")
                                            .resizable()
                                            .frame(width: 320, height: 540)
                                            .offset(y: 22)
                                    }
                                }
                                Spacer(minLength: 40)
                            }
                            HStack {
                                HStack {
                                    Spacer()
                                    VStack {
                                        Text("6. Where the same blocks overlap, we know that must be a black cell, so we color those overlaps black.")
                                            .frame(width: 260)
                                            .offset(y: -10)
                                        Image("instruction6")
                                            .resizable()
                                            .frame(width: 320, height: 540)
                                            .offset(y: 10)
                                    }
                                }
                                Spacer(minLength: 40)
                            }
                            HStack {
                                HStack {
                                    Spacer()
                                    VStack {
                                        HStack {
                                            Text("7. Then we can continue with the overlap tactic over again...")
                                                .frame(width: 260)
                                                .offset(y: -33)
                                            Spacer()
                                        }
                                        
                                        Image("instruction7")
                                            .resizable()
                                            .frame(width: 960, height: 540)
                                            .offset(y: 32)
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
