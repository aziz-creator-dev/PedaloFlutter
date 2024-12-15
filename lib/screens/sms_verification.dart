import 'package:flutter/material.dart';

import 'rider_home.dart';

class SmsVerificationScreen extends StatelessWidget {
  final String phoneNumber;

  SmsVerificationScreen({required this.phoneNumber});

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
                    top: 25,
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
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: const Color.fromARGB(255, 0, 0, 0)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ),Positioned(
                            left: screenWidth * 0.07,
                            top: screenHeight * 0.12,
                           
                              child: Text(
                                ' Verification',
                                style: TextStyle(
                                  color: 
                                      Color(0xFF3D003E),
                                  fontSize: screenWidth * 0.08,
                                  fontFamily: 'Montserrat',
                                  fontWeight: 
                                       FontWeight.w600,
                                     
                                  height: 0,
                                ),
                              ),
                            
                          ),
                  Positioned(
                    left: 0,
                    top: screenHeight * 0.2,
                    child: Container(
                      width: screenWidth,
                      height: screenHeight * 0.8,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(48),
                          ),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: Offset(0, 4),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.1,
                          vertical: screenHeight * 0.05,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Enter the code',
                              style: TextStyle(
                                fontSize: screenWidth * 0.07,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3D003E),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(5, (index) {
                                return Container(
                                  width: screenWidth * 0.12,
                                  height: screenHeight * 0.08,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xFFD7433C), width: 1.5),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    maxLength: 1,
                                    decoration: InputDecoration(
                                      counterText: '',
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                );
                              }),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'A SMS has been sent to $phoneNumber',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                            SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                             // Resend SMS logic here
                              },
                              child: Text(
                                "Didn't receive SMS?",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFFD7433C),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            SizedBox(height: 40),
                            ElevatedButton(
                              onPressed: () {
                               Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RiderHome()),
                      ); // Verification logic here
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                              ),
                              child: Container(
                                width: screenWidth * 0.8,
                                height: 50,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(0.00, 1.00),
                                    end: Alignment(0, -1),
                                    colors: [Color(0xFFF5962A), Color(0xFFD7433C)],
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Continue",
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
    );
  }
}
