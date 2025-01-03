import 'package:flutter/material.dart';
import 'package:projet_pfe/screens/get_started.dart';
import 'package:projet_pfe/screens/login.dart';

class MainScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          width: screenWidth,
          height: screenHeight,
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
                left: screenWidth * 0.29,
                top: screenHeight * 0.16,
                child: Container(
                  width: screenWidth * 0.42,
                  height: screenHeight * 0.36,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/PEDALO 1.png"),
                    ),
                  ),
                ),
              ),

              // Get Started Button
              Positioned(
                left: screenWidth * 0.1,
                top: screenHeight * 0.65,
                child: SizedBox(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.08,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GetStarted()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth * 0.045,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                left: screenWidth * 0.23,
                top: screenHeight * 0.77,
                child: Text(
                  'Already have an account?',
                  style: TextStyle(
                    color: Color(0xFF3D003E),
                    fontSize: screenWidth * 0.035,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              Positioned(
                left: screenWidth * 0.67,
                top: screenHeight * 0.77,
                child: GestureDetector(
                  onTap: () {
                    // Navigate to another screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Login(isLogin: true,role: 'client')),
                    );
                  },
                  child: Text(
                    'Log in',
                    style: TextStyle(
                      color: Color(0xFF3D003E),
                      fontSize: screenWidth * 0.035,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.none,
                    ),
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
