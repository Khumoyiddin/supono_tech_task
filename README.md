## Khumoyiddin Bakhodirov

A technical task for Supono.

# Explanation and justification for Task #2
1) CSS Styling: I'm not sure what's meant by it, but I considered it as for code refactoring or using constants for text styling, colors. So I'm not sure on this one
2) Security: I know what this is, but not sure what to secure. If it was to have more secure storage usage, then I'd have to replace SharedPrefs with DBs such as Hive, but I don't think this is reasonable here, that's why I didn't do this one
3) Recheck your bugs...: Again not sure what exactly meant by it, I mean I did check the app before submission, and re checked after it was mentioned. So I tried to fix the possible errors, but didn't face any bugs that let to crash or violate the logic
4) I have implemented i18n, RTL and arabic. For show case I only did it on 2 screens, splash and settings. There are 2 languages, English and Arabic. Moreoever, I added 'Change language' button in Settings page, so you can test it there as well
5) Input validation was optimizeed and improved as far as I could imagine the proper validation
6) Indexing between fields were fixed
7) Error handling: not sure which errors should be handled, so I did it only in BirthdayScreen
8) Crashlytics working on both iOS and Android simulators, and can be tracked on Firebase Crashlytics console. I left a commneted code in SettingsPage if you wish to test it. On real devices: Android works just fine, while iPhone would not crash but Xcode would give the following crash messaage in the console: Terminating app due to uncaught exception 'FirebaseCrashlyticsTestCrash', reason: 'This is a test crash caused by calling .crash() in Dart.'. So in case you don't see a crash report on iPhone debug mode
9) Responsiveness: It's already responsive, I've tested it on various size mobile devices, and made sure there are no overflowings. Yet, it can be improved, by making the size of the text scalable, for instance if the user's settings for text are larger. But in most cases, one should have a design for that, that's why I don't see it reasonable
10) Documentation: Not sure what to document. Code is simple and easy to follow, because of the good naming of classes and functions. The documentation could be done for Firebase set up, i18n set up, code generation samples. But again didn't see it reasonable

Optimize the following then explain/justify how you did it in a README.md file:

- Memory usage
- CPU usage
- Battery usage
- Network usage

Not sure what to say about Memory usage..., It's a simple app, where there are no heavy operation going on, the only thing that might take some usage in them is Camera operation, and what am I supposed to say here? I don't know what to say.

And the answer for your question: No I don't believe I can make a bug free app, because code is code, and it isn't perfect. I'm talking about the mid and big size apps, where you have several dozens of features and lost count of numbers of files. One can have an app that is optimized after a several lifecycles of testing, but still there are always a way to find a bug, that's not always depends on code, but rather on a specific device platform, version that might be outdated. I mean even when you use the plugins and packages, you can't be 100% sure that it is working bug free, so the reason after all that you have a bug might be not you, but the package owner, and so on. There are plenty of ways there might be a bug.

# My opinion about the technical task
1) The details are very vague. I should have made a research to understand what was meant by it, and even failed to understand some of them (already explained above)
2) The design is very poor, while it's asked later to optimize the input validation. I believe there should be a design for that, error cases...
3) The technical task is asking for too much. Honestly, I'd not do it if I wouldn't get a recommendation from my friend Asadbek. Even after completing all the things that are asked, what is exactly the examiner is trying to check? The ability to use tools, which are common knowledge, or is it how the candidate understands the task that's poorly informed? I understand that there are no tech interviews, but still, 48h+36h are almost 4 working days. If you intend to make them do it, then at least you should pay them a min amount. That's how the may companies do, when they ask to complete a technical task that takes more that 8 hours. Moreover, a candidate at least expects a feedback. Maybe you give one after second task, but it's still neccessary to do it after task 1.
When you ask someone to complete a technical task, you should emphosize on what you're going to judge. Only then the candidate will understand that and try to show case his knowledge. While you just ask to complete the task with poor details, and in task one without any feedback and little information what to do, just ask to optimize and list things to do.
I'm glad you asked this question, because i wanted to mention it to you anyway, in hope for you to help, and not just to complain, an honest feedback :)

Thanks,
Khumoyiddin











# Few words about the work

Inside the code there are a few comments explaining the reason I've made that choice, so I don't want to duplicate it here. Besides, few crucial things must be mentioned:
1) Rate us feature didn't work on either Android simulator or Android real device. As per documentation https://pub.dev/packages/in_app_review#testing-read-carefully, it clearly says that it must be uploadedto the Play Store to test requestReview(), they also recommended an approach to build an app bundle and upload it via internal app sharing, I've tried to upload to internal app sharing, but I don't have a Play Console account, and after several approaches, couldn't succeed to create one.
2) While creating constants for a project, I faced an issue, where there are niether the documentation of text styles in design nor the proper naming convention, therefore I'd to improvise and came up with the solution you can see in the code. I don't usually name them in that way, but I had to stick to some logic, and this one seemed most reasonable
3) I didn't use Bloc or any other state managements, because there is no need for that and the deadline is quite short for the amount of tasks are required for a technical task
4) I didn't separate SharedPrefs usages to a separate file, because I was little tight on time. However I know it wouldn't take much of time, but if I were to refactor it, I would spend some extra time for other parts as well. So shortly, the code can be refactored and cleaned little bit more
5) I didn't use any architecture, because I didn't use any state management, there were no space for architecture. The technical task seemed asking more of skill and paying attention to details rather than architectural thing. Maybe I'm wrong, if so excuse me! 

