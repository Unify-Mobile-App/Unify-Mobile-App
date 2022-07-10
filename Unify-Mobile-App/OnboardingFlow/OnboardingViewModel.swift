//
//  OnboardingViewModel.swift
//  Unify
//
//  Created by Melvin Asare on 06/10/2021.
//

import Observable
import AuthenticationServices
import FirebaseAuth

class OnboardingViewModel {

    public var currentUserId = AccountManager.account.currentUser?.uid
    public let university = MutableObservable<[University]>([])
    public let course = CourseData.courseArray()
    public let year = StudyYearData.yearArray()
    public let interestsData = InterestData.InterestArray()

    public var interestsArray: [String] = []
    public var usersSelectedInterestArray: [String] = []
    public var user: User?

    public func signInWithApple() {
        AppleAccountManager.shared.performSignIn()
    }

    public func signInWithEmail(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        NetworkManager.shared.signInViaEmail(email: email, password: password) { success, error in
            if error != nil {
                return
            }
            completion(success, error)
        }
    }

    public func createAccountWithEmail(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        NetworkManager.shared.createAccountViaEmail(email: email, password: password) { result, error in
            if error != nil {
                return
            }
            if result.user.uid.isEmpty == false {
                completion(true, error)
            }
        }
    }
    
    public func hasUserAlreadyCompletedOnboarding(completion: @escaping (Bool) -> Void) {
        AccountManager.account.hasUserAlreadyCompletedOnboarding { activeAccount in
            if activeAccount == true {
                completion(activeAccount)
            } else {
                completion(activeAccount)
            }
        }
    }

    public func saveOnboardingState(stringValue: String, is_stage_complete: String, isOnboardingComplete: Bool?, userId: String, completion: @escaping (Bool) -> Void) {
        NetworkManager.shared.saveOnboardingState(stringValue: stringValue, is_stage_complete: is_stage_complete, isOnboardingComplete: isOnboardingComplete, userId: userId) { success in
            if success == true {
                completion(success)
            } else {
                completion(false)
            }
        }
    }

    private func filterUniversityByName() {
        NetworkManager.shared.loadUniversityData { [weak self] university in
            self?.university.wrappedValue = university.filter { $0.country == Unify.strings.united_kingdom }
        }
    }

    public func addUsernameToDatabase(name: String, completion: @escaping (OnboardingStateProgressEnum) -> Void) {
        guard currentUserId != nil else {
            completion(.uncomplete)
            return
        }
        NetworkManager.shared.addUsernameToDatabase(name: name) { success in
            if success == .completed { completion(.completed) }
        }
    }

    public func addUniversityToDatabase(universityName: String, completion: @escaping (OnboardingStateProgressEnum) -> Void) {
        guard currentUserId != nil else {
            completion(.uncomplete)
            return
        }
        NetworkManager.shared.addUniversityToDatabase(universityName: universityName) { success in
            if success == .completed { completion(.completed) }
        }
    }

    public func addCourseToDatabase(courseName: String, completion: @escaping (OnboardingStateProgressEnum) -> Void) {
        guard currentUserId != nil else {
            completion(.uncomplete)
            return
        }
        NetworkManager.shared.addCourseToDatabase(course: courseName) { success in
            if success == .completed { completion(.completed) }
        }
    }

    public func addYearToDatabase(year: String, completion: @escaping (OnboardingStateProgressEnum) -> Void) {
        guard currentUserId != nil else {
            completion(.uncomplete)
            return
        }
        NetworkManager.shared.addYearToDatabase(year: year) { success in
            if success == .completed { completion(.completed) }
        }
    }

    public func uploadImageToFirebaseStorage(avatarView: UIImageView, completion: @escaping (OnboardingStateProgressEnum) -> Void) {
        guard currentUserId != nil else {
            completion(.uncomplete)
            return
        }
        NetworkManager.shared.uploadImageToFirebaseStorage(avatarView: avatarView) { success in
            if success { completion(.completed) }
        }
    }

    public func addInterestsToDatabase(interests: [String], completion: @escaping (OnboardingStateProgressEnum) -> Void) {
        guard currentUserId != nil else {
            completion(.uncomplete)
            return
        }
        NetworkManager.shared.addInterestsToDatabase(interests: interests) { success in
            if success == .completed { completion(.completed) }
        }
    }

    public func addPrivateDataToDatabase(dob: String, gender: String, nationality: String, completion: @escaping (OnboardingStateProgressEnum) -> Void) {
        guard currentUserId != nil else {
            completion(.uncomplete)
            return
        }
        NetworkManager.shared.addPrivateDataToDatabase(dob: dob, gender: gender, nationality: nationality) { success in
            if success == .completed { completion(.completed) }
        }
    }

    func interestMapped(for indexPath: IndexPath) -> String? {
        let name = interestsData.map { $0.name }
        return name.object(at: indexPath.row)
    }

    required init() {
        self.interestsArray = interestsData.map { $0.name }
        self.filterUniversityByName()
    }
}
