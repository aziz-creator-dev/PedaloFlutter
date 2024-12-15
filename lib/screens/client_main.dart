import 'package:flutter/material.dart';

class ClientMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/pattern.png',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: screenWidth,
              height: screenHeight,
              child: Stack(
                children: [
                  Positioned(
                    left: screenWidth * 0.42,
                    top: screenHeight * 0.46,
                    child: Text(
                      'Client',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF3D003E),
                        fontSize: screenWidth * 0.08,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth * 0.17,
                    top: screenHeight * 0.54,
                    child: SizedBox(
                      width: screenWidth * 0.7,
                      height: screenHeight * 0.1,
                      child: Text(
                        'Culpa qui officia deserunt mollit anim id est laborum.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF3D003E),
                          fontSize: screenWidth * 0.04,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth * 0.17,
                    top: screenHeight * 0.64,
                    child: Container(
                      width: screenWidth * 0.7,
                      height: screenHeight * 0.08,
                      decoration: ShapeDecoration(
                        color: Color(0xFFD7433C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.05,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth * 0.17,
                    top: screenHeight * 0.77,
                    child: GestureDetector(
                      onTap: () {
                        print('Sign Up tapped!');
                      },
                      child: Container(
                        width: screenWidth * 0.7,
                        height: screenHeight * 0.08,
                        decoration: ShapeDecoration(
                          color: Color(0xFFF5962A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.05,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth * 0.19,
                    top: screenHeight * 0.11,
                    child: Container(
                      width: screenWidth * 0.6,
                      height: screenHeight * 0.35,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/Group 55.png"),
                          fit: BoxFit.fill,
                        ),
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
                              color: Colors.grey,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Container(
                            width: screenWidth * 0.02,
                            height: screenHeight * 0.015,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 0, 0, 0),
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
          ),
        ],
      ),
    );
  }
}
