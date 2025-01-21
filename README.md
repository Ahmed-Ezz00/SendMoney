# Send Money 

## Overview
This project is designed to evaluate my proficiency in iOS development, including UI design, data handling, application state management, and implementation of dynamic features. Built using Swift, it leverages modern architectural patterns and integrates with Core Data for local storage.

---

## Features
- **User Authentication:** Secure login system using email and password.
- **Send Money:** Easily transfer money to selected providers.
- **Request List:** View and manage requests.
- **Multi-Language Support:** Localized strings for multiple languages.

---

## Requirements
- **iOS Version:** iOS 13.0 or later
- **Xcode Version:** Xcode 14.0 or later
- **Swift Version:** Swift 5.7

---

## Setup Instructions
1. **Clone the Repository:**
   git clone [https://github.com/Ahmed-Ezz00/SendMoney]
   
2. **Open the Project:**
   Open the `.xcodeproj` file in Xcode.

3. **Build and Run:**
   - Select the appropriate scheme.
   - Press `Cmd + R` to build and run the project on a simulator or a physical device.

---

## Architecture
The app is using MVVM
- Model: Represents the data and the core business logic of the application. It is responsible for handling data-related tasks such as fetching, storing, and managing data
- View: Component that deals with the user interface. It displays information to the user and responds to user interactions
- ViewModel: Serves as a mediator between the View and the Model. It retrieves data from the Model, processes it if necessary (e.g., formatting or filtering), and provides it to the View in a format that is ready for display. It also handles user input by passing commands from the View back to the Model

---

## Localizations
The app supports the following languages:
- English (default)
- Arabic

---

## Testing
1. **Unit Tests:**
   - Run all unit tests using:
     ```bash
     Cmd + U
     ```
   - Located in the `SendMoneyTests` directory.

---

## Contact
For questions or support, contact:
- **Email:** [Ahmed.ezz.0093@gmail.com]

