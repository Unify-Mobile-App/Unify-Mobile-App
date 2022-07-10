//
//  AccountManager.swift
//  Unify
//
//  Created by Melvin Asare on 13/10/2021.
//

import Firebase
import Observable
import FirebaseDatabase

class AccountManager {
    static let account = AccountManager()
    public let currentUser = Auth.auth().currentUser
    public let isUserLoggedIn = Auth.auth().currentUser?.uid.isEmpty ?? false
    public var users = [User]()
    public var user: User?
    private let defaults = UserDefaults.standard
    private var disposable: Disposable?

    public var currentUserName: String {
        return defaults.string(forKey: "Name")!
    }

    enum AccountStatus: String {
        case online
        case offline
        case incomplete
    }

    public func fetchCurrentUserName() -> String {
        return defaults.string(forKey: "Name")!
    }

    public func hasUserAlreadyCompletedOnboarding(completion: @escaping (Bool) -> Void) {
        Database.database().reference(withPath: "Onboarding_status").observe(.childAdded) { snapshot in
            if snapshot.exists() {
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    let status = dictionary["is_onboarding_complete"] as? Bool ?? false
                    completion(status)
                    return
                }
            }
            completion(false)
            return
        }
    }

    public func configureCurrentUser(users: [User], completion: @escaping ([User]) -> Void) {
        let filteredUsers = users.filter { $0.uid == currentUser?.uid }
        return completion(filteredUsers)
    }

    public func allowUsersToPreviewApp() { // Allow users to browse but not to message others.

    }

    public func checkIfUsersSignedIn(_ completion: @escaping (Bool) -> Void) {
        if currentUser == nil {
            completion(false)
            return
        }
        completion(true)
    }

    func updateUsername(name: String, completion: @escaping(Bool, Error?) -> Void?) {
        guard let userId = currentUser?.uid else { return }
        let database = Database.database(url: NetworkManager.shared.databaseRegion).reference(withPath: "Users/\(userId)")

        let value = ["name": name]
        database.updateChildValues(value) { error, reference in
            if error != nil {
                completion(false, error)
                return
            }
            completion(true, nil)
            return
        }
    }

    func updateUniversity(university: String, completion: @escaping(Bool, Error?) -> Void?) {
        guard let userId = currentUser?.uid else { return }
        let database = Database.database(url: NetworkManager.shared.databaseRegion).reference(withPath: "Users/\(userId)")

        let value = ["university_name": university]
        database.updateChildValues(value) { error, reference in
            if error != nil {
                completion(false, error)
                return
            }
            completion(true, nil)
            return
        }
    }

    func updateCourse(course: String, completion: @escaping(Bool, Error?) -> Void?) {
        guard let userId = currentUser?.uid else { return }
        let database = Database.database(url: NetworkManager.shared.databaseRegion).reference(withPath: "Users/\(userId)")

        let value = ["course": course]
        database.updateChildValues(value) { error, reference in
            if error != nil {
                completion(false, error)
                return
            }
            completion(true, nil)
            return
        }
    }

    func updateYear(year: String, completion: @escaping(Bool, Error?) -> Void?) {
        guard let userId = currentUser?.uid else { return }
        let database = Database.database(url: NetworkManager.shared.databaseRegion).reference(withPath: "Users/\(userId)")

        let value = ["year": year]
        database.updateChildValues(value) { error, reference in
            if error != nil {
                completion(false, error)
                return
            }
            completion(true, nil)
            return
        }
    }

    func updateAvatar(avatar: String, completion: @escaping(Bool, Error?) -> Void?) {
        guard let userId = currentUser?.uid else { return }
        let database = Database.database(url: NetworkManager.shared.databaseRegion).reference(withPath: "Users/\(userId)")

        let value = ["profile_picture": avatar]
        database.updateChildValues(value) { error, reference in
            if error != nil {
                completion(false, error)
                return
            }
            completion(true, nil)
            return
        }
    }

    func updateFriendRequest() { }

    public func removeFriend(_ id: String) { }

    public func updateFriendRequests(_ completion: (() -> Void)? = nil) { }

    public func signOut(completion: @escaping (Bool, Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true, nil)
        } catch let error {
            completion(false, error)
        }
    }

    func deleteUserAccount() {
        currentUser?.delete(completion: { error in
            print("present something to say delete")
        })
    }

    func updateUserFriendsAndRequests() {}

    func updateFriends(_ completion: (() -> Void)? = nil) {  }
}
