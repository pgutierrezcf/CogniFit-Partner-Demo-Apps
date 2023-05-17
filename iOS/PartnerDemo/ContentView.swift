//
//  ContentView.swift
//  PartnerDemo
//
//  Created by Pedro Gutiérrez on 16/5/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var configuration = Configuration()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Image(systemName: "brain")
                        .font(.system(size: 80, weight: .regular))
                        .foregroundColor(.accentColor)
                        .padding(.bottom)
                    Text("CogniFit Partner Demo")
                        .font(.system(size: 30, weight: .regular))
                        .padding(.bottom)
                    if configuration.isValid {
                        List {
                            HStack {
                                Text("Client ID:")
                                Text(configuration.clientId).lineLimit(1).monospaced().truncationMode(.tail)
                            }.listRowSeparator(.hidden).listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            HStack {
                                Text("Client Secret:")
                                Text(configuration.clientSecret).lineLimit(1).monospaced().truncationMode(.tail)
                            }.listRowSeparator(.hidden).listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            HStack {
                                Text("User Token:")
                                Text(configuration.userToken).lineLimit(1).monospaced().truncationMode(.tail)
                            }.listRowSeparator(.hidden).listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        }.listStyle(.plain).environment(\.defaultMinListRowHeight, 30)
                        Text("Select the activity type and key").fontWeight(.bold)
                        Picker("", selection: $selectedActivityType) {
                            ForEach(ActivityType.allCases, id: \.self) { option in
                                Text(activityTypeName(option))
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                            .padding()
                        switch selectedActivityType {
                        case .assessment:
                            Section {
                                Picker("", selection: $selectedAssessment) {
                                    ForEach(Assessment.allCases, id: \.self) { item in
                                        Text(getAssessmentName(item)).tag(item.rawValue)
                                    }
                                }
                            }
                            HStack {
                                Text("Key:")
                                Text(selectedAssessment.rawValue).monospaced()
                            }
                        case .trainingSession:
                            Section {
                                Picker("", selection: $selectedTrainingSession) {
                                    ForEach(TrainingSession.allCases, id: \.self) { item in
                                        Text(getTrainingSessionName(item)).tag(item.rawValue)
                                    }
                                }
                            }
                            HStack {
                                Text("Key:")
                                Text(selectedTrainingSession.rawValue).monospaced()
                            }
                        case .trainingTask:
                            Section {
                                Picker("", selection: $selectedTrainingTask) {
                                    ForEach(TrainingTask.allCases, id: \.self) { item in
                                        Text(getTrainingTaskName(item)).tag(item.rawValue)
                                    }
                                }
                            }
                            HStack {
                                Text("Key:")
                                Text(selectedTrainingTask.rawValue).monospaced()
                            }
                        }
                        /* This Form is here simply to force a certain layout */
                        Form {}
                        Text("").onChange(of: api.accessToken) { accessToken in
                            let canLaunchCogniFitApp = accessToken.count > 0
                            let message: String
                            if canLaunchCogniFitApp {
                                message = "Launching CogniFit App"
                                print("Using access token \(accessToken)")
                            } else {
                                message = "Something went wrong, see console for details"
                            }
                            showMessageAndReset(message: message)
                        }
                        Button("Sign In and Launch Activity") {
                            modalMessage = "Fetching user credentials..."
                            isBusy = true
                            isShowingModalMessage = true

                            api.fetchAccessToken(clientId: configuration.clientId, clientSecret: configuration.clientSecret, userToken: configuration.userToken)
                        }
                    } else {
                        Text("ERROR: your Info.plist file does not include:\n• \(Configuration.kClientIdKey)\n• \(Configuration.kClientSecretKey)\n• \(Configuration.kUserTokenKey)")
                            .font(.system(size: 20, weight: .regular)).foregroundColor(.red).padding(.bottom)
                        Text("You can get your client ID and Secret by logging in with your partner account.")
                            .font(.system(size: 20, weight: .regular)).padding(.bottom)
                        Text("The user token is a user's identifier, it's what you get when creating a new user, see the API call [here](https://cognifitapiv2.docs.apiary.io/#reference/0/user-registration/create-new-user-account).")
                            .font(.system(size: 20, weight: .regular))
                    }
                }
                .padding().blur(radius: isShowingModalMessage ? 4 : 0)

                if isShowingModalMessage {
                    VStack (alignment: .center) {
                        Text(modalMessage).padding(.bottom).padding().multilineTextAlignment(.center)
                        if isBusy {
                            ProgressView().progressViewStyle(.circular).scaleEffect(1.5)
                        }
                    }.frame(width: 0.75 * geometry.size.width,
                            height: 0.3 * geometry.size.height).background(.white)
                        .cornerRadius(20).shadow(radius: 20).padding()
                }
            }
        }
    }

    private func showMessageAndReset(message: String, duration: Double = 3) {
        modalMessage = message
        isBusy = false

        let task = DispatchWorkItem {
            withAnimation(Animation.spring()) {
                workItem = nil
                isShowingModalMessage = false
            }
        }
        workItem = task
        DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: task)
    }

    @State private var selectedActivityType: ActivityType = .assessment
    @State private var selectedAssessment: Assessment = .concentration
    @State private var selectedTrainingSession: TrainingSession = .concentration
    @State private var selectedTrainingTask: TrainingTask = .puzzle3d
    @State private var isShowingModalMessage = false
    @State private var isBusy = true
    @State private var modalMessage = ""
    @State private var workItem: DispatchWorkItem?

    @StateObject private var api = CogniFitAPI()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
