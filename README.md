# Weather App

A Flutter weather app that fetches weather data from a public API and displays it in a user-friendly interface.

#Install Process

- First download the apk file from '/apk_file' folder
- If install from unknown source not enable than enable it from settings
- Than open it with package installer
- than install it

# Features

- Display current weather conditions (temperature, weather description, wind speed, humidity, etc.)
- Show a 3-day weather forecast
- Automatically determine the user's location
- Toggle between Celsius and Fahrenheit
- Persist weather data for offline viewing

#Screenshots

![location_permission](https://github.com/user-attachments/assets/307399b0-c4ac-42b6-b356-9c14461043a0)
![home_screen](https://github.com/user-attachments/assets/253131fc-978c-4fc1-aa3c-f7a2dce49afb)

# Setup

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/weather_app.git
   ```

2. Navigate to the project directory:
   ```
   cd weather_app
   ```

3. Install dependencies:
   ```
   flutter pub get
   ```

4. API key:
   Using OpenWeatherMap API key for API Call.

5. Run the app:
   ```
   flutter run
   ```

# Dependencies

- http: For making API requests
- provider: For state management
- geolocator: For getting the user's location
- shared_preferences: For local data persistence
- intl: For date formatting
- connectivity_plus: check network connectivity
- Sqlite: Local storage for storing weather data offline

# Architecture

This app follows the MVC (Model-View-Controller) architecture:

- Models: Defined in `lib/models/`
- Views: UI components in `lib/views/`
- Controllers: Business logic in `lib/controllers/`

# Others

This app has
- helper: Define in ‘lib/helper/’ for Database helper
- services: for define weather and location service

# Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

# License

This project is open source and available under the [MIT License](LICENSE).

