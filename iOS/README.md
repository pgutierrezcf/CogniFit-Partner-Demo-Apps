# Purpose of these Apps
The purpose of these Apps is to provide the simplest reference implementation of a "single sign on" flow between your App and CogniFit's.
Keep in mind: **accessing the API through the App/client is NOT recommended** because it forces you to include your ID and secret in the App itself, which is not secure and, if compromised, would allow an attacker to access **sensitive** data linked to your users. The best practice is to perform all API requests from your servers and provide the App with the information it needs to perform the single-sign-on.

# Notes on the Info.plist file of the iOS App

The Info.plist file provided with this project is incomplete, you must add:
- COGNIFIT_CLIENT_ID and COGNIFIT_CLIENT_SECRET, these two values are linked to your account. They can be retrieved by logging in to your partner account at [https://cognifit.com](https://cognifit.com)
- COGNIFIT_USER_TOKEN, a user's identifier, it's what you get when creating a new user, see the API call [here](https://cognifitapiv2.docs.apiary.io/#reference/0/user-registration/create-new-user-account).
- A CFBundleURLTypes entry with at least one CFBundleURLSchemes. The URL scheme allows the CogniFit App to communicate with your App. More information [here](https://developer.apple.com/documentation/xcode/defining-a-custom-url-scheme-for-your-app).

The App will run, but not work, until you setup your Info.plist file correctly. A fully configured file looks like this:
```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleURLTypes</key>
    <array>
        <dict>
            <key>CFBundleTypeRole</key>
            <string>Editor</string>
            <key>CFBundleURLSchemes</key>
            <array>
                <string>com.example.myApp</string>
            </array>
        </dict>
    </array>
    <key>COGNIFIT_CLIENT_ID</key>
    <string>YOUR_CLIENT_ID_HERE</string>
    <key>COGNIFIT_CLIENT_SECRET</key>
    <string>YOUR_CLIENT_SECRET_HERE</string>
    <key>COGNIFIT_USER_TOKEN</key>
    <string>SOME_USER_TOKEN_HERE</string>
    <key>LSApplicationQueriesSchemes</key>
    <array>
        <string>cognifit.app.normal</string>
    </array>
</dict>
</plist>
```
