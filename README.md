# CogniFit Partner Demo Apps
Demoes how to do perform a single-sign-on with the CogniFit App, on both iOS and Android.
For these projects to work you must have a partner account.

# Purpose of these Apps
The purpose of these Apps is to provide the simplest reference implementation of a "single sign on" flow between your App and CogniFit's.
Keep in mind: **accessing the API through the App/client is NOT recommended** because it forces you to include your ID and secret in the App itself, which is not secure and, if compromised, would allow an attacker to access **sensitive** data linked to your users. The best practice is to perform all API requests from your servers and provide the App with the information it needs to perform the single-sign-on.

# Known limitations
1 While the App allows you to specify an activity (assessment, training, ...) the CogniFit App will ignore this request, it'll simply perform the SSO. A future release of the CogniFit App will honor this App's request to perform a specific activity;
2 Support for SSO was added to version 4.4.49
