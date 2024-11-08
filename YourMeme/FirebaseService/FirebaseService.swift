//
//  FirebaseService.swift
//  YourMeme

import Foundation
import FirebaseAuth

protocol FirebaseServiceProtocol: AnyObject {
    func create(_ email: String, _ password: String) async throws -> Bool
    func signIn(_ email: String, _ password: String) async throws -> Bool
    func resetPassword(_ email: String) async throws -> Bool
    func signOut() throws -> Bool
    func isLogin() -> Bool
}

final class FirebaseService: FirebaseServiceProtocol {
   
    func create(_ email: String, _ password: String) async throws -> Bool {
        do {
            let user = try await Auth.auth().createUser(withEmail: email, password: password)
            try await user.user.sendEmailVerification()
            let signOut = try signOut()

            return signOut
        } catch {
            throw error
        }
    }
    
    func signIn(_ email: String, _ password: String) async throws -> Bool {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            let verify = result.user.isEmailVerified ? true : false

            return verify
        } catch {
            throw error
        }
    }
    
    func resetPassword(_ email: String) async throws -> Bool {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
            return true
        } catch {
            throw error
        }
    }
    
    func signOut() throws -> Bool {
        do {
            try Auth.auth().signOut()
            return true
        } catch {
            throw error
        }
    }
    
    func isLogin() -> Bool {
        Auth.auth().currentUser != nil
    }
}
