
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

/*
 Achievement: This is datatype for achievement
 */
struct Achievement:Codable, Hashable, Identifiable, Equatable {
    let id: Int // id
    let achieveName: String // name of the achievement
    let timeCount: Int // the time requirement to get the achievement
    let mode: String // mode of the achievement: Easy, Intermediate, Hard
    let image: String // image name of the badge
    let modeID: Int // the id of the achievement
    
}
