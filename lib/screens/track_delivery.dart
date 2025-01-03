import 'package:flutter/material.dart';
import 'package:projet_pfe/services/api_service.dart'; 
import 'package:projet_pfe/models/order.dart'; 

class TrackDeliveryScreen extends StatefulWidget {
  final int orderId;

  TrackDeliveryScreen({required this.orderId});

  @override
  _TrackDeliveryScreenState createState() => _TrackDeliveryScreenState();
}

class _TrackDeliveryScreenState extends State<TrackDeliveryScreen> {
  late Future<Order> _order;
  
  @override
  void initState() {
    super.initState();
    ApiService apiService = ApiService();
    _order = apiService.getOrderById(widget.orderId); // Corrected the call to apiService
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Track Delivery',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD7433C), Color(0xFFDD5E58), Colors.white],
          ),
        ),
        child: FutureBuilder<Order>(
          future: _order,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return Center(child: Text('Order not found.'));
            } else {
              Order order = snapshot.data!;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Order ID Display
                    Text(
                      'Order ID: ${order.id}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),

                    _buildStatusTrack(order.status ?? 'Pending'),
                    SizedBox(height: 40),

                    _buildOrderDetails(order),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildStatusTrack(String status) {
    List<String> statuses = ['Pending', 'In Transit', 'Delivered'];
    int currentStatusIndex = statuses.indexOf(status);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: statuses.map((statusText) {
        int statusIndex = statuses.indexOf(statusText);
        Color statusColor;
        Icon statusIcon;

        if (statusIndex <= currentStatusIndex) {
          statusColor = Colors.green;
          statusIcon = Icon(Icons.check_circle, color: statusColor);
        } else {
          statusColor = Colors.grey;
          statusIcon = Icon(Icons.radio_button_unchecked, color: statusColor);
        }

        return Column(
          children: [
            statusIcon,
            SizedBox(height: 8),
            Text(
              statusText,
              style: TextStyle(
                color: statusColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildOrderDetails(Order order) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Details',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            _buildDetailRow('From:', order.pickupAddress ?? 'Tunis'),
            _buildDetailRow('To:', order.deliveryAddress ?? 'Ariana'),
            _buildDetailRow('Total Price:', '20 TND'),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$label ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
