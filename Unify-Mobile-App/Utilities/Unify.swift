//
//  Unify.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 19/10/2020.
//

import UIKit
//import SearchTextField

class Unify {
    static let strings = Strings()
    static let defaultUser = User(name: "Sam", date_of_birth: "11/01/1990", gender: "male", interests: ["football", "ps4"], nationality: "British", uid: "12345678910", profile_picture_url: "www.image.com", is_online: false, is_onboarding_complete: [.completed], university_name: "University of london", course: Course(name: "Architect"), studyYear: StudyYear(year: "year 1"))
}

extension Array {
    func object(at index: Int) -> Element? {
        guard index >= 0, index < count else { return nil }
        return self[index]
    }
}

extension Unify {

}
