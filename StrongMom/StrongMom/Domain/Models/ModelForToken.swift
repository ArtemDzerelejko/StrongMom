//
//  ModelForToken.swift
//  StrongMom
//
//  Created by artem on 31.01.2024.
//

import Foundation

// MARK: - TokenResponse
class TokenResponse {
    let token: String?
    let refreshToken: String?
    
    init(token: String?,
         refreshToken: String?) {
        self.token = token
        self.refreshToken = refreshToken
    }
    
    init(from remote: TokenResponseRemote) {
        self.token = remote.token ?? ""
        self.refreshToken = remote.refreshToken ?? ""
    }
    
    var remoteModel: TokenResponseRemote {
        TokenResponseRemote(token: token,
                            refreshToken: refreshToken)
    }
    
}

// MARK: - UserTokenResponse
class UserTokenResponse {
    let userToken: String?
    let userRefreshToken: String?
    
    init(userToken: String?,
         userRefreshToken: String?) {
        self.userToken = userToken
        self.userRefreshToken = userRefreshToken
    }
    
    init(from remote: UserTokenResponseRemote) {
        self.userToken = remote.userToken ?? ""
        self.userRefreshToken = remote.userRefreshToken ?? ""
    }
}

// MARK: - LogInUserResponse
class LogInUserTokenResponse {
    let logInUserToken: String?
    let logInUserRefreshToken: String?
    
    init(logInUserToken: String?,
         logInUserRefreshToken: String?) {
        self.logInUserToken = logInUserToken
        self.logInUserRefreshToken = logInUserRefreshToken
    }
    
    init(from remote: LogInUserTokenResponseRemote) {
        self.logInUserToken = remote.logInUserToken ?? ""
        self.logInUserRefreshToken = remote.logInUserRefreshToken ?? ""
    }
}
