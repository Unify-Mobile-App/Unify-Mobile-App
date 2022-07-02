//
//  HomeViewModel.swift
//  Unify
//
//  Created by Melvin Asare on 24/10/2021.
//

import Observable

class HomeViewModel {
    public let universityObservable = MutableObservable<[String]>([])
    public var filteredUniversityData: [String] = []
    public var usersObservable: MutableObservable<[User]>
    public var currentUser = AccountManager.account.currentUser
    public var user = MutableObservable<User?>(nil)

    private func filterUniversityByCountry() {
        NetworkManager.shared.loadUniversityData { [weak self] university in
            let universityFilter = university.filter { $0.country == Unify.strings.united_kingdom }
            let universityName = universityFilter.compactMap { $0.name }
            self?.universityObservable.wrappedValue = universityName
            self?.filteredUniversityData = universityName
        }
    }

    init() {
        usersObservable = MutableObservable(wrappedValue: [])
        filterUniversityByCountry()
        NetworkManager.shared.reset = true
        fetchAllUsers()
    }

    public func fetchAllUsers() {

        NetworkManager.shared.fetchAllUsers { (users) in
            self.usersObservable.wrappedValue = users
            self.fetchCurrentUserProfile()
        }
    }

    public func fetchCurrentUserProfile() {
        AccountManager.account.configureCurrentUser(users: usersObservable.wrappedValue) { users in
            guard let user = users.object(at: 0) else { return }
            print(user)
            self.user.wrappedValue = user
                //   return completion(user)
        }
    }

   public func retrieveUsersFromUniversity(uni: String) -> [User]? {
        return NetworkManager.shared.retrieveUsersFromUniversity(university: uni)
    }
}
