# Pika - Senior iOS Take-Home Task

This repository contains the implementation of the **Pika AI Self Onboarding Flow**. The goal was to create a production-ready, high-fidelity experience focused on performance, modularity, and pixel-perfect design.

## 🚀 Key Features

- **Intelligent Voice Recording**: Real-time "karaoke-style" feedback using `Speech` framework. Highlights text sequentially as the user reads affirmations.
- **Smart Camera & Media**: Background-initialized camera sessions to eliminate lag, with a custom `UIImage` normalization engine to fix EXIF orientation bugs.
- **High-Fidelity UI**: Implemented custom typography (Telka Font Family), 3D-effect ID cards, and micro-animations for a premium feel.

## 🛠 Architecture & Decisions

### MVVM + Coordinator Pattern
The app uses a modular **MVVM** architecture combined with a **Coordinator pattern**. This ensures:
- **Decoupled Navigation**: Views don't know about their siblings; `AppCoordinator` manages the flow via `NavigationPath`.
- **Logic Separation**: Heavy tasks like speech recognition and camera management are delegated to dedicated **Service** layers.

### Performance Optimization
- **Non-blocking UI**: Moved `AVCaptureSession` setup to background threads to prevent the common iOS camera initialization hang.
- **Memory Management**: Automatic session teardown when navigating or picking from the gallery to save battery and CPU.

### Clean Code Standards
- **AppConstants System**: No "Magic Numbers." All design tokens (paddings, radii, font sizes) are centralized in a global namespace.
- **Internal Namespacing**: Every view uses a `private enum Constants` for local strings and layout metrics, making localization and maintenance trivial.

## 🎤 Technical Challenges Resolved

- **Sequential Voice Recognition**: Created a robust algorithm that matches spoken words against target affirmations, ignoring punctuation and casing while providing real-time UI feedback.
- **Audio Output Fix**: Configured `AVAudioSession` to ensure playback occurs through the loud speakers instead of the earpiece.
- **UIImage Orientation**: Implemented a bitmap redraw utility to ensure consistency between camera captures and gallery uploads.

## 📦 Requirements
- iOS 16.0+
- Xcode 14.3+
- Physical device recommended for Camera/Microphone features.

---
*Developed with care as part of the Pika Senior iOS Engineer assessment.*

## 📁 Development History

The project was delivered in two strategic phases, as reflected in the commit history:
- **Phase 1 (Initial Commit)**: Implementation of the core **Onboarding** flow and the **Camera/Picture Capture** module.
- **Phase 2 (Final Delivery)**: Implementation of the **Smart Speech Recognition** (Karaoke-style voice recording) and the **Success ID Card** view.

## 💡 Engineering Reflections & Feedback

### Estimation vs. Reality
The initial estimate of 3–5 hours for a flow of this complexity is, in my professional opinion, unrealistic for a high-fidelity, complete implementation. Working with low-level frameworks like **AVFoundation** and **SFSpeechRecognizer** is not a trivial "plug-and-play" task; it requires significant time for research, lifecycle debugging, and precise UI synchronization to ensure a stable user experience. This project took **5+ hours** because I prioritized building a robust foundation rather than a fragile prototype.

### Decisions & Trade-offs
- **Backend & Assets**: Since the backend was noted as "busy," I chose to package all high-res assets (videos, avatars) locally. In a production environment, these would be managed via a CDN/API. The codebase is architected to transition to a remote source with minimal friction.
- **Networking**: I intentionally omitted a `NetworkManager` shell. Without concrete endpoints or data schemas, adding such a file would result in "dead code." The architecture (Service-ViewModel) is ready to implement a network layer when clear requirements exist, following the **YAGNI (You Ain't Gonna Need It)** principle.
- **Typography Integration**: I implemented a centralized `RegistFont` utility to handle the registration and usage of the Telka font family, ensuring a clean and single-entry point for custom styling.