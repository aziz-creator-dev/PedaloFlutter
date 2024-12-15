import 'package:flutter/material.dart';
import 'package:projet_pfe/screens/client_main.dart';
import 'package:projet_pfe/screens/raider_main.dart';

class GetStarted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          width: screenWidth,
          height: screenHeight,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.00, -1.00),
              end: Alignment(0, 1),
              colors: [Colors.white, Color(0xFFDD5E58), Color(0xFFD7433C)],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: screenWidth * 0.15,
                top: screenHeight * 0.11,
                child: Container(
                  width: screenWidth * 0.7,
                  height: screenHeight * 0.37,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(42),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(2, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: screenWidth * 0.29,
                top: screenHeight * 0.13,
                child: Container(
                  width: screenWidth * 0.42,
                  height: screenHeight * 0.18,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/Group 55.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: screenWidth * 0.17,
                top: screenHeight * 0.32,
                child: SizedBox(
                  width: screenWidth * 0.66,
                  height: screenHeight * 0.09,
                  child: Text(
                    'Your satisfaction is our priority, every step of the way.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF3D003E),
                      fontSize: screenWidth * 0.04,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: screenWidth * 0.25,
                top: screenHeight * 0.39,
                child: Container(
                  width: screenWidth * 0.5,
                  height: screenHeight * 0.06,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ClientMain()),
                            );
                          },
                          child: Container(
                            width: screenWidth * 0.5,
                            height: screenHeight * 0.06,
                            decoration: ShapeDecoration(
                              color: Color(0xFFD7433C),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.19,
                        top: screenHeight * 0.015,
                        child: Text(
                          'Client',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.05,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: screenWidth * 0.15,
                top: screenHeight * 0.53,
                child: Container(
                  width: screenWidth * 0.7,
                  height: screenHeight * 0.37,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(42),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(2, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: screenWidth * 0.29,
                top: screenHeight * 0.55,
                child: Container(
                  width: screenWidth * 0.42,
                  height: screenHeight * 0.18,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/rider.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: screenWidth * 0.17,
                top: screenHeight * 0.74,
                child: SizedBox(
                  width: screenWidth * 0.66,
                  height: screenHeight * 0.09,
                  child: Text(
                    'Your journey matters. Together, we’ll keep moving forward.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF3D003E),
                      fontSize: screenWidth * 0.04,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: screenWidth * 0.25,
                top: screenHeight * 0.81,
                child: Container(
                  width: screenWidth * 0.5,
                  height: screenHeight * 0.06,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: GestureDetector(
                          onTap: () {
                            // Navigate to RiderMain
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RiderMain()),
                            );
                          },
                          child: Container(
                            width: screenWidth * 0.5,
                            height: screenHeight * 0.06,
                            decoration: ShapeDecoration(
                              color: Color(0xFFF5962A),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.19,
                        top: screenHeight * 0.015,
                        child: Text(
                          'Rider',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.05,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: screenWidth * 0.45,
                top: screenHeight * 0.96,
                child: Container(
                  height: screenHeight * 0.015,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: screenWidth * 0.02,
                        height: screenHeight * 0.015,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 0, 0, 0),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Container(
                        width: screenWidth * 0.02,
                        height: screenHeight * 0.015,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
