
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
import Foundation

struct Achievement:Codable, Hashable, Identifiable, Equatable {
    let id: Int
    let achieveName: String
    let timeCount: Int
    let mode: String
    let image: String
    let modeID: Int
    
}