This was like a cons, and I've explained it, because in the documentation it's written that it on Android Simulator should work fully functional without crashes. Well there are no crashes, but the functionality isn't working.

So now about pros:
1) I've added the error message, and a simple validation on onboarding screens. Again because documentation states '... must ...', but there is no design for it, as a result I've come up with a simple yet effective solution.
2) Tested on both iOS simulator and iPhone. On iPhone everything works perfectly fine, and on simulator everything except camera.
3) Created default states and screens for Camera and Preview pages, which weren't provided in figma design
4) In the documentation, it wasn't mentioned what is supposed to do the read cancel button on Preview page, so I decided to navigate to Settings page and pop up the dialog.
5) It wasn't implicitly said in the documentation that the onboarding screens should split the images in the code, and not exporting them separately from figma. But it was attached to files with Task #1, so I decided to have a big picture being shared among 4 screens.
6) Tried to keep the code clean, by separating extensions, helpers, widgets, buttons, styles and so on... Yet it was difficult to show off the skills, as the desing was lacking concreteness and information.

I beileve this is all I wanted to add, looking forward for a feedback!

Thanks!

# Java version

java version "17.0.8" 2023-07-18 LTS

# flutter doctor -v output
[✓] Flutter (Channel stable, 3.24.4, on macOS 14.6.1 23G93 darwin-arm64, locale
en-UZ)
• Flutter version 3.24.4 on channel stable at /Users/khumoyiddin/flutter
• Upstream repository https://github.com/flutter/flutter.git
• Framework revision 603104015d (4 weeks ago), 2024-10-24 08:01:25 -0700
• Engine revision db49896cf2
• Dart version 3.5.4
• DevTools version 2.37.3

[✓] Android toolchain - develop for Android devices (Android SDK version 34.0.0)
• Android SDK at /Users/khumoyiddin/Library/Android/sdk
• Platform android-34, build-tools 34.0.0
• ANDROID_HOME = /Users/khumoyiddin/Library/Android/sdk
• ANDROID_SDK_ROOT = /Users/khumoyiddin/Library/Android/sdk
• Java binary at: /Applications/Android Studio.app/Contents/jbr/Contents/Home/bin/java
• Java version OpenJDK Runtime Environment (build 17.0.7+0-17.0.7b1000.6-10550314)
• All Android licenses accepted.

[✓] Xcode - develop for iOS and macOS (Xcode 16.1)
• Xcode at /Applications/Xcode.app/Contents/Developer
• Build 16B40
• CocoaPods version 1.15.2

[✓] Chrome - develop for the web
• Chrome at /Applications/Google Chrome.app/Contents/MacOS/Google Chrome

[✓] Android Studio (version 2023.1)
• Android Studio at /Applications/Android Studio.app/Contents
• Flutter plugin can be installed from:
🔨 https://plugins.jetbrains.com/plugin/9212-flutter
• Dart plugin can be installed from:
🔨 https://plugins.jetbrains.com/plugin/6351-dart
• Java version OpenJDK Runtime Environment (build 17.0.7+0-17.0.7b1000.6-10550314)

[✓] VS Code (version 1.77.3)
• VS Code at /Applications/Visual Studio Code.app/Contents
• Flutter extension version 3.100.0

[✓] Connected device (7 available)
• Redmi Note 7 (mobile)           • ab03cadc                             • android-arm64  • Android 10 (API 29)
• sdk gphone64 arm64 (mobile)     • emulator-5554                        • android-arm64  • Android 14 (API 34) (emulator)
• Khumoyiddin’s iPhone (mobile)   • 00008110-000144661E9B801E            • ios            • iOS 18.1.1 22B91
• iPhone 16 Pro (mobile)          • 222DC717-2D98-4765-9098-2E968CCD34E6 • ios            • com.apple.CoreSimulator.SimRuntime.iOS-18-1 (simulator)
• macOS (desktop)                 • macos                                • darwin-arm64   • macOS 14.6.1 23G93 darwin-arm64
• Mac Designed for iPad (desktop) • mac-designed-for-ipad                • darwin         • macOS 14.6.1 23G93 darwin-arm64
• Chrome (web)                    • chrome                               • web-javascript • Google Chrome 131.0.6778.86

[✓] Network resources
• All expected network resources are available.

• No issues found!

[khumoyiddin_bakhodirov_flutter.apk.zip](https://github.com/user-attachments/files/17891323/khumoyiddin_bakhodirov_flutter.apk.zip)

