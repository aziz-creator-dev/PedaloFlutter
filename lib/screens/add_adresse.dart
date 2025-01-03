import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart' hide Marker;
import 'package:projet_pfe/models/order.dart';
import 'package:projet_pfe/screens/client_home.dart';
import 'package:projet_pfe/screens/track_delivery.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:projet_pfe/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddAddress extends StatefulWidget {
  final int courierId;
  final DateTime date;
  final String type;

  const AddAddress({
    Key? key,
    required this.courierId,
    required this.date,
    required this.type,
  }) : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  String selectedMethod = 'manual';
  TextEditingController shippingController = TextEditingController();
  TextEditingController billingController = TextEditingController();

  bool isLoading = false;
  bool isSuccess = false;
  bool isError = false;

  LatLng _markerPosition = LatLng(51.5074, -0.1278);

  Future<void> createOrder() async {
    setState(() {
      isLoading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');

    if (userDataString != null) {
      try {
        Map<String, dynamic> userData = jsonDecode(userDataString);
        int clientId = userData['id'];
        if (clientId == 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Client ID not found!')),
          );
          setState(() {
            isLoading = false;
          });
          return;
        }
        // Prepare order data
        Map<String, dynamic> orderData = {
          'client_id': clientId,
          'courier_id': widget.courierId,
          'pickup_address': shippingController.text,
          'delivery_address': billingController.text,
          'status': 'pending',
          'date': widget.date.toIso8601String(),
          'type': widget.type,
        };

        ApiService apiService = ApiService();
        bool success = await apiService.createOrder(orderData);

        if (success) {
          setState(() {
            isSuccess = true;
          });
          await Future.delayed(Duration(seconds: 2));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ClientHome()),
          );
        } else {
          setState(() {
            isError = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to create order')),
          );
        }
      } catch (e) {
        setState(() {
          isLoading = false;
          isSuccess = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    print(widget.courierId);
    print(widget.date);
    print(widget.type);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: screenWidth,
                  height: screenHeight,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.00, -1.00),
                      end: Alignment(0, 1),
                      colors: [
                        Color(0xFFD7433C),
                        Color(0xFFDD5E58),
                        Colors.white
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: screenWidth,
                          height: screenHeight * 0.25,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(0.00, 1.00),
                              end: Alignment(0, -1),
                              colors: [Colors.white, Color(0xFFD7433C)],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 60,
                        left: MediaQuery.of(context).size.width * 0.01,
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back, color: Colors.white),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Delivery Address',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 0, 0, 0),
                                letterSpacing: 1.5,
                                shadows: [
                                  Shadow(
                                    blurRadius: 10.0,
                                    color: Colors.black.withOpacity(0.5),
                                    offset: Offset(4, 4),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: screenHeight * 0.15,
                        child: Container(
                          width: screenWidth,
                          height: screenHeight * 0.85,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(48)),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),
                                Text(
                                  'Choose your address input method:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 30),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedMethod = 'manual';
                                        });
                                      },
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            size: 50,
                                            color: selectedMethod == 'manual'
                                                ? Colors.blue
                                                : Colors.grey,
                                          ),
                                          Text('Manual Entry'),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedMethod = 'map';
                                        });
                                      },
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.map,
                                            size: 50,
                                            color: selectedMethod == 'map'
                                                ? Colors.blue
                                                : Colors.grey,
                                          ),
                                          Text('Select on Map'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 30),
                                if (selectedMethod == 'manual') ...[
                                  Text(
                                    'Enter your shipping address:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  TextField(
                                    controller: shippingController,
                                    decoration: InputDecoration(
                                      hintText: 'Enter shipping address',
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    'Enter your billing address:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  TextField(
                                    controller: billingController,
                                    decoration: InputDecoration(
                                      hintText: 'Enter billing address',
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ],
                                if (selectedMethod == 'map') ...[
                                  Text(
                                    'Select your address on the map:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    height: 200,
                                    color: Colors.grey[200],
                                    child: FlutterMap(
                                      options: MapOptions(
                                        center: _markerPosition,
                                        zoom: 13.0,
                                        onTap: (tapPosition, point) {
                                          setState(() {
                                            _markerPosition = point;
                                          });
                                        },
                                      ),
                                      children: [
                                        TileLayer(
                                          urlTemplate:
                                              "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                          subdomains: ['a', 'b', 'c'],
                                        ),
                                        MarkerLayer(
                                          markers: [
                                            Marker(
                                              width: 80.0,
                                              height: 80.0,
                                              point: _markerPosition,
                                              child: Container(
                                                child: Icon(
                                                  Icons.location_pin,
                                                  color: Colors.red,
                                                  size: 40.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                                SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: createOrder,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 0),
                                  ),
                                  child: Container(
                                    width: screenWidth * 0.9,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment(0.00, 1.00),
                                        end: Alignment(0, -1),
                                        colors: [
                                          Color(0xFFF5962A),
                                          Color(0xFFD7433C)
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      isLoading
                                          ? "Creating Order..."
                                          : "Continue",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
          if (isSuccess)
            Center(
              child: Lottie.asset(
                'assets/animations/green_tick.json',
                width: 200,
                height: 200,
              ),
            ),
          if (isError)
            Center(
              child: Lottie.asset(
                'assets/animations/error_x.json',
                width: 200,
                height: 200,
              ),
            )
        ],
      ),
    );
  }
}
