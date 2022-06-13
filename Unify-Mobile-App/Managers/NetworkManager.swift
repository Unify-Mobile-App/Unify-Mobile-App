//
//  NetworkManager.swift
//  Unify-Mobile-App
//
//  Created by Melvin Asare on 29/05/2022.
//

import UIKit
import Firebase
import FirebaseStorage

class NetworkManager {

    static let shared = NetworkManager()
    private let userDefaults = UserDefaults.standard
    public var users = [User]()
    public var reset = false

    // MARK: - Email Verification

    func signInViaEmail(email: String, password: String, completion: @escaping (AuthDataResult, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard let auth = result else { return }
            print(error?.localizedDescription, auth.user.uid)
        }
    }

    func createAccountViaEmail(email: String, password: String, completion: @escaping (AuthDataResult, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard let auth = result else { return }

            completion(auth, error)
        }
    }
}

// MARK: - Retrieve From Database

extension NetworkManager {

    func loadUniversityData(_ completion: @escaping ([University]) -> Void) {
        if let fileLocation = Bundle.main.url(forResource: "UniversityData", withExtension: "json") {
            do {
                // TODO: This causes a warning in the console - need to get the university data on a server and use URL and get rid of Data(contentsOf)
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([University].self, from: data)
                completion(dataFromJson)
            } catch {
                print(error)
            }
        }
    }

    func fetchAllUsers(_ completion: @escaping ([User])-> Void) {
        Database.database().reference(withPath: Unify.strings.users).observe(.childAdded) { [weak self] (snapshot) in
            guard let self = self else { return }
            if let dictionary = snapshot.value as? [String: AnyObject] {
                if self.reset {
                    self.reset = false
                    self.users = [User]()
                }
                var user = User(name: "", date_of_birth: "", gender: "", interests: [""], nationality: "", uid: "", profile_picture_url: "", is_online: false, university_name: "", course: Course(name: ""), studyYear: StudyYear(year: ""))

                user.name = dictionary["name"] as? String ?? ""
                user.profile_picture_url = dictionary["profile_picture"] as? String ?? ""
                user.university_name = dictionary["university_name"] as? String ?? ""
                user.course.name = dictionary["course"] as? String ?? ""
                user.studyYear.year = dictionary["year"] as? String ?? ""
                user.interests = dictionary["interests"] as? Array ?? []
                user.uid = dictionary["userID"] as? String ?? ""
                user.gender = dictionary["gender"] as? String ?? ""
                user.nationality = dictionary["nationality"] as? String ?? ""
                user.date_of_birth = dictionary["date_of_birth"] as? String ?? ""

                self.users.append(user)
                completion(self.users)
            }
        } withCancel: { error in
            print("error")
        }
    }

    func retrieveUsersFromUniversity(university: String) -> [User]? {
        let filteredUser = users.filter { $0.university_name == university }
        return filteredUser
    }
}

// MARK: - Onboarding State

extension NetworkManager {

    public func saveOnboardingState(stringValue: String, is_stage_complete: String, isOnboardingComplete: Bool? , userId: String?, completion: @escaping (Bool) -> Void) {
        if userId != nil {
            let reference = Database.database().reference(withPath: "Onboarding_status")
            let userReference = reference.child(Auth.auth().currentUser?.uid ?? "No UID")
            let value = [stringValue: is_stage_complete, "is_onboarding_complete": isOnboardingComplete as Any] as [String : Any]
            userReference.updateChildValues(value) { error, reference in
                if error != nil {
                    completion(false)
                }
                completion(true)
            }
        }
    }

    public func isOnboardingComplete() {

    }
}

// MARK: - Register To Database

extension NetworkManager {

    public func addUsernameToDatabase(name: String, completion: @escaping (OnboardingStateProgressEnum)-> Void) {
        let reference = Database.database().reference().child(Unify.strings.users)
        let userReference = reference.child(Auth.auth().currentUser?.uid ?? "No UID")

        let values = ["name": name]
        userReference.updateChildValues(values) { [weak self] (error, reference) in
            if error != nil {
                completion(.uncomplete)
            }
            self?.saveUserName(name: name)
            self?.addUserIdToDatabase(completion: { status in
                if status == .completed {
                    completion(.completed)
                } else {
                    completion(.uncomplete)
                }
            })
        }
    }

    public func addUserIdToDatabase(completion: @escaping (OnboardingStateProgressEnum)-> Void) {
        let userId = Auth.auth().currentUser?.uid ?? "No UID"
        let reference = Database.database().reference().child(Unify.strings.users)
        let userReference = reference.child(userId)
        let values = ["userID": userId]
        userReference.updateChildValues(values) { (error, reference) in
            if error != nil {
                completion(.uncomplete)
            }
            completion(.completed)
        }
    }

