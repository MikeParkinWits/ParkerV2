//
//  UserViewModel.swift
//  Signin With Apple
//
//

import Foundation

struct UserViewModel {
	var email: String = ""
	var password: String = ""
	var fullname: String = ""
	var lastName: String = ""
	var carLicense: String = ""
	var confirmPassword: String = ""
	var isParked: Bool = false
	var profileImageUrl:String = ""
	var currentParkingAreaID:String = ""
	
	// MARK: - Validation Checks
	
	func passwordsMatch(_confirmPW:String) -> Bool {
		return _confirmPW == password
	}
	
	func isEmpty(_field:String) -> Bool {
		return _field.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
	}
	
	func isEmailValid(_email: String) -> Bool {
		
		// Email must have a string, then '@', then string, then .string
		let emailTest = NSPredicate(format: "SELF MATCHES %@",
									   "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
		return emailTest.evaluate(with: email)
	}
	
	
	func isPasswordValid(_password: String) -> Bool {
		
		// Password must be 8 chars, contain a capital letter and a number
		let passwordTest = NSPredicate(format: "SELF MATCHES %@",
									   "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$")
		return passwordTest.evaluate(with: password)
	}
	
	var isSignInComplete:Bool  {
		if  !isEmailValid(_email: email) ||
				isEmpty(_field: fullname) ||
				isEmpty(_field: lastName) ||
				isEmpty(_field: carLicense) ||
				!isPasswordValid(_password: password) ||
				!passwordsMatch(_confirmPW: confirmPassword){
			return false
		}
		return true
	}
	
	var isLogInComplete:Bool {
		if isEmpty(_field: email) ||
			isEmpty(_field: password) {
			return false
		}
		return true
	}
	
	// MARK: - Validation Error Strings
	
	var validNameText: String {
		if isEmpty(_field: fullname) && isEmpty(_field: lastName)
		{
			return "Enter your full name"
		}
		else
		{
			return ""
		}
	}
	
	var validCarMake: String {
		if !isEmpty(_field: carLicense){
			return ""
		}
		else
		{
			return "Enter your Car Licence"
		}
	}
	
	var validEmailAddressText:String {
		if isEmailValid(_email: email) {
			return ""
		} else {
			return "Enter a valid email address"
		}
	}
	
	var validPasswordText:String {
		if isPasswordValid(_password: password) {
			return ""
		} else {
			return "Must be 8 characters containing at least one number and one Capital letter."
		}
	}
	
	var validConfirmPasswordText: String {
		if passwordsMatch(_confirmPW: confirmPassword) {
			return ""
		} else {
			return "Password fields do not match."
		}
	}
}
