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
                                        Text("instruction-0")
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
                                        Text("instruction-1")
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
                                        Text("instruction-2")
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
                                        Text("instruction-3")
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
                                        Text("instruction-4")
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
                                        Text("instruction-5")
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
                                        Text("instruction-6")
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
                                            Text("instruction-7")
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
