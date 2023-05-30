//
//  Configuration.swift
//  PartnerDemo
//
//  Created by Pedro Gutiérrez on 17/5/23.
//

import Foundation

/** Reads the configuration values from the App's Info.plist file.
 */
class Configuration: ObservableObject {
    @Published var clientId = ""
    @Published var clientSecret = ""
    @Published var userToken = ""
    @Published var appUrlScheme = ""
    @Published var isValid = false

    static let kClientIdKey = "COGNIFIT_CLIENT_ID"
    static let kClientSecretKey = "COGNIFIT_CLIENT_SECRET"
    static let kUserTokenKey = "COGNIFIT_USER_TOKEN"
    static let kUrlTypesKey = "CFBundleURLTypes"
    static let kUrlSchemesKey = "CFBundleURLSchemes"

    init() {
        if let appBundleClientId = Bundle.main.object(forInfoDictionaryKey: Configuration.kClientIdKey) as? String,
           let appBundleClientSecret = Bundle.main.object(forInfoDictionaryKey: Configuration.kClientSecretKey) as? String,
           let appBundleUserToken = Bundle.main.object(forInfoDictionaryKey: Configuration.kUserTokenKey) as? String,
           let appUrlTypes = Bundle.main.object(forInfoDictionaryKey: Configuration.kUrlTypesKey) as? [[String: Any]],
           let firstAppUrlType = appUrlTypes.first,
           let firstAppUrlScheme = (firstAppUrlType[Configuration.kUrlSchemesKey] as? [String])?.first
        {
            clientId = appBundleClientId
            clientSecret = appBundleClientSecret
            userToken = appBundleUserToken
            appUrlScheme = firstAppUrlScheme
            isValid = true
        }
    }
}
