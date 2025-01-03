import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projet_pfe/services/api_service.dart';
import 'package:projet_pfe/screens/add_delivery_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/courier.dart';
import 'sidebar_client.dart';

class ClientHome extends StatefulWidget {
  @override
  _ClientHomeState createState() => _ClientHomeState();
}

class _ClientHomeState extends State<ClientHome> {
  late Future<List<Courier>> _couriers;
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _couriers = ApiService().getCouriers();
    _fetchUserName();
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
                    left: size.width * 0.1,
                    top: size.height * 0.3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello ' + _userName,
                          style: TextStyle(
                            color: Color(0xFF3D003E),
                            fontSize: size.width * 0.08,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Let us pick up things for you!',
                          style: TextStyle(
                            color: Color(0xFF3D003E),
                            fontSize: size.width * 0.045,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: size.width * 0.05,
                    top: size.height * 0.17,
                    child: CircleAvatar(
                      radius: size.width * 0.1,
                      backgroundImage: AssetImage("assets/images/man.png"),
                    ),
                  ),
                  Positioned(
                    top: size.height * 0.67,
                    left: 20,
                    right: 20,
                    child: FutureBuilder<List<Courier>>(
                      future: _couriers,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'Failed to load couriers: ${snapshot.error}',
                              style: TextStyle(color: Colors.red),
                            ),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(
                            child: Text(
                              'No couriers available',
                              style: TextStyle(fontSize: 18),
                            ),
                          );
                        } else {
                          return SizedBox(
                            height:
                                size.height * 0.3, // Adjust height as needed
                            child: ListView.builder(
                              scrollDirection: Axis
                                  .horizontal, // Enable horizontal scrolling
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final courier = snapshot.data![index];
                                return _buildCourierCard(size, courier);
                              },
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourierCard(Size size, Courier courier) {
    return Container(
      width: size.width * 0.7,
      margin: EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (courier.type == 'Electric bike')
            Image.asset(
              'assets/images/bike (3).png',
              width: 24,
              height: 24,
            )
          else if (courier.type == 'Non-electric bike')
            Image.asset(
              'assets/images/bike.png',
              width: 24,
              height: 24,
            ),
          Text(
            courier.name ?? 'Unknown Name',
            style: TextStyle(
                fontSize: size.width * 0.05, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            courier.tel ?? 'No phone number',
            style: TextStyle(fontSize: size.width * 0.04, color: Colors.grey),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AddDeliveryDetails(courierId: courier.id),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Color(0xFFF5962A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              'Deliver Package',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
