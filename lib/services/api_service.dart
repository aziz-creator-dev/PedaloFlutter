import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projet_pfe/utils/constants.dart';
import 'package:projet_pfe/models/client.dart';
import 'package:projet_pfe/models/courier.dart';
import 'package:projet_pfe/models/order.dart';

class ApiService {
  final String _baseUrl = Constants.apiBaseUrl;

  // ========================== CLIENT ENDPOINTS ==========================

  Future<List<Client>> getClients() async {
    final response =
        await http.get(Uri.parse(_baseUrl + Constants.clientsEndpoint));

    if (response.statusCode == Constants.statusCodeOK) {
      List<dynamic> data = json.decode(response.body);
      return data.map((client) => Client.fromJson(client)).toList();
    } else {
      throw Exception(Constants.networkError);
    }
  }

  Future<Client> createClient(String email, String phoneNumber) async {
    print('Sending request to create client:');
    print('Email: $email');
    print('Phone Number: $phoneNumber');

    final response = await http.post(
      Uri.parse(_baseUrl + Constants.clientsEndpoint),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'tel': phoneNumber,
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == Constants.statusCodeCreated) {
      print('Client created successfully!');

      var responseData = json.decode(response.body);

      if (responseData != null && responseData['id'] != null) {
        return Client.fromJson(responseData);
      } else {
        throw Exception(
            'Client creation failed: Missing client ID in response');
      }
    } else {
      print(
          'Error: Failed to create client. Status code: ${response.statusCode}');
      throw Exception('Server error: ${response.statusCode}');
    }
  }

