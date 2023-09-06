
/*
 RMIT University Vietnam
 Course: COSC2659 IOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Hoang Vu
 ID: 3915185
 Created date: 15/8/2023
 Last modified: 6/9/2023
 Acknowledgement: Your lectures, tutorials, information linked in the report
 */
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
                                            .frame(width: 280)
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
                                            .frame(width: 280)
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
                                            .frame(width: 280)
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
                                            .frame(width: 280)
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
                                            .frame(width: 280)
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
