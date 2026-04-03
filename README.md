# SignsSpeak

SignsSpeak is an AI-powered iOS application designed to recognize and translate hand signs in real-time. By leveraging Apple's **Vision** framework for hand pose detection and a custom **CoreML** model, the app provides an interactive way to bridge communication gaps using sign language.

## 🚀 Features
- **Real-time Recognition**: Captures and processes video frames instantly to detect hand gestures.
- **Hand Pose Detection**: Uses `VNDetectHumanHandPoseRequest` to track keypoints on the user's hand.
- **AI Classification**: Integrates a custom `.mlmodel` to classify poses into letters or signs.
- **Confidence Feedback**: Displays the predicted sign along with a confidence percentage (filtering out low-confidence results for stability).
- **Modern UI**: Features a sleek, camera-centric interface with a dynamic blur-based status indicator.

## 🛠 Tech Stack
- **SwiftUI**: For the modern, declarative user interface.
- **Vision Framework**: For high-performance hand pose estimation.
- **CoreML**: For on-device machine learning inference.
- **AVFoundation**: For camera session management and frame capture.

## 📋 Requirements
- **Platform**: iOS 18.1 or later.
- **Device**: iPhone or iPad with camera support.
- **Permissions**: Requires Camera access (`NSCameraUsageDescription`).

## 📁 Repository Structure
- `SignSpeaks.swiftpm/`: The complete Swift Playgrounds project package.
- `SignSpeaks.swiftpm.zip`: A compressed archive of the project for easy sharing.
- `README.md`: Project documentation.

## 🚦 Getting Started
1. Open the `SignSpeaks.swiftpm` package in **Swift Playgrounds** or **Xcode**.
2. Grant camera permissions when prompted.
3. Position your hand in front of the camera to start signing!
