//
//  Subjects.swift
//  IOS_Study
//
//  Created by 황윤경 on 2021/12/27.
//

import UIKit

//MARK: 임시 과목별 숙제 정보 구조체
struct Subjects {
    var subjectName:String
    var teacher:String
    var homework:Array<String>
    
    init(_ subjectName:String, _ teacher:String, _ homework:Array<String>) {
        self.subjectName = subjectName
        self.teacher = teacher
        self.homework = homework
    }
}
