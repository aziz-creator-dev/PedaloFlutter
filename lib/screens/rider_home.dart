import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projet_pfe/screens/sidebar_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projet_pfe/services/api_service.dart';
import '../models/order.dart';
import '../models/courier.dart';

class RiderHome extends StatefulWidget {
  @override
  _RiderHomeState createState() => _RiderHomeState();
}

class _RiderHomeState extends State<RiderHome> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cinController = TextEditingController();
  final TextEditingController _licenceController = TextEditingController();
  String _userName = '';
  bool _isAvailable = true;
  String _selectedType = 'Electric bike';
  List<Order> _orders = [];
  @override
  void initState() {
    super.initState();
    _checkRiderInfo();
    _fetchUserName();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userDataString = prefs.getString('userData');

      if (userDataString != null) {
        Map<String, dynamic> userData = jsonDecode(userDataString);
        int riderId = userData['id'];
        print(riderId);
        ApiService apiService = ApiService();
        List<Order> orders = await apiService.getOrdersByCourierId(riderId);
        setState(() {
          _orders = orders;
        });
      } else {
        print('User data not found in SharedPreferences');
      }
    } catch (e) {
      print('Error fetching orders: $e');
    }
  }

  Future<void> _checkRiderInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve the userData JSON string from SharedPreferences
    String? userDataString = prefs.getString('userData');

    Set<String> keys = prefs.getKeys();
    keys.forEach((key) {
      print('SharedPreferences key: $key, value: ${prefs.get(key)}');
    });

    if (userDataString != null) {
      try {
        Map<String, dynamic> userData = jsonDecode(userDataString);

        int riderId = userData['id'];

        ApiService apiService = ApiService();
        bool hasNullFields = await apiService.checkNullFields(riderId);
        setState(() {
          _isAvailable = !hasNullFields;
        });
        if (hasNullFields) {
          _showCompleteInfoModal();
        }
      } catch (e) {
        print('Error: $e');
      }
    } else {
      print('userData not found in SharedPreferences');
    }
  }

  Future<void> _fetchUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');

    if (userDataString != null) {
      try {
        Map<String, dynamic> userData = jsonDecode(userDataString);
        setState(() {
          _userName = userData['name'] ?? 'User';
        });
      } catch (e) {
        print('Error fetching user data: $e');
      }
    } else {
      print('User data not found in SharedPreferences');
    }
  }

  Widget _buildOrdersList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Orders',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          _orders.isEmpty
              ? Text(
                  'No orders available.',
                  style: TextStyle(color: Colors.grey),
                )
              : SizedBox(
                  height: 150,
                  child: ListView.builder(
                    itemCount: _orders.length,
                    itemBuilder: (context, index) {
                      Order order = _orders[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          title: Text('Date: ${order.date}'),
                          subtitle:
                              Text('Pick up from: ${order.pickupAddress}'),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }

  void _showCompleteInfoModal() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Complete Your Information'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField('Name', _nameController),
                _buildTextField('CIN', _cinController),
                _buildTextField('Licence', _licenceController),
                _buildTypeField(),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _updateClientInfo();
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Future<void> _updateClientInfo() async {
    if (_nameController.text.isEmpty ||
        _cinController.text.isEmpty ||
        _licenceController.text.isEmpty) {
      print("Error: Some fields are empty.");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');
    if (userDataString == null) {
      print("Error: User data not found in SharedPreferences.");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User data not found!')),
      );
      return;
    }

    Map<String, dynamic> userData = jsonDecode(userDataString);
    int riderId = userData['id'];

    print("Updating client info for rider ID: $riderId");
    print("Name: ${_nameController.text}");
    print("CIN: ${_cinController.text}");
    print("Licence: ${_licenceController.text}");
    print("Type: $_selectedType");

    Courier client = Courier(
      id: riderId,
      name: _nameController.text,
      cin: _cinController.text,
      licence: _licenceController.text,
      type: _selectedType,
    );

    userData['name'] = _nameController.text;
    prefs.setString('userData', jsonEncode(userData));

    ApiService apiService = ApiService();
    try {
      print("Calling API to update client...");
      Courier updatedClient = await apiService.updateCourier(riderId, client);
      print("Client info updated successfully!");

      await _fetchUserName();
      setState(() {});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Client information updated successfully!')),
      );
      Navigator.of(context).pop();
    } catch (e) {
      print("Error updating client info: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating client information.')),
      );
    }
  }

  Widget _buildTypeField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: _selectedType,
        decoration: InputDecoration(
          labelText: 'Type',
          border: OutlineInputBorder(),
        ),
        items: ['Electric bike', 'Non-electric bike']
            .map((type) => DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                ))
            .toList(),
        onChanged: (value) {
          setState(() {
            _selectedType = value!;
          });
        },
        hint: Text('Select Type'),
      ),
    );
  }

  void _toggleAvailability() {
    setState(() {
      _isAvailable = !_isAvailable;
    });
  }

  Widget _buildAvailabilityButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Are you available?',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10),
        FloatingActionButton(
          onPressed: _toggleAvailability,
          backgroundColor: _isAvailable ? Colors.green : Colors.red,
          child: Icon(
            _isAvailable ? Icons.check : Icons.close,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: Drawer(
        child: Sidebar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFD7433C), Color(0xFFDD5E58), Colors.white],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 20,
                    right: 20,
                    top: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Builder(
                          builder: (context) {
                            return IconButton(
                              icon: Icon(Icons.menu, color: Colors.white),
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                            );
                          },
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search...',
                                hintStyle: TextStyle(color: Colors.white),
                                prefixIcon:
                                    Icon(Icons.search, color: Colors.white),
                                filled: true,
                                fillColor: Colors.black.withOpacity(0.2),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.notifications, color: Colors.white),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: size.width * 0.05,
                    top: size.height * 0.17,
                    child: CircleAvatar(
                      radius: size.width * 0.1,
                      backgroundImage: AssetImage("assets/images/driver.png"),
                    ),
                  ),
                  Positioned(
                    left: size.width * 0.05,
                    top: size.height * 0.3,
                    child: Text(
                      'Hello, $_userName',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Center(
                    child: _buildAvailabilityButton(),
                  ),
                  Positioned(
                    left: size.width * 0.03,
                    top: size.height * 0.6,
                    right: size.width * 0.03,
                    child: _buildOrdersList(), // Insert orders list here
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
