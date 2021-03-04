# Rithm Mobile App
A Flutter project for Rithm School's student information system(sis). 

![](gif.gif)

## Potential improvements to be made
- Add tests.
- Edit user profile from the mobile app (An icon for profile already exist in the drawer).
- User authentication functionalities. 
- Backend api for filtering for a specific cohort. Student account tied to a specific cohort. 
- Dropdown filter for type on Homepage.
- Setup staff profile image from aws s3(image links currently hardcoded), needs access to aws.

## Setup
- Install Flutter, Xcode, and Android Studio. Follow instructions in the link below.
https://flutter.dev/docs/get-started/install/macos
- Git clone this repository.
- Go into your prefered code editor, click on either Start Debugging/Run without debugging.
- If using vscode, install Flutter from marketplace.

## Common issues running Flutter
- Xcode not starting properly
  - try running `Flutter clean` to clear cache.
- The sandbox is not in sync with the Podfile.lock. Run 'pod install' or update your CocoaPods installation
  - in project folder, `cd ios`, `pod install`, then restart the app 

## Key Takeaways / Decision for the stack
- We wanted to experience a typed language(Dart) to better understand the benefits of compile-time error checking.
- Dart is fairly easy to pick up with some knowledge in JavaScript, Python and/or Java.
- Flutter is cross-platform and allows for developing andriod and ios mobile apps in one codebase.
- One challenge we faced in the beginning was to understand how the widgets work with each other. Once we got over the learning curve, widgets were easy to work with as a unified model.  

## For Reference
A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
