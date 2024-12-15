import 'package:flutter/material.dart';

class TrackDelivery extends StatefulWidget {
  @override
  _TrackDeliveryState createState() => _TrackDeliveryState();
}

class _TrackDeliveryState extends State<TrackDelivery> {
  int currentPoint = 2; // Assuming we are at the second point

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
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
                  colors: [Color(0xFFD7433C), Color(0xFFDD5E58), Colors.white],
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
                          'Track Delivery',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(48)),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 30),
                            Text(
                              'Delivery Progress:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 50),
                            _buildDeliveryTrack(),
                            SizedBox(height: 20),
                            
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
    );
  }

  Widget _buildDeliveryTrack() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 6,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              _buildPoint(0),
              _buildProgressLine(0),
              _buildPoint(1),
              _buildProgressLine(1),
              _buildPoint(2),
              _buildProgressLine(2),
              _buildPoint(3),
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
Widget _buildPoint(int index) {
  // Ensure non-null color assignment
  Color pointColor = index <= currentPoint ? Colors.green : (Colors.grey[300] ?? Colors.transparent);

  return Expanded(
    child: Column(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: pointColor,
            shape: BoxShape.circle,
            border: Border.all(color: pointColor, width: 2),
          ),
        ),
        SizedBox(height: 10),
        Text(
          _getPointLabel(index),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: pointColor,
          ),
        ),
      ],
    ),
  );
}

Widget _buildProgressLine(int index) {
  // Ensure non-nullable color assignment
  Color lineColor = index < currentPoint ? Colors.green : (Colors.grey[300] ?? Colors.grey); // Default to Colors.grey
  return Expanded(
    child: Container(
      height: 6,
      decoration: BoxDecoration(
        color: lineColor,
        borderRadius: BorderRadius.circular(3),
      ),
    ),
  );
}

  String _getPointLabel(int index) {
    switch (index) {
      case 0:
        return 'Order Placed';
      case 1:
        return 'Picked Up';
      case 2:
        return 'In Transit';
      case 3:
        return 'Delivered';
      default:
        return '';
    }
  }
}