  Future<Client> updateClient(int id, Client client) async {
    print("Updating client with ID: $id");
    print("Client data: ${client.toJson()}");

    final response = await http.put(
      Uri.parse(_baseUrl + Constants.clientsEndpoint + '/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(client.toJson()),
    );

    print("Response status code: ${response.statusCode}");

    if (response.statusCode == Constants.statusCodeOK) {
      print("Client update successful, response body: ${response.body}");

      return Client.fromJson(json.decode(response.body));
    } else {
      print("Error updating client, response body: ${response.body}");

      throw Exception(Constants.serverError);
    }
  }

  Future<void> deleteClient(int id) async {
    final response = await http.delete(
      Uri.parse(_baseUrl + Constants.clientsEndpoint + '/$id'),
    );

    if (response.statusCode != Constants.statusCodeOK) {
      throw Exception(Constants.serverError);
    }
  }

  Future<Client> getClientByPhone(String phoneNumber) async {
    final response = await http.get(
      Uri.parse(_baseUrl + Constants.clientsEndpoint + '/phone/$phoneNumber'),
    );

    if (response.statusCode == Constants.statusCodeOK) {
      var data = json.decode(response.body);
      return Client.fromJson(data);
    } else {
      throw Exception('Client not found');
    }
  }

  // ========================== COURIER ENDPOINTS ==========================

  Future<List<Courier>> getCouriers() async {
    final response =
        await http.get(Uri.parse(_baseUrl + Constants.couriersEndpoint));

    if (response.statusCode == Constants.statusCodeOK) {
      List<dynamic> data = json.decode(response.body);
      return data.map((courier) => Courier.fromJson(courier)).toList();
    } else {
      throw Exception(Constants.networkError);
    }
  }

  Future<Courier> createCourier(String email, String phoneNumber) async {
    print('Sending request to create courier:');
    print('Email: $email');
    print('Phone Number: $phoneNumber');

    final response = await http.post(
      Uri.parse(_baseUrl + Constants.couriersEndpoint),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'tel': phoneNumber,
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == Constants.statusCodeCreated) {
      print('Courier created successfully!');

      var responseData = json.decode(response.body);

      if (responseData != null && responseData['id'] != null) {
        return Courier.fromJson(responseData);
      } else {
        throw Exception(
            'Courier creation failed: Missing courier ID in response');
      }
    } else {
      print(
          'Error: Failed to create courier. Status code: ${response.statusCode}');
      throw Exception('Server error: ${response.statusCode}');
    }
  }

  Future<Courier> updateCourier(int id, Courier courier) async {
    final courierJson = courier.toJson();

    print('Request Body: ${json.encode(courierJson)}');

    final response = await http.put(
      Uri.parse(_baseUrl + Constants.couriersEndpoint + '/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(courierJson),
    );

    if (response.statusCode == Constants.statusCodeOK) {
      return Courier.fromJson(json.decode(response.body));
    } else {
      throw Exception(Constants.serverError);
    }
  }

  Future<void> deleteCourier(int id) async {
    final response = await http.delete(
      Uri.parse(_baseUrl + Constants.couriersEndpoint + '/$id'),
    );

    if (response.statusCode != Constants.statusCodeOK) {
      throw Exception(Constants.serverError);
    }
  }

  Future<Courier> getCourierByPhone(String phoneNumber) async {
    final response = await http.get(
      Uri.parse(_baseUrl + Constants.couriersEndpoint + '/phone/$phoneNumber'),
    );

    if (response.statusCode == Constants.statusCodeOK) {
      var data = json.decode(response.body);
      return Courier.fromJson(data);
    } else {
      throw Exception('Courier not found');
    }
  }

  Future<bool> checkNullFields(int id) async {
    final response = await http.get(
      Uri.parse(_baseUrl + Constants.couriersEndpoint + '/checknull/$id'),
    );

    if (response.statusCode == Constants.statusCodeOK) {
      var data = json.decode(response.body);
      if (data['hasNullFields'] != null) {
        return data['hasNullFields'] as bool;
      } else {
        throw Exception('Unexpected response: Missing "hasNullFields" field');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Courier not found');
    } else {
      throw Exception('Server error: ${response.statusCode}');
    }
  }

  // ========================== ORDER ENDPOINTS ==========================

  Future<List<Order>> getOrders() async {
    final response =
        await http.get(Uri.parse(_baseUrl + Constants.ordersEndpoint));

    if (response.statusCode == Constants.statusCodeOK) {
      List<dynamic> data = json.decode(response.body);
      return data.map((order) => Order.fromJson(order)).toList();
    } else {
      throw Exception(Constants.networkError);
    }
  }

  Future<bool> createOrder(Map<String, dynamic> orderData) async {
    final url = Uri.parse(_baseUrl + Constants.ordersEndpoint);
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(orderData),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        print('Error: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<Order> updateOrder(int id, Order order) async {
    final response = await http.put(
      Uri.parse(_baseUrl + Constants.ordersEndpoint + '/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(order.toJson()),
    );

    if (response.statusCode == Constants.statusCodeOK) {
      return Order.fromJson(json.decode(response.body));
    } else {
      throw Exception(Constants.serverError);
    }
  }

  Future<void> deleteOrder(int id) async {
    final response = await http.delete(
      Uri.parse(_baseUrl + Constants.ordersEndpoint + '/$id'),
    );

    if (response.statusCode != Constants.statusCodeOK) {
      throw Exception(Constants.serverError);
    }
  }

  Future<List<Order>> getOrdersByClientId(int clientId) async {
    final response = await http.get(
      Uri.parse(_baseUrl + Constants.ordersEndpoint + '/client/$clientId'),
    );

    if (response.statusCode == Constants.statusCodeOK) {
      List<dynamic> data = json.decode(response.body);
      return data.map((order) => Order.fromJson(order)).toList();
    } else {
      throw Exception('Failed to fetch orders for client ID $clientId');
    }
  }

  Future<List<Order>> getOrdersByCourierId(int courierId) async {
    final response = await http.get(
      Uri.parse(_baseUrl + Constants.ordersEndpoint + '/courier/$courierId'),
    );

    if (response.statusCode == Constants.statusCodeOK) {
      List<dynamic> data = json.decode(response.body);
      return data.map((order) => Order.fromJson(order)).toList();
    } else {
      throw Exception('Failed to fetch orders for courier ID $courierId');
    }
  }

  Future<bool> updateOrderStatus(int orderId, String status) async {
    final response = await http.put(
      Uri.parse(_baseUrl + Constants.ordersEndpoint + '/$orderId/status'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'status': status}),
    );

    if (response.statusCode == Constants.statusCodeOK) {
      return true;
    } else {
      print('Error updating order status: ${response.body}');
      return false;
    }
  }

  Future<Order> getOrderById(int id) async {
    final response = await http.get(
      Uri.parse(_baseUrl + Constants.ordersEndpoint + '/$id'),
    );

    if (response.statusCode == Constants.statusCodeOK) {
      return Order.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch order with ID $id');
    }
  }
}
