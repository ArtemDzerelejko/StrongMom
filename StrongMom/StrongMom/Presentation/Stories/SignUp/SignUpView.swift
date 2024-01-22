//
// SignUpView.swift
// StrongMom
//
// Created by artem on 18.01.2024.
//
import SwiftUI
struct SignUpView: View {
    @State var emailTextFieldText: String = ""
    @State var passwordTextFieldText: String = ""
    @State var confirmPassword: String = ""
    @State var checkboxIsActive = false
    @State var isPasswordValid = false
    @State var isPasswordMatchValid = false
    @State var acceptedPrivacyPolicy = true
    @State var acceptedTermsAndConditions = true
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var signUpViewModel = SignUpViewModel()
    @State var buttonInValid = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        
        VStack {
            BackButton()
            Text(Strings.createAnAccount)
                .font(AppFont.Headline1)
                .foregroundColor(.customLightBlack)
                .multilineTextAlignment(.leading)
                .padding(.leading, 22)
                .padding(.trailing, 100)
                .padding(.bottom, 60)
                .frame(maxWidth: .infinity,alignment: .leading)
            
            VStack(alignment: .leading, spacing: 15, content: {
                PrimaryTextField(text: $emailTextFieldText, placeholder: Strings.email)
                SecureTextField(text: $passwordTextFieldText, placeholder: Strings.password)
            })
            .padding(.bottom, 8)
            
            VStack() {
                Text(Strings.passwordRules)
                    .font(AppFont.Caption1)
                    .foregroundColor(Color.customLightBlack)
                    .padding(.bottom, 16)
            }
            .padding(.trailing, 39)
            .padding(.leading, 30)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            SecureTextField(text: $confirmPassword, placeholder: Strings.confirmPassword)
            
            if passwordTextFieldText != confirmPassword {
                Text(Strings.passwordMismatch)
                    .font(AppFont.Caption1)
                    .foregroundColor(.customDeepPink)
                    .padding(.leading, 30)
                    .padding(.trailing, 39)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 36)
            } else {}
            
            PrimaryButton(isValid: isValidInput(), text: Strings.continueWithEmail, size: CGSize(width: 335, height: 46)) {
                let modelForCreateUser = ModelForCreateUser(email: emailTextFieldText, password: passwordTextFieldText, passwordConfirmation: confirmPassword, timezone: TimeZone.current.identifier, acceptedPrivacyPolicy: acceptedPrivacyPolicy, acceptedTermsAndConditions: acceptedTermsAndConditions)
                print(modelForCreateUser)
                
                signUpViewModel.createUser(model: modelForCreateUser) { result in
                    switch result {
                    case .success(let userTokenResponse):
                        print("Successfully created user: \(userTokenResponse)")
                    case .failure(let error):
                        showAlert = true
                        alertMessage = Strings.failedToCreateUser + "\(error.localizedDescription)"
                    }
                }
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .padding(.bottom, 26)
            .disabled(!isValidInput())
            .alert(isPresented: $showAlert) {
                Alert(title: Text(Strings.error),
                      message: Text(alertMessage),
                      dismissButton: .default(Text(Strings.ok)))
            }
            
            Text(Strings.continueWith)
                .font(AppFont.Body2)
                .foregroundColor(.customLightBlack)
            
            HStack(alignment: .center, spacing: 20, content: {
                SocialMediaButton(buttonImage: Strings.facebook) {}
                SocialMediaButton(buttonImage: Strings.google) {}
                SocialMediaButton(buttonImage: Strings.apple) {}
            })
            .padding(.top, 22)
            .padding(.bottom, 26)
            
            HStack(alignment: .center, spacing: 16, content: {
                Button(action: {
                    self.checkboxIsActive.toggle()
                }, label: {
                    if checkboxIsActive {
                        Image(Strings.checkBoxOn)
                    } else {
                        Image(Strings.checkBoxOff)
                    }
                })
                AgreementButtonsView()
            })
            .padding(.bottom, 25)
            
            CustomLinkButtonWithText(text: Strings.haveAccount, linkText: Strings.logIn, textColor: .customLightBlack) {
            }
        }
        .onAppear {
            signUpViewModel.fetchToken()
        }
    }
    
    private func isValidInput() -> Bool {
        let isEmailValid = !emailTextFieldText.isEmpty
        let isPasswordValid = !passwordTextFieldText.isEmpty
        let isConfirmPasswordValid = !confirmPassword.isEmpty && confirmPassword == passwordTextFieldText
        let isCheckboxActive = checkboxIsActive
        return isEmailValid && isPasswordValid && isConfirmPasswordValid && isCheckboxActive
    }
}
#Preview {
    SignUpView()
}
