# SignsSpeak: AI-Powered Sign Language Translation

**SignsSpeak** is a real-time, on-device iOS application designed to bridge the communication gap for the Deaf and Hard of Hearing community. By leveraging cutting-edge machine learning and computer vision, SignsSpeak translates American Sign Language (ASL) gestures into text instantly, providing an accessible and intuitive tool for inclusive communication.

---

## 💡 The Motivation
Communication is a fundamental human right, yet millions face barriers every day. SignsSpeak was born out of a desire to create a portable, fast, and private solution that anyone can use on their personal device. By moving from complex desktop setups to a lightweight iOS app, this project demonstrates how mobile technology can be a powerful force for social good.

## 🚀 Core Features
- **Real-Time Inference**: Experience zero-latency translation with 30+ FPS processing.
- **Privacy-First**: All AI processing happens locally on the device—no video data ever leaves your phone.
- **Smart Filtering**: Built-in confidence thresholds (10%+) minimize "flickering" and ensure stable, reliable predictions.
- **Intuitive UI**: A sleek, minimal design with a dynamic blur-based status indicator that keeps the focus on the user's hands.

## 🛠 Tech Stack & Architecture
SignsSpeak is built entirely with Apple’s native frameworks to ensure maximum performance and efficiency:

- **SwiftUI**: A modern, declarative framework used to build a responsive and accessible user interface.
- **Vision Framework**: Utilizes `VNDetectHumanHandPoseRequest` to perform high-fidelity tracking of 21 distinct hand landmarks in real-time.
- **CoreML**: Integrates a custom-trained **Neural Network** (`Model.mlmodel`) that classifies complex hand-pose keypoints into readable characters.
- **AVFoundation**: Manages the high-speed camera session and pixel buffer processing pipeline.

### The Translation Pipeline
1. **Capture**: `AVCaptureVideoDataOutput` streams frames to the controller.
2. **Detection**: The **Vision** framework identifies a hand and extracts a multi-array of 21 keypoints.
3. **Prediction**: The **CoreML** model analyzes the spatial relationships of these points to identify the sign.
4. **Output**: The UI updates dynamically, showing the character and the AI's confidence level.

## 📋 Requirements
- **Platform**: iOS 18.1+ (optimized for the latest Apple Silicon)
- **Device**: iPhone or iPad
- **Software**: Swift Playgrounds 4.4+ or Xcode 15.0+

## 📁 Project Structure
- `SignSpeaks.swiftpm/`: The primary source code and assets.
- `SignSpeaks.swiftpm/Resources/Model.mlmodel`: The custom-trained AI engine.
- `SignSpeaks.swiftpm.zip`: A portable version of the project for quick distribution.

## 🚦 Getting Started
1. **Download**: Clone this repository or download the `.zip` file.
2. **Open**: Launch the `.swiftpm` file in **Swift Playgrounds** or **Xcode**.
3. **Run**: Tap the "Run" button and grant camera permissions.
4. **Sign**: Position your hand clearly in the frame. The app will automatically begin "Waiting for Sign..." and translate as soon as a gesture is detected.

## 🗺 Future Roadmap
- [ ] **Sentence Construction**: Moving from single-character recognition to full sentence building.
- [ ] **Dynamic Signs**: Adding support for signs that require movement (using Action Classification).
- [ ] **Text-to-Speech**: Integrating `AVSpeechSynthesizer` to read translated signs aloud.
- [ ] **Dark Mode Optimization**: Enhancing the UI for varied lighting conditions.

## 📄 License
This project is **Proprietary**. All rights are reserved by Pratyush Kumar.
- **Personal/Educational Use**: Allowed.
- **Commercial Use/Redistribution**: Prohibited without express written consent.
- See the [LICENSE](LICENSE) file for more details.

---
*Developed with ❤️ as a submission for the Swift Student Challenge.*
