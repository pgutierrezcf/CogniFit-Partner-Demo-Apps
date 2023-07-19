# CogniFit Partner Demo Apps
Demoes how to do perform a single-sign-on (SSO) with the CogniFit App, on both iOS and Android.
For these projects to work you must have a partner account.

# Android Demo App - coming soon
The Android version is coming soon. In the meantime you can test the SSO with Android Debug Bridge ( [adb](https://developer.android.com/studio/command-line/adb) ). You can issue this command to perform the SSO:
```
adb shell am start -a android.intent.action.VIEW -c android.intent.category.DEFAULT \ 
-d 'com.cognifit.app://sso?token=TTTTTT\&clientId=CCCCCCC\&callbackUrlScheme=com.cognifit.partnerdemo' com.cognifit.app
```
Using a valid user token and your clientId (see iOS App README for more information on how to get these values).

# Purpose of these Apps
The purpose of these Apps is to provide the simplest reference implementation of a "single sign on" flow between your App and CogniFit's.
Keep in mind: **accessing the API through the App/client is NOT recommended** because it forces you to include your ID and secret in the App itself, which is not secure and, if compromised, would allow an attacker to access **sensitive** data linked to your users. The best practice is to perform all API requests from your servers and provide the App with the information it needs to perform the single-sign-on.

# Integration models
We offer sample code for two different integration models:
1. Launch the CogniFit App: currently the App will simply log the user, the recommended activity is not automatically launched. With this limitation this is useful for partner accounts that act as researchers or healthcare professionals, in these cases users do have pre-defined activities so the single-sign on is enough to put the user in the right track.
2. Run the CogniFit code inside a webview. We offer a very basic demonstration on how to load our code in a webview. The native webview should:
    * set a **user-agent** for a mobile browser and **append** the word "cfembedded". This is **very** important as it allows our code to correctly identify the context where it's being run: a mobile-like browser;
    * be a *fullscreen* webview. This is critical on phones, we need the whole screen for the best user-experience;
    * pass the clientId, access token, and desired mode of operation to the web context;
    * listen to requests of the CogniFit code to lock the orientation in landscape/portrait. In tablets our code is designed to run in landscape, in phones the code requires different orientations depending on the activity/context - for example, when the pre-assessment questionnaire is presented the interface should be in portrait, and while running a game it should be in landscape -.
    * listen to the 'dismiss' message, fired when the user wants to exit or when they finish an activity.

On iOS these tasks are handled by WKUserScript and WKScriptMessageHandler objects.

# Known limitations
1. If your App launches the CogniFit App you can specify an activity (assessment, training, ...) **BUT** the CogniFit App will ignore this request, it'll simply perform the SSO. A future release of the CogniFit App will honor the App's request to perform a specific activity.
2. Support for SSO was added to version 4.4.49 (iOS) and 4.4.50 (Android)
3. These Apps are provided 'as is', they are just a starting point for your own development.

# A note on user tokens
Tokens can only be used once, they are *consumed* by the login process. This means you must create a new token for every 'single sign-on' attempt.
