# Google Maps SDK for iOS

This pod contains the Google Maps SDK for iOS and the Google Places API for iOS,
supporting both Objective C and Swift.

*   Use the [Google Maps SDK for iOS]
    (https://developers.google.com/maps/documentation/ios-sdk/) to enrich your
    app with interactive maps and immersive street view panoramas, and add your
    own custom elements such as markers, windows and polylines.
*   Use [Google Places API for iOS]
    (https://developers.google.com/places/ios-api/) for exciting features based
    on the user's location and Google's Places database. You can enable users to
    add a place, autocomplete place names, use a place picker widget, identify
    the user's current place or retrieve full details about a place.

# Getting Started

*   *Guides*: Read our Getting started guides for Google [Maps SDK for iOS]
    (https://developers.google.com/maps/documentation/ios-sdk/intro) and the
    Google [Places API for iOS]
    (https://developers.google.com/places/ios-api/start).
*   *Demo Videos*: View pre-recorded online demos for [Google Maps SDK for iOS]
    (https://developers.google.com/maps/documentation/ios-sdk/?hl=en) and the
    [Places API for iOS](https://devsite.googleplex.com/places/ios-api/#demos).
*   *Code samples*: In order to our SDK Demo app, use

    ```
    $ pod try GoogleMaps
    ```

    and follow the instructions on our [developer pages]
    (https://developers.google.com/maps/documentation/ios-sdk/code-samples).

*   *Support*: Find support from various channels and communities.

    *   Support pages for [Maps SDK]
        (https://developers.google.com/maps/documentation/ios-sdk/support),
        [Places API](https://developers.google.com/places/support).
    *   Stack Overflow, using the [google-places-api]
        (https://stackoverflow.com/questions/tagged/google-places-api) and
        [google-maps](https://stackoverflow.com/questions/tagged/google-maps)
        tags
    *   [Google Maps APIs Premium Plan]
        (https://developers.google.com/maps/premium/support) customers have
        access to business-level support through Google's [Enterprise Support
        Portal](https://google.secure.force.com/)

*   *Report issues*: Use our issue tracker to [file a bug]
    (https://code.google.com/p/gmaps-api-issues/issues/entry?template=Maps%20SDK%20for%20iOS%20-%20Bug)
    or a [feature request]
    (https://code.google.com/p/gmaps-api-issues/issues/entry?template=Maps%20SDK%20for%20iOS%20-%20Feature%20Request)

# Installation

To integrate Google Maps and Google Places into your Xcode project using
CocoaPods, specify it in your `Podfile`:

```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '7.0'
pod 'GoogleMaps'
```

Then, run the following command:

```
$ pod install
```

Before you can start using the APIs, you have to activate them in the [Google
Developer Console](https://console.developers.google.com/) and integrate the
respective API key in your project. For detailed installation instructions,
visit Google's Get Started Guides, for the [Maps SDK]
(https://developers.google.com/maps/documentation/ios-sdk/start) and [Places
API](https://developers.google.com/places/ios-api/start).

# License and Terms of Service

By using the Google Maps SDK and Places API, you accept Google's Terms of
Service and Policies. Pay attention particularly to the following aspects:

*   Depending on your app and use case, you may be required to display
    attribution. Read more here for [Maps SDK]
    (https://developers.google.com/maps/documentation/ios-sdk/intro#attribution_requirements)
    and for [Places API]
    (https://developers.google.com/places/ios-api/attributions).
*   Your API usage is subject to quota limitations. Read more about usage limits
    for [Maps SDK](https://developers.google.com/maps/pricing-and-plans/) and
    for [Places API](https://developers.google.com/places/ios-api/usage).
*   The [Terms of Service](https://developers.google.com/maps/terms) are a
    comprehensive description of the legal contract that you enter with Google
    by using the Google Maps SDK for iOS. You may want to pay special attention
    to [section 10]
    (https://developers.google.com/maps/terms#10-license-restrictions), as it
    talks in detail about what you can do with the APIs, and what you can't.