    public func addUniversityToDatabase(universityName: String, completion: @escaping (OnboardingStateProgressEnum)-> Void) {
        let reference = Database.database().reference(withPath: Unify.strings.users)
        let universityNameReference = reference.child(Auth.auth().currentUser?.uid ?? "No UID")
        let universityNameValue = ["university_name": universityName]
        universityNameReference.updateChildValues(universityNameValue) { [weak self] (error, reference) in
            if error != nil {
                completion(.uncomplete)
            }
            self?.saveUserUniversity(university: universityName)
            completion(.completed)
        }
    }

    public func addCourseToDatabase(course: String, completion: @escaping (OnboardingStateProgressEnum)-> Void) {
        let reference = Database.database().reference(withPath: Unify.strings.users)
        let userReference = reference.child(Auth.auth().currentUser?.uid ?? "No UID")
        let value = ["course": course]
        userReference.updateChildValues(value) { [weak self] (error, reference) in
            if error != nil {
                completion(.uncomplete)
            }
            self?.saveUserCourse(course: course)
            completion(.completed)
        }

    }

    public func addYearToDatabase(year: String, completion: @escaping (OnboardingStateProgressEnum)-> Void) {
        let reference = Database.database().reference(withPath: Unify.strings.users)
        let userReference = reference.child(Auth.auth().currentUser?.uid ?? "No UID")
        let value = ["year": year]
        userReference.updateChildValues(value) { [weak self] (error, reference) in
            if error != nil {
                completion(.uncomplete)
            }
            self?.saveUserYear(year: year)
            completion(.completed)
        }

    }

    public func addInterestsToDatabase(interests: [String], completion: @escaping (OnboardingStateProgressEnum)-> Void) {
        let reference = Database.database().reference(withPath: Unify.strings.users)
        let userReference = reference.child(Auth.auth().currentUser?.uid ?? "No UID")
        let value = ["interests": interests ]
        userReference.updateChildValues(value) { (error, reference) in
            if error != nil {
                completion(.uncomplete)
            }
            completion(.completed)
        }
    }

    public func addPrivateDataToDatabase(dob: String, gender: String, nationality: String, completion: @escaping (OnboardingStateProgressEnum)-> Void) {

        let reference = Database.database().reference(withPath: Unify.strings.users)
        let userReference = reference.child(Auth.auth().currentUser?.uid ?? "No UID")
        let value = ["date_of_birth": dob, "gender": gender, "nationality": nationality]
        userReference.updateChildValues(value as [AnyHashable : Any]) { (error, reference) in
            if error != nil {
                completion(.uncomplete)
            }
            completion(.completed)
        }
    }

    public func uploadImageToFirebaseStorage(avatarView: UIImageView, completion: @escaping (Bool) -> Void) {
        guard
            let profileImage = avatarView.image,
            let data = profileImage.jpegData(compressionQuality: 0.5)
        else {
            completion(false)
            return
        }
        let imageName = UUID().uuidString
        let imageReference = Storage.storage().reference().child(Unify.strings.profile_picture).child(imageName)

        imageReference.putData(data, metadata: nil) { (metadata, error) in
            if error != nil { return }

            imageReference.downloadURL { (url, error) in
                if error != nil { return }

                guard let url = url else { return }

                let dataReference = Firestore.firestore().collection(Unify.strings.profile_picture).document()
                let documentUid = dataReference.documentID
                let urlString = url.absoluteString

                let userReference = Database.database().reference(withPath: Unify.strings.users).child(Auth.auth().currentUser?.uid ?? "No UID")

                let values = [Unify.strings.profile_picture: urlString]
                userReference.updateChildValues(values) { [weak self] (error, reference) in
                    if error != nil {
                    } else {
                        self?.saveUserAvatar(avatar: urlString)
                    }
                }

                let data = [Unify.strings.profile_picture_uid: documentUid, Unify.strings.profile_url: url.absoluteString] as [String : Any]
                dataReference.setData(data) { (error) in
                    if error != nil { return }

                    self.userDefaults.set(documentUid, forKey: Unify.strings.profile_picture_uid)
                    avatarView.image = UIImage()
                    completion(true)
                }
            }
        }
    }
}

// MARK: - User Defaults

private extension NetworkManager {
    func saveUserID(id: String) {
        UserDefaults.standard.set(id, forKey: "Id")
    }

    func saveUserName(name: String) {
        UserDefaults.standard.set(name, forKey: "Name")
    }

    func saveUserEmail(email: String) {
        UserDefaults.standard.set(email, forKey: "Email")
    }

    func saveUserUniversity(university: String) {
        UserDefaults.standard.set(university, forKey: "University")
    }

    func saveUserCourse(course: String) {
        UserDefaults.standard.set(course, forKey: "Course")
    }

    func saveUserYear(year: String) {
        UserDefaults.standard.set(year, forKey: "Year")
    }

    func saveUserAvatar(avatar: String) {
        UserDefaults.standard.set(avatar, forKey: "Avatar")
    }
}
