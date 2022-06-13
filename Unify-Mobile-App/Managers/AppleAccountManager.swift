//
//  AppleAccountManager.swift
//  Unify-Mobile-App
//
//  Created by Melvin Asare on 02/06/2022.
//

import AuthenticationServices
import FirebaseAuth
import CryptoKit

class AppleAccountManager: NSObject {

    public static let shared = AppleAccountManager()
    private var currentNonce: String?
    private let window = UIWindow()

    @available(iOS 13, *)
    public func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        return hashString
    }

    public func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length

        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        return result
    }

    public func performSignIn() {
        let request = createAppleIdRequest()
        let authorisationController = ASAuthorizationController(authorizationRequests: [request])
        request.requestedScopes = [.email, .fullName]
        authorisationController.delegate = self
        authorisationController.presentationContextProvider = self
        authorisationController.performRequests()
    }

    struct Consts {
        static let width: CGFloat = 50
        static let floatingButtonPadding: CGFloat = 28.0
    }
}

extension AppleAccountManager: ASAuthorizationControllerDelegate {
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }

    func createAppleIdRequest() -> ASAuthorizationOpenIDRequest {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let nonce = randomNonceString()
        request.nonce = sha256(nonce)
        currentNonce = nonce
        return request
    }

    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIdCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: a login callback was received")
            }
            guard let appleIDToken = appleIdCredential.identityToken else {
                print("Unable to fetch ID Token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("unable to serialise token string from data \(appleIDToken.debugDescription)")
                return
            }

            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)

            Auth.auth().signIn(with: credential) { [weak self] result, error in
                if error != nil {
                    return
                }
                // Trigger navigation
//                self?.navigationController?.pushViewController(UserProfileImageViewController(viewModel: OnboardingViewModel()), animated: true)
            }
        }
    }
}
//
extension AppleAccountManager: ASAuthorizationControllerPresentationContextProviding {

    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
   //     return self.view.window!
        return self.window
    }
}
