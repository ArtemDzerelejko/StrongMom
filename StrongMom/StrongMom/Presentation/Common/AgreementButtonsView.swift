//
//  AgreementButtonsView.swift
//  StrongMom
//
//  Created by artem on 19.01.2024.
//

import SwiftUI

private struct Constans {
    static let termsAndConditionUrl = "https://www.freeprivacypolicy.com/blog/privacy-policy-url/"
    static let privacyPolicyUrl = "https://www.freeprivacypolicy.com/blog/privacy-policy-url/"
}

struct AgreementButtonsView: View {
    var body: some View {
        HStack(spacing: 2.5) {
            Text(Strings.iAgreeToThe)
            Button(action: {
                guard let url = URL(string: Constans.termsAndConditionUrl) else { return }
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }, label: {
                Text(Strings.termsAndCondition)
                    .foregroundColor(.customLightBlue)
            })
            Text(Strings.and)
            Button(action: {
                guard let url = URL(string: Constans.privacyPolicyUrl) else { return }
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }, label: {
                Text(Strings.privacyPolicy)
                    .foregroundColor(.customLightBlue)
            })
        }
        .font(AppFont.Caption1)
    }
}
