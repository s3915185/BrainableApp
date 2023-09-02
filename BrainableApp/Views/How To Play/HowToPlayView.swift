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
                                        Spacer()
                                        Image("instruction0")
                                            .resizable()
                                            .frame(width: 300, height: 600)
                                    }
                                }
                                Spacer(minLength: 40)
                            }
                            HStack {
                                HStack {
                                    Spacer()
                                    VStack {
                                        Spacer()
                                        Image("instruction1")
                                            .resizable()
                                            .frame(width: 300, height: 600)
                                    }
                                }
                                Spacer(minLength: 40)
                            }
                            HStack {
                                HStack {
                                    Spacer()
                                    VStack {
                                        Spacer()
                                        Image("instruction2")
                                            .resizable()
                                            .frame(width: 300, height: 600)
                                    }
                                }
                                Spacer(minLength: 40)
                            }
                            HStack {
                                HStack {
                                    Spacer()
                                    VStack {
                                        Spacer()
                                        Image("instruction3")
                                            .resizable()
                                            .frame(width: 300, height: 600)
                                    }
                                }
                                Spacer(minLength: 40)
                            }
                            HStack {
                                HStack {
                                    Spacer()
                                    VStack {
                                        Spacer()
                                        Image("instruction4")
                                            .resizable()
                                            .frame(width: 300, height: 600)
                                    }
                                }
                                Spacer(minLength: 40)
                            }
                            HStack {
                                HStack {
                                    Spacer()
                                    VStack {
                                        Spacer()
                                        Image("instruction5")
                                            .resizable()
                                            .frame(width: 300, height: 600)
                                    }
                                }
                                Spacer(minLength: 40)
                            }
                            HStack {
                                HStack {
                                    Spacer()
                                    VStack {
                                        Spacer()
                                        Image("instruction6")
                                            .resizable()
                                            .frame(width: 300, height: 600)
                                    }
                                }
                                Spacer(minLength: 40)
                            }
                            HStack {
                                HStack {
                                    Spacer()
                                    VStack {
                                        Spacer()
                                        Image("instruction7")
                                            .resizable()
                                            .frame(width: 900, height: 600)
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
