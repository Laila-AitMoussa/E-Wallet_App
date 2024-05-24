# E-Wallet App

Welcome to the E-Wallet App, your personal finance companion! This Flutter application helps you manage your finances effortlessly, providing features for budgeting, expense tracking, and financial insights.

<p align="center">
    <img src="E-wallet_App.gif" width="200" height="400" />
</p>

## Features

- **Splash Screen**: The app starts with a splash screen displaying the logo and app name.
- **Onboarding Pages**: Users are guided through onboarding screens where they learn about the app's features and how to set up their budget.
- **Home Screen**: The main dashboard displays your balance, today's balance, and recent activities. You can add new transactions (income or expenses) and view all activities.
- **All Activities Page**: This page lets you view all transactions and filter them by date using a calendar.
- **Add and Minus Page**: Users can add new transactions, either as income or expenses, with details and amounts.
- **Models**: The app uses [Hive](https://docs.hivedb.dev/#/README) for local database storage. The `WalletModel` class represents each transaction.

## Screenshots

<p align="center">
 <img src="Screenshots/Splash_Screen.png" width="200" height="400" />
 <img src="Screenshots/Onboarding_Screen1.png" width="200" height="400" />
 <img src="Screenshots/Onboarding_Screen2.png" width="200" height="400" />
</p>
<p align="center">
  <img src="Screenshots/Onboarding_Screen3.png" width="200" height="400" />
  <img src="Screenshots/Home_Screen.png" width="200" height="400" />
  <img src="Screenshots/Plus_Screen.png" width="200" height="400" />
</p>
<p align="center">
  <img src="Screenshots/Minus_Screen.png" width="200" height="400" />
  <img src="Screenshots/All_Activities_Screen.png" width="200" height="400" />
  <img src="Screenshots/Dark_Mode.png" width="200" height="400" />
</p>

## Getting Started

To run the E-Wallet app on your local machine, follow these steps:

1. Clone this repository to your local machine.
2. Ensure you have Flutter installed. If not, follow the instructions [here](https://flutter.dev/docs/get-started/install).
3. Open the project in your preferred IDE.
4. Run `flutter pub get` to install dependencies.
5. Connect a device or emulator and run `flutter run` to launch the app.

## Dependencies

- `flutter_bloc`: For state management using the BLoC pattern.
- `hive_flutter`: For local database storage using Hive.
- `intl`: For date formatting.
- `table_calendar`: For displaying a calendar widget.
- `gap`: For adding vertical spacing between widgets.
  
## Contributing

Contributions are welcome! If you have any ideas for new features, improvements, or bug fixes, feel free to open an issue or submit a pull request.
