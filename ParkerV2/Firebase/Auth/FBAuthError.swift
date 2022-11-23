//
//  FBError.swift
//
//

import Foundation

// MARK: - Signin in with email errors

enum EmailAuthError: Error {
	case incorrectPassword
	case invalidEmail
	case accoundDoesNotExist
	case unknownError
	case couldNotCreate
	case extraDataNotCreated
}

extension EmailAuthError: LocalizedError {
	
	// This will provide a specific localized description for the EmailAuthError
	var errorDescription: String? {
		switch self {
		case .incorrectPassword:
			return NSLocalizedString("Incorrect Password for this account", comment: "")
		case .invalidEmail:
			return NSLocalizedString("Not a valid email address.", comment: "")
		case .accoundDoesNotExist:
			return NSLocalizedString("Not a valid email address.  This account does not exist.", comment: "")
		case .unknownError:
			return NSLocalizedString("Unknown error.  Cannot log in.", comment: "")
		case .couldNotCreate:
			return NSLocalizedString("Could not create user at this time.", comment: "")
		case .extraDataNotCreated:
			return NSLocalizedString("Could not save user's full name.", comment: "")
		}
	}
}




