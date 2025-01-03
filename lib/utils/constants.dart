// utils/constants.dart

class Constants {
  // API Base URL
  static const String apiBaseUrl = 'http://192.168.1.12:3000/api';

  // Endpoints
  static const String clientsEndpoint = '/clients';
  static const String couriersEndpoint = '/courier';
  static const String ordersEndpoint = '/orders';

  // HTTP Status Codes
  static const int statusCodeOK = 200;
  static const int statusCodeCreated = 201;
  static const int statusCodeBadRequest = 400;
  static const int statusCodeUnauthorized = 401;
  static const int statusCodeNotFound = 404;
  static const int statusCodeServerError = 500;

  // Error Messages
  static const String networkError = 'Network error. Please try again later.';
  static const String serverError = 'Server error. Please try again later.';
  static const String invalidDataError = 'Invalid data received from the server.';
  static const String clientError = 'Client not found. Please check the details.';
  static const String unknownError = 'An unknown error occurred.';

  // User Messages
  static const String loading = 'Loading...';
  static const String saving = 'Saving...';
  static const String success = 'Operation successful!';
  static const String failure = 'Operation failed. Please try again.';

  // Form Validation Messages
  static const String emailRequired = 'Email is required.';
  static const String emailInvalid = 'Invalid email address.';
  static const String phoneNumberRequired = 'Phone number is required.';
  static const String phoneNumberInvalid = 'Invalid phone number.';
  static const String nameRequired = 'Name is required.';
}

