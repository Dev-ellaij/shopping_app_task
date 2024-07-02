# Flutter Food Delivery App

This is a simple Flutter application for a food delivery service. The app allows users to browse food items, add them to a cart, and proceed to checkout.

## Features

- **Home Page**: Displays categories of food items and a search bar.
- **Food Items**: List of food items displayed in a grid format with details like name, image, cooking time, rating, and price.
- **Cart**: Users can add food items to the cart.
- **Order Confirmation**: Displays a confirmation message with the number of items in the cart upon checkout.

## Getting Started

### Prerequisites

- Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
- Dart SDK: Comes with Flutter SDK

### Installation

1. **Clone the repository:**
    ```sh
    git clone https://github.com/your-username/food-delivery-app.git
    ```
2. **Navigate to the project directory:**
    ```sh
    cd food-delivery-app
    ```
3. **Get the dependencies:**
    ```sh
    flutter pub get
    ```

### Running the App

1. **Run the app on an emulator or physical device:**
    ```sh
    flutter run
    ```

## Project Structure

- `lib/main.dart`: The main entry point of the application.
- `lib/MyApp.dart`: Contains the `MyApp` class which initializes the application.
- `lib/HomePage.dart`: Contains the `HomePage` class which displays the main screen with categories and food items.
- `lib/OrderConfirmationPage.dart`: Contains the `OrderConfirmationPage` class which displays the order confirmation message.
- `lib/HeaderParts.dart`: Contains the `HeaderParts` class which displays the header and categories.
- `lib/ItemsDisplay.dart`: Contains the `ItemsDisplay` class which displays the food items.
- `lib/CheckoutPage.dart`: Contains the `CheckoutPage` class which displays the food details and a checkout button.
- `lib/models/FoodDetail.dart`: Contains the `FoodDetail` class which is a model for food items.

