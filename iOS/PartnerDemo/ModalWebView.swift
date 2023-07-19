//
//  ModalWebView.swift
//  PartnerDemo
//
//  Created by Pedro Gutiérrez on 13/7/23.
//

import SwiftUI
import WebKit

/** CogniFit's code needs to know two things:
 * 1. It's running in a mobile environment (touchscreen, no mouse/keyboard). For this it requires an user-agent for a recent version of Mobile Safari.
 * 2. it's running inside an App. For this it requires that the user-agent includes de string 'cfembedded'
 */
let kCogniFitUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 16_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.4 Mobile/15E148 Safari/604.1 cfembedded"

/** This view holds a WKWebView where CogniFit's web app runs.
  * It must provide methods to force the device's orientation because the layout works best starting from portrait and then switching to landscape.
 */
struct ModalWebView: View {
    @Environment(\.dismiss) var dismiss

    init(clientId: String, accessToken: String, codeVersion: String, activityType: String, activityKey: String) {
        self.clientId = clientId
        self.accessToken = accessToken
        self.codeVersion = codeVersion
        configurationJavaScript = """
            var cfClientId = "\(clientId)";
            var cfAccessToken = "\(accessToken)";
            var cfCodeVersion = "\(codeVersion)";
            var cfActivityType = "\(activityType)";
            var cfActivityKey = "\(activityKey)";
        """

        url = Bundle.main.url(forResource: "index", withExtension: "html", subdirectory: "WebApp")!
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            WebView(url: url, webViewContainer: self, configurationJavaScript: self.configurationJavaScript, auxiliaryJavaScript: self.auxiliaryJavaScript).ignoresSafeArea(.all)
            Button(role: .destructive, action: {
                dismiss()
            }) {
                Label("", systemImage: "xmark.circle.fill")
            }.font(.system(size: 30, weight: .regular)).zIndex(1000)
        }.onDisappear {
            if CogniFitAppDelegate.isiPhone {
                switchToPortrait()
            }
        }.onAppear {
            CogniFitAppDelegate.allowOrientationChanges = true
        }.onDisappear {
            CogniFitAppDelegate.allowOrientationChanges = false
        }
    }

    func switchToLandscape() {
        // iPad is always in landscape, no switching is required
        // and while this is also enforced by the App delegate we make it explicit here too
        guard CogniFitAppDelegate.isiPhone else {
            return
        }

        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        windowScene?.requestGeometryUpdate(.iOS(interfaceOrientations: .landscapeRight))
    }

    func switchToPortrait() {
        // iPad is always in landscape, no switching is required
        // and while this is also enforced by the App delegate we make it explicit here too
        guard CogniFitAppDelegate.isiPhone else {
            return
        }

        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        windowScene?.requestGeometryUpdate(.iOS(interfaceOrientations: .portrait))
    }

    private let clientId: String
    private let accessToken: String
    private let codeVersion: String
    private let configurationJavaScript: String

    /** This Javascript code allows the code within the iframe to call methods in our webview that link to native code. */
    private let auxiliaryJavaScript = """
        if (window === parent) {
            window.addEventListener('message', (event) => {
              var payload = event['data'];
              if (payload.status === 'aborted' || payload.status === 'completed') {
                window.webkit.messageHandlers.cfPartnerApp.postMessage({ action: 'dismiss' }).then().catch();
              } else if (payload.status === 'loaded') {
                window.webkit.messageHandlers.cfPartnerApp.postMessage({ action: 'hasFinishedLoading' }).then().catch();
              } else {
                window.webkit.messageHandlers.cfPartnerApp.postMessage(payload).then().catch();
              }
            });
            window.console.log = function () {
              window.webkit.messageHandlers.cfPartnerApp
                .postMessage({ action: 'printToConsole', message: [...arguments].join(' ') })
                .then()
                .catch();
            };
          } else {
            window.console.log = function () {
              window.parent.postMessage({ action: 'printToConsole', message: [...arguments].join(' ') }, '*');
            };
            var cfPartnerLockOrientation = function (orientation) {
              if (orientation.indexOf('landscape') >= 0) {
                window.parent.postMessage({ action: 'switchToLandscape' }, '*');
              } else if (orientation.indexOf('portrait') >= 0) {
                window.parent.postMessage({ action: 'switchToPortrait' }, '*');
              }
              return Promise.resolve();
            };
            var cfPartnerUnlockOrientation = function () {
              window.parent.postMessage({ action: 'switchToNaturalOrientation' }, '*');
              return Promise.resolve();
            };
        }
    """
    private let url: URL
}

struct ModalWebView_Previews: PreviewProvider {
    static var previews: some View {
        ModalWebView(clientId: "debug", accessToken: "none", codeVersion: "", activityType: "", activityKey: "")
    }
}

struct WebView: UIViewRepresentable {
    init(url: URL, webViewContainer: ModalWebView, configurationJavaScript: String, auxiliaryJavaScript: String) {
        self.url = url
        webView = createWebView(webViewContainer: webViewContainer, configurationJavaScript: configurationJavaScript, auxiliaryJavaScript: auxiliaryJavaScript)
    }

    func makeUIView(context _: Context) -> WKWebView {
        return webView
    }

    func updateUIView(_ webView: WKWebView, context _: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }

    private func createWebView(webViewContainer: ModalWebView, configurationJavaScript: String, auxiliaryJavaScript: String) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        configuration.allowsInlineMediaPlayback = true

        let messageHandler: ScriptMessageHandler? = ScriptMessageHandler(webViewContainer: webViewContainer)
        configuration.userContentController.add(messageHandler!, name: ScriptMessageHandler.Name)

        let configurationScript = WKUserScript(source: configurationJavaScript, injectionTime: .atDocumentStart, forMainFrameOnly: true)
        configuration.userContentController.addUserScript(configurationScript)

        let auxiliaryScript = WKUserScript(source: auxiliaryJavaScript, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        configuration.userContentController.addUserScript(auxiliaryScript)

        if #available(iOS 10.0, *) {
            configuration.mediaTypesRequiringUserActionForPlayback = []
        } else {
            configuration.mediaPlaybackRequiresUserAction = false
        }

        let aWebView = WKWebView(frame: .zero, configuration: configuration)
        aWebView.customUserAgent = kCogniFitUserAgent

        #if DEBUG
            /* WARNING: this setting should be used only in debug builds */
            aWebView.isInspectable = true
        #endif

        return aWebView
    }

    private var url: URL
    private var webView: WKWebView!
}
