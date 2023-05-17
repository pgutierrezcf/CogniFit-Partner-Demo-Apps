//
//  CogniFitAPI.swift
//  PartnerDemo
//
//  Created by Pedro Gutiérrez on 17/5/23.
//

import Combine
import Foundation

/** Can fetch a user's access token.
 */
class CogniFitAPI: ObservableObject {
    @Published var accessToken: String = ""
    
    func fetchAccessToken(clientId: String, clientSecret: String, userToken: String) {
        getSingleSignOnToken(clientId: clientId, clientSecret: clientSecret, userToken: userToken)
            .receive(on: DispatchQueue.main)
            .assign(to: &$accessToken)
    }
    
    init() {}
    
    private func getSingleSignOnToken(clientId: String, clientSecret: String, userToken: String) -> AnyPublisher<String, Never> {
        guard let url = URL(string: "/issue-access-token", relativeTo: baseUrl) else {
            return Just("").eraseToAnyPublisher()
        }

        let payload = ["client_id": clientId, "client_secret": clientSecret, "user_token": userToken]
        guard let requestBody = try? JSONSerialization.data(withJSONObject: payload, options: []) else {
            return Just("").eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = requestBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        return URLSession.shared.dataTaskPublisher(for: request)
            .map { data, _ in
                do {
                    let token: AccessToken = try JSONDecoder().decode(AccessToken.self, from: data)
                    return token.token
                } catch {
                    if let response = String(data: data, encoding: .utf8) {
                        print("Error: \(response)")
                    } else {
                        print("Error: unknown")
                    }

                    return ""
                }
            }
            .replaceError(with: "")
            .eraseToAnyPublisher()
    }

    private let baseUrl = URL(string: "https://api.cognifit.com")
}

/** Used to decode the response of the "/issue-access-token" endpoint.
 */
struct AccessToken: Decodable {
    var token: String
    var type: String

    enum CodingKeys: String, CodingKey {
        case token = "access_token"
        case type = "token_type"
    }
}
