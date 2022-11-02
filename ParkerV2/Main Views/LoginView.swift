//
//  LoginView.swift
//  ParkerV2
//
//  Created by Mike Parkin on 2022/11/01.
//

import SwiftUI

struct LoginView: View {
	
	enum Action{
		case signUp, resetPW
	}
	
	@State private var showSheet = false
	@State private var action: Action?
	
    var body: some View {
		NavigationView {
			VStack{
				
					SignInWithEmailView(showSheet: $showSheet, action: $action)
					Spacer()
				
			}
			
			.navigationTitle(Text("Login"))
				.sheet(isPresented: $showSheet) { [action] in
				if action == .signUp {
				   SignUpView()
				  }  else  {
					ForgotPasswordView()
				  }
			}
		}

    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
