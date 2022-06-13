//
//  User.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 28/10/2020.
//

import Foundation

struct User {
    var name: String
    var date_of_birth: String
    var gender: String
    var interests: [String]
    var nationality: String
    var uid: String

    var profile_picture_url: String
    var is_online: Bool?
    var is_onboarding_complete: [OnboardingStateProgressEnum]?

    var university_name: String
    var course: Course
    var studyYear: StudyYear

//    init(name: String, dateOfBirth: String, gender: String, interests: [String], nationality: String, uid: String, profilePictureUrl: String, isOnboardingComplete: [OnboardingStateProgressEnum], universityName: String, course: Course, year: StudyYear) {
//        self.name = name
//        self.date_of_birth = dateOfBirth
//        self.gender = gender
//        self.interests = interests
//        self.nationality = nationality
//        self.uid = uid
//        self.profile_picture_url = profilePictureUrl
//        self.is_onboarding_complete = isOnboardingComplete
//        self.university_name = universityName
//        self.course = course
//        self.studyYear = year
//    }
}
