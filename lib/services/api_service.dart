import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projet_pfe/utils/constants.dart'; // Make sure to import the Constants file
import 'package:projet_pfe/models/client.dart'; // Example model
import 'package:projet_pfe/models/courier.dart'; // Example model
import 'package:projet_pfe/models/order.dart'; // Example model

class ApiService {
  final String _baseUrl = Constants.apiBaseUrl;

  // ========================== CLIENT ENDPOINTS ==========================

  // GET request to fetch all clients
  Future<List<Client>> getClients() async {
    final response = await http.get(Uri.parse(_baseUrl + Constants.clientsEndpoint));

    if (response.statusCode == Constants.statusCodeOK) {
      List<dynamic> data = json.decode(response.body);
      return data.map((client) => Client.fromJson(client)).toList();
    } else {
      throw Exception(Constants.networkError);
    }
  }

  // POST request to create a new client
  Future<Client> createClient(Client client) async {
    final response = await http.post(
      Uri.parse(_baseUrl + Constants.clientsEndpoint),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(client.toJson()),
    );

    if (response.statusCode == Constants.statusCodeCreated) {
      return Client.fromJson(json.decode(response.body));
    } else {
      throw Exception(Constants.serverError);
    }
  }

  // PUT request to update an existing client
  Future<Client> updateClient(int id, Client client) async {
    final response = await http.put(
      Uri.parse(_baseUrl + Constants.clientsEndpoint + '/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(client.toJson()),
    );

    if (response.statusCode == Constants.statusCodeOK) {
      return Client.fromJson(json.decode(response.body));
    } else {
      throw Exception(Constants.serverError);
    }
  }

  // DELETE request to delete a client
  Future<void> deleteClient(int id) async {
    final response = await http.delete(
      Uri.parse(_baseUrl + Constants.clientsEndpoint + '/$id'),
    );

    if (response.statusCode != Constants.statusCodeOK) {
      throw Exception(Constants.serverError);
    }
  }

  // ========================== COURIER ENDPOINTS ==========================

  // GET request to fetch all couriers
  Future<List<Courier>> getCouriers() async {
    final response = await http.get(Uri.parse(_baseUrl + Constants.couriersEndpoint));

    if (response.statusCode == Constants.statusCodeOK) {
      List<dynamic> data = json.decode(response.body);
      return data.map((courier) => Courier.fromJson(courier)).toList();
    } else {
      throw Exception(Constants.networkError);
    }
  }

  // POST request to create a new courier
  Future<Courier> createCourier(Courier courier) async {
    final response = await http.post(
      Uri.parse(_baseUrl + Constants.couriersEndpoint),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(courier.toJson()),
    );

    if (response.statusCode == Constants.statusCodeCreated) {
      return Courier.fromJson(json.decode(response.body));
    } else {
      throw Exception(Constants.serverError);
    }
  }

  // PUT request to update an existing courier
  Future<Courier> updateCourier(int id, Courier courier) async {
    final response = await http.put(
      Uri.parse(_baseUrl + Constants.couriersEndpoint + '/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(courier.toJson()),
    );

    if (response.statusCode == Constants.statusCodeOK) {
      return Courier.fromJson(json.decode(response.body));
    } else {
      throw Exception(Constants.serverError);
    }
  }

  // DELETE request to delete a courier
  Future<void> deleteCourier(int id) async {
    final response = await http.delete(
      Uri.parse(_baseUrl + Constants.couriersEndpoint + '/$id'),
    );

    if (response.statusCode != Constants.statusCodeOK) {
      throw Exception(Constants.serverError);
    }
  }

  // ========================== ORDER ENDPOINTS ==========================

  // GET request to fetch all orders
  Future<List<Order>> getOrders() async {
    final response = await http.get(Uri.parse(_baseUrl + Constants.ordersEndpoint));

    if (response.statusCode == Constants.statusCodeOK) {
      List<dynamic> data = json.decode(response.body);
      return data.map((order) => Order.fromJson(order)).toList();
    } else {
      throw Exception(Constants.networkError);
    }
  }

  // POST request to create a new order
  Future<Order> createOrder(Order order) async {
    final response = await http.post(
      Uri.parse(_baseUrl + Constants.ordersEndpoint),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(order.toJson()),
    );

    if (response.statusCode == Constants.statusCodeCreated) {
      return Order.fromJson(json.decode(response.body));
    } else {
      throw Exception(Constants.serverError);
    }
  }

  // PUT request to update an existing order
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

  // DELETE request to delete an order
  Future<void> deleteOrder(int id) async {
    final response = await http.delete(
      Uri.parse(_baseUrl + Constants.ordersEndpoint + '/$id'),
    );

    if (response.statusCode != Constants.statusCodeOK) {
      throw Exception(Constants.serverError);
    }
  }
}
