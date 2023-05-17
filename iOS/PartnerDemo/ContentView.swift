//
//  ContentView.swift
//  PartnerDemo
//
//  Created by Pedro Gutiérrez on 16/5/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var configuration = Configuration()
    
    @State var selectedActivityType: ActivityType = .assessment
    @State var selectedAssessment: Assessment = .concentration
    @State var selectedTrainingSession: TrainingSession = .concentration
    @State var selectedTrainingTask: TrainingTask = .puzzle3d

    var body: some View {
        VStack {
            Image(systemName: "brain")
                .font(.system(size: 80, weight: .regular))
                .foregroundColor(.accentColor)
                .padding(.bottom)
            Text("CogniFit Partner Demo")
                .font(.system(size: 30, weight: .regular))
                .padding(.bottom)
            if (configuration.isValid) {
                List {
                    HStack {
                        Text ("Client ID:")
                        Text (configuration.clientId).lineLimit(1).monospaced().truncationMode(.tail)
                    }.listRowSeparator(.hidden).listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    HStack {
                        Text ("Client Secret:")
                        Text (configuration.clientSecret).lineLimit(1).monospaced().truncationMode(.tail)
                    }.listRowSeparator(.hidden).listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    HStack {
                        Text ("User Token:")
                        Text (configuration.userToken).lineLimit(1).monospaced().truncationMode(.tail)
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
                                Text(getAssessmentName(item))
                            }
                        }
                    }
                    HStack {
                        Text ("Key:")
                        Text(selectedAssessment.rawValue).monospaced()
                    }
                case .trainingSession:
                    Section {
                        Picker("", selection: $selectedTrainingSession) {
                            ForEach(TrainingSession.allCases, id: \.self) {
                                Text(getTrainingSessionName($0))
                            }
                        }
                    }
                    HStack {
                        Text ("Key:")
                        Text(selectedTrainingSession.rawValue).monospaced()
                    }
                case .trainingTask:
                    Section {
                        Picker("", selection: $selectedTrainingTask) {
                            ForEach(TrainingTask.allCases, id: \.self) { item in
                                Text(getTrainingTaskName(item))
                            }
                        }
                    }
                    HStack {
                        Text ("Key:")
                        Text(selectedTrainingTask.rawValue).monospaced()
                    }
                }
                Form { }
                Button("Sign In and Launch Activity") {
                    print("Hello")
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
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
