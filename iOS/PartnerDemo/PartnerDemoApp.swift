//
//  PartnerDemoApp.swift
//  PartnerDemo
//
//  Created by Pedro Gutiérrez on 16/5/23.
//

import SwiftUI

@main
struct PartnerDemoApp: App {
    @UIApplicationDelegateAdaptor var delegate: CogniFitAppDelegate

    var body: some Scene {
        WindowGroup {
            ContentView().onOpenURL { url in
                print("TODO: handle callback \(url)")
            }
        }
    }
}

class CogniFitAppDelegate: NSObject, UIApplicationDelegate {
    static let isiPad = UIDevice.current.userInterfaceIdiom == .pad
    static let isiPhone = UIDevice.current.userInterfaceIdiom == .phone
    static var allowOrientationChanges = false

    func application(_: UIApplication, supportedInterfaceOrientationsFor _: UIWindow?) -> UIInterfaceOrientationMask {
        // iPad is always in landscape, no other orientation is ever allowed
        if CogniFitAppDelegate.isiPad {
            return .landscape
        } else {
            return CogniFitAppDelegate.allowOrientationChanges ? .allButUpsideDown : .portrait
        }
    }
}
