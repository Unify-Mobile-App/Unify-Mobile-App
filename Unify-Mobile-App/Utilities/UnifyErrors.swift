//
//  UnifyErrors.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 26/02/2021.
//

import Foundation

enum UnifyErrors: String, Error {
    case emailAndPasswordEmpty = "Please make sure you've filled both boxes"
    case noUserRegistered = "There isn't any user registered with this account"
    case incorrectPassword = "Incorrect password, please try again"
    case invalidEmail = "Email is not valid, please check again"
    case invalidUsername = "This username created an invalid request. Please try a different name."
    case usernameIsTaken = "This username is no longer available, please select a different name."
    case invalidPassword = "Your password must have at least one special character, capitel letter and a number"
    case emailAlreadyExist = "The email address is already in use by another account."
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case unableToAddToFavourites = "Couldnt add user to favourites list"
    case alreadyInFavourites = "You've already added them to favourites"
    case unableToEncode = "Unable to encode object into data"
    case noValue = "No data object found for the given key"
    case unableToDecode = "Unable to decode object into given type"
    case notSignedIn = "You're not signed in"
    case genericError = "Something was wrong, please check and try again"
}
