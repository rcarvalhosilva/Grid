fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios coverage
```
fastlane ios coverage
```
Runs coverage
### ios open_release
```
fastlane ios open_release
```
Create release PR from Develop to Master. Run this locally
### ios pre_deploy
```
fastlane ios pre_deploy
```
Prepare Deploy to CocoaPods
### ios deploy
```
fastlane ios deploy
```


----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
