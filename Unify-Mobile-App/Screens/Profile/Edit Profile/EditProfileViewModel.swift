//
//  EditProfileViewModel.swift
//  Unify-Mobile-App
//
//  Created by Melvin Asare on 01/07/2022.
//

import Foundation

class EditProfileViewModel {

    public let user: User
    public var updatedAvatar: String?
    public var updatedUsername: String?
    public var updatedUniversity: String?
    public var updatedCourse: String?
    public var updatedYear: String?

    func updateUsername(name: String) {
        AccountManager.account.updateUsername(name: name) { success, error in
            if error != nil {
                print(error?.localizedDescription)
            }
            return print(success.description)
        }
    }

    func updateCourse(course: String) {
        AccountManager.account.updateCourse(course: course) { success, error in
            if error != nil {
                print(error?.localizedDescription)
            }
            return print(success.description)
        }
    }

    func updateUniversity(university: String) {
        AccountManager.account.updateUniversity(university: university) { success, error in
            if error != nil {
                print(error?.localizedDescription)
            }
            return print(success.description)
        }
    }

    func updateYear(year: String) {
        AccountManager.account.updateYear(year: year) { success, error in
            if error != nil {
                print(error?.localizedDescription)
            }
            return print(success.description)
        }
    }

    func saveUserProfile() {
        guard let name = updatedUsername,
              let university = updatedUniversity,
              let course = updatedCourse,
              let year = updatedYear
        else { return }

        updateUsername(name: name)
        updateYear(year: year)
        updateUniversity(university: university)
        updateCourse(course: course)
    }
    
    init(user: User) {
        self.user = user
        self.updatedUsername = user.name
        self.updatedAvatar = user.profile_picture_url
        self.updatedUniversity = user.university_name
        self.updatedCourse = user.course.name
        self.updatedYear = user.studyYear.year
    }
}
