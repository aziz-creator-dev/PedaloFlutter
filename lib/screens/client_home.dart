// Import necessary packages
import 'package:flutter/material.dart';
import 'package:projet_pfe/screens/add_delivery_details.dart';
import 'sidebar_client.dart'; // Import Sidebar widget

class ClientHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: Drawer(
        child: Sidebar(), // Sidebar integration
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Background container with gradient
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
                  // Top Row with Icon and Search Bar
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
                                prefixIcon: Icon(Icons.search, color: Colors.white),
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
                          onPressed: () {
                            // Handle notifications click
                          },
                        ),
                      ],
                    ),
                  ),
                  // Additional content
                  Positioned(
                    left: size.width * 0.1,
                    top: size.height * 0.3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello John,',
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

                  // User Profile Picture
                  Positioned(
                    left: size.width * 0.05,
                    top: size.height * 0.17,
                    child: CircleAvatar(
                      radius: size.width * 0.1,
                      backgroundImage:
                          NetworkImage("https://via.placeholder.com/91x91"),
                    ),
                  ),

                  // Cards Section
                  Positioned(
                    top: size.height * 0.6,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Near You',
                              style: TextStyle(
                                fontSize: size.width * 0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Browse Map action
                              },
                              child: Text(
                                'Browse Map',
                                style: TextStyle(
                                  fontSize: size.width * 0.04,
                                  color: const Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        // Scrollable horizontal list of cards
                        Container(
                          height: size.height * 0.3,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5, // Number of cards
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: _buildCard(size,context),
                              );
                            },
                          ),
                        ),
                      ],
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

   Widget _buildCard(Size size, BuildContext context) {
    return Container(
      width: size.width * 0.8,
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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      NetworkImage("https://via.placeholder.com/91x91"),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Michael Lucas',
                      style: TextStyle(
                        fontSize: size.width * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Biker Available',
                      style: TextStyle(
                        fontSize: size.width * 0.035,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to the AddDeliveryDetails screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddDeliveryDetails(), // Change this to your actual screen
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
      ),
    );
  }
}
