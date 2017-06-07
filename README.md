# iOS-camera-button
A button that behave the same way as the video camera button in the iOS camera

# Preview
![Button preview](https://github.com/otusweb/iOS-camera-button/blob/master/camerabutton.gif?raw=true)

# installation
## Using cocoapod
`pod 'iOS-Camera-Button', :git => 'https://github.com/otusweb/iOS-camera-button.git'`

## Manually
copy cameraButton.swift to your project

# usage
## storyboard
- add a button to your view
- in the "Identity Inspector" in xCode, change the class to "CameraButton"
- add constraint for the placement of the button
- no need to add a height and width contraint, those are added automatically (66*66)

# License
iOS-Camera-Button is available under MIT license, see the license file for details