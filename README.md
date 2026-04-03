# SignSpeaks-1: AI-Powered Sign Language Translation

**SignSpeaks-1** is a real-time, on-device application designed to bridge the communication gap for the Deaf and Hard of Hearing community. By leveraging cutting-edge machine learning and computer vision, SignSpeaks-1 translates American Sign Language (ASL) gestures into text instantly on **iPhone, iPad, and Mac**.

---

## 💡 The Motivation
Communication is a fundamental human right, yet millions face barriers every day. SignSpeaks-1 was born out of a desire to create a portable, fast, and private solution that anyone can use on their personal device. By utilizing Apple's native ecosystem, this project demonstrates how mobile and desktop technology can be a powerful force for social good.

## 🚀 Core Features
- **Multi-Platform Support**: Runs natively on **iOS, iPadOS, and macOS** (Apple Silicon).
- **Real-Time Inference**: Experience zero-latency translation with 30+ FPS processing.
- **Privacy-First**: All AI processing happens locally on the device—no video data ever leaves your hardware.
- **Smart Filtering**: Built-in confidence thresholds minimize "flickering" and ensure stable predictions.
- **Modern UI**: A sleek, minimal design with a dynamic blur-based status indicator.

## 🛠 Tech Stack & Architecture
SignSpeaks-1 is built entirely with Apple’s native frameworks:

- **SwiftUI**: For a responsive, cross-platform user interface.
- **Vision Framework**: Uses `VNDetectHumanHandPoseRequest` to track 21 distinct hand landmarks.
- **CoreML**: Integrates a custom-trained **Neural Network** (`Model.mlmodel`) for pose classification.
- **AVFoundation**: Manages high-speed camera sessions across mobile and desktop hardware.

## 📋 Requirements
- **OS**: iOS 18.1+ / macOS 15.0+ (Sequoia)
- **Hardware**: iPhone, iPad, or Mac with Apple Silicon (M1/M2/M3/M4).
- **Software**: **Swift Playgrounds 4.4+** or **Xcode 15.0+**.

## 🚦 How to Run & Install
Since this is a `.swiftpm` (Swift Package Manager) project, you can run it without complex "sideloading" tools:

### On Mac (Easiest)
1. Download this repository or the `SignSpeaks.swiftpm.zip` file.
2. Double-click `SignSpeaks.swiftpm`. It will open in **Swift Playgrounds** or **Xcode**.
3. Click the **Run** button. Grant camera permissions when prompted.

### On iPhone & iPad
1. **Using Swift Playgrounds**: Transfer the `.swiftpm` file to your device (via AirDrop or iCloud Drive). Open it in the **Swift Playgrounds app** and tap Run.
2. **Using Xcode**:
   - Connect your iPhone/iPad to your Mac.
   - Open `SignSpeaks.swiftpm` in Xcode.
   - Select your device as the run target.
   - Go to **Settings > General > VPN & Device Management** on your iPhone to "Trust" your developer profile if prompted.

## 🗺 Future Roadmap
- [ ] **Indian Sign Language (ISL)**: Expanding the model to support ISL gestures.
- [ ] **Cross-Platform**: Bringing the core logic to **Android** and **Windows**.
- [ ] **Sentence Construction**: Moving from single characters to full sentences.
- [ ] **Text-to-Speech**: Integrating `AVSpeechSynthesizer` for audio output.

## 📄 License
This project is **Proprietary**. All rights are reserved by Pratyush Kumar.
- **Personal/Educational Use**: Allowed.
- **Commercial Use/Redistribution**: Prohibited without express written consent.
- See the [LICENSE](LICENSE) file for more details.

---
*Developed with ❤️ as a submission for the Swift Student Challenge.*
