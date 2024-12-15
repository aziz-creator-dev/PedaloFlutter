import 'package:flutter/material.dart';
import 'sidebar_client.dart'; // Import Sidebar widget

class RiderHome extends StatelessWidget {
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

                  // Weather Widget
                  Positioned(
                    right: size.width * 0.05,
                    top: size.height * 0.2,
                    child: _buildMobileWeatherWidget(size),
                  ),

                  // Welcome Text
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Mobile-like Weather Widget
  Widget _buildMobileWeatherWidget(Size size) {
    return Container(
      width: size.width * 0.4,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wb_sunny,
            color: Colors.orange,
            size: size.width * 0.1,
          ),
          SizedBox(height: 8),
          Text(
            '28°C',
            style: TextStyle(
              fontSize: size.width * 0.07,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            'Sunny',
            style: TextStyle(
              fontSize: size.width * 0.04,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'New York, USA',
            style: TextStyle(
              fontSize: size.width * 0.035,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

