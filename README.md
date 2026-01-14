# Random Image App 📸

A sleek, responsive mobile application built with Flutter that fetches random images from an API and dynamically adapts its UI based on the image's colors for an immersive user experience.

## ✨ Features

- **Random Image Fetching**: Retrieves high-quality images from the Unsplash-powered API.
- **Dynamic Immersive Background**: The background color automatically transitions to match the dominant color of the current image.
- **Premium UX/UI**:
    - Smooth 500ms fade-in transitions for images.
    - Animated background color shifts.
    - Responsive square image frame with soft shadows.
- **Robust Performance**:
    - Instant image display with asynchronous color extraction.
    - URL optimization for fast thumbnail processing.
    - Advanced caching using `CachedNetworkImage`.
- **Accessibility & Polish**:
    - Full support for Light and Dark modes.
    - Screen reader-friendly with Semantic tags.
    - Graceful error handling and loading states.

## 🛠️ Technology Stack

- **Framework**: [Flutter](https://flutter.dev/)
- **State Management**: [flutter_bloc](https://pub.dev/packages/flutter_bloc) (BLoC Pattern)
- **Networking**: [Dio](https://pub.dev/packages/dio)
- **Color Extraction**: [palette_generator](https://pub.dev/packages/palette_generator)
- **Image Handling**: [cached_network_image](https://pub.dev/packages/cached_network_image)
- **Dependency Injection**: [get_it](https://pub.dev/packages/get_it)

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (Stable channel)
- Android Studio / VS Code with Flutter extension
- An active Internet connection

### Installation
1. Clone the repository:
   ```bash
   git clone [REPLACE_WITH_YOUR_REPO_URL]
   ```
2. Navigate to the project directory:
   ```bash
   cd mobile_engineer_assignment
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. (Optional) For iOS, install pods:
   ```bash
   cd ios && pod install && cd ..
   ```
5. Run the app:
   ```bash
   flutter run
   ```

## 📖 API Reference

- **Endpoint**: `GET https://november7-730026606190.europe-west1.run.app/image/`
- **Response Format**:
  ```

## ⚠️ Known Issues / Notes for Reviewers

- **Stale External Links**: Some image URLs returned by the API may occasionally return a **404 error** from Unsplash (e.g., `photo-1504198266285-165a9f3539a5`). This occurs when the source image has been removed or the link has expired on Unsplash's end.
- **Graceful Handling**: The app is designed to handle these cases gracefully. If an image is unavailable, a custom error UI is displayed, and the background adapts to a neutral default. Users can simply tap **"Another"** to fetch a fresh, active image.

## 🎥 App Usage Demo
*[Please replace this line with a link to your recorded video or embed it here]*

---
*Built for the Mobile Engineer Technical Assignment.*

https://github.com/user-attachments/assets/86f03048-3ede-42e9-b21a-ece737d76e99
