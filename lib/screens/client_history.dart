import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projet_pfe/screens/track_delivery.dart';
import 'package:projet_pfe/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/order.dart';

class ClientHistory extends StatefulWidget {
  @override
  _ClientHistoryState createState() => _ClientHistoryState();
}

class _ClientHistoryState extends State<ClientHistory> {
  late Future<List<Order>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _ordersFuture = _fetchClientOrders();
  }

  Future<List<Order>> _fetchClientOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');

    if (userDataString == null) {
      throw Exception('User data not found in SharedPreferences.');
    }

    Map<String, dynamic> userData = jsonDecode(userDataString);
    int clientId = userData['id'];

    ApiService apiService = ApiService();
    return await apiService.getOrdersByClientId(clientId);
  }

  void _showOrderDetailsModal(Order order) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Order Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ListTile(
              title: Text('Order ID'),
              subtitle: Text('${order.id}'),
            ),
            ListTile(
              title: Text('Date'),
              subtitle: Text('${order.date}'),
            ),
            ListTile(
              title: Text('Status'),
              subtitle: Text('${order.status}'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Close the modal
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Navigate to TrackDeliveryScreen with order.id
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TrackDeliveryScreen(orderId: order.id ?? 1),
                  ),
                );
              },
              child: Text('Track Delivery'),
            ),
          ],
        ),
      );
    },
  );
}


  Widget _buildOrderList(List<Order> orders) {
    return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: ListTile(
            title: Text('Order #${order.id}'),
            subtitle: Text('Date: ${order.date}'),
            trailing: Text('${order.status}'),
            onTap: () {
              _showOrderDetailsModal(order);
            },
          ),
        );
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Text(
        'Error: $error',
        style: TextStyle(color: Colors.red, fontSize: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Client Order History'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFD7433C),
              Color(0xFFDD5E58),
              Colors.white,
            ],
          ),
        ),
        child: FutureBuilder<List<Order>>(
          future: _ordersFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildLoadingIndicator();
            } else if (snapshot.hasError) {
              return _buildErrorWidget(snapshot.error.toString());
            } else if (snapshot.hasData) {
              final orders = snapshot.data!;
              return orders.isEmpty
                  ? Center(
                      child: Text(
                        'No orders found.',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : _buildOrderList(orders);
            } else {
              return Center(
                child: Text(
                  'Unexpected error occurred.',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
