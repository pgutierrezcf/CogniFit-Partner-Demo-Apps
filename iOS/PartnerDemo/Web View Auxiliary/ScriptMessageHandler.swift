//
//  ScriptMessageHandler.swift
//  PartnerDemo
//
//  Created by Pedro Gutiérrez on 13/7/23.
//

import Foundation
import WebKit

/** The bridge between Javascript and native code, it allows the web App to request an orientation lock, and to dismiss the web view.
 */
class ScriptMessageHandler: NSObject {
    static let Name = "cfPartnerApp"
    lazy var webViewContainer: ModalWebView? = nil

    init(webViewContainer: ModalWebView) {
        super.init()
        self.webViewContainer = webViewContainer
    }

    fileprivate func handleMessage(message: WKScriptMessage) {
        guard message.name == ScriptMessageHandler.Name else {
            return
        }
        guard let payload = message.body as? [String: String] else {
            return
        }

        switch payload["action"] {
        case .some("switchToLandscape"):
            webViewContainer?.switchToLandscape()
        case .some("switchToPortrait"):
            webViewContainer?.switchToPortrait()
        case .some("switchToNaturalOrientation"):
            if CogniFitAppDelegate.isiPad {
                webViewContainer?.switchToLandscape()
            } else {
                webViewContainer?.switchToPortrait()
            }
        case .some("dismiss"):
            webViewContainer?.dismiss()
        case .some("printToConsole"):
            print("console.web: \(payload["message"] ?? "")")
        default:
            debugPrint("Unknown action: \(String(describing: payload["action"]))")
        }
    }
}

extension ScriptMessageHandler: WKScriptMessageHandler {
    func userContentController(_: WKUserContentController, didReceive message: WKScriptMessage) {
        handleMessage(message: message)
    }
}
