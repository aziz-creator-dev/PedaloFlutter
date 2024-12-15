import 'package:flutter/material.dart';
import 'package:projet_pfe/screens/sms_verification.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLogin = true;
  String selectedPrefix = '+216';

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
                            left: screenWidth * 0.08,
                            top: screenHeight * 0.12,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isLogin = true;
                                });
                              },
                              child: Text(
                                'Log in',
                                style: TextStyle(
                                  color: isLogin
                                      ? Color(0xFF3D003E)
                                      : Color(0x4C3D003E),
                                  fontSize: screenWidth * 0.08,
                                  fontFamily: 'Montserrat',
                                  fontWeight: isLogin
                                      ? FontWeight.bold
                                      : FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: screenWidth * 0.4,
                            top: screenHeight * 0.12,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isLogin = false;
                                });
                              },
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                  color: isLogin
                                      ? Color(0x4C3D003E)
                                      : Color(0xFF3D003E),
                                  fontSize: screenWidth * 0.08,
                                  fontFamily: 'Montserrat',
                                  fontWeight: isLogin
                                      ? FontWeight.w600
                                      : FontWeight.bold,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: screenHeight * 0.21,
                    child: Container(
                      width: screenWidth,
                      height: screenHeight * 0.85,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: screenWidth,
                              height: screenHeight * 0.85,
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
                            ),
                          ),
                          // Log in / Sign up content
                          if (isLogin) ...[
                            _loginForm(screenWidth, screenHeight),
                          ] else ...[
                            _signUpForm(screenWidth, screenHeight),
                          ],
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginForm(double screenWidth, double screenHeight) {
  final TextEditingController phoneController = TextEditingController();
  bool isPhoneValid = false;

  return Positioned(
    left: screenWidth * 0.1,
    top: screenHeight * 0.1,
    child: StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: screenWidth * 0.2,
                  height: 60,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: DropdownButton<String>(
                      value: selectedPrefix,
                      items: [
                        '+216',
                        '+1',
                        '+44',
                        '+33',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                      onChanged: (newPrefix) {
                        setState(() {
                          selectedPrefix = newPrefix!;
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  width: screenWidth * 0.65,
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      TextField(
                        controller: phoneController,
                        onChanged: (value) {
                          setState(() {
                            isPhoneValid = RegExp(r'^\d{8,15}$').hasMatch(value);
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter phone number',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFD7433C)),
                          ),
                        ),
                      ),
                      Icon(
                        isPhoneValid ? Icons.check : Icons.close,
                        color: isPhoneValid ? Colors.green : Colors.red,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              "Log in with your phone number",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black.withOpacity(0.3),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isPhoneValid
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SmsVerificationScreen(
                            phoneNumber: '$selectedPrefix${phoneController.text}',
                          ),
                        ),
                      );
                    }
                  : null,
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
                  "Log In",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ),
  );
}
Widget _signUpForm(double screenWidth, double screenHeight) {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool isEmailValid = false;
  bool isPhoneValid = false;

  return Positioned(
    left: screenWidth * 0.1,
    top: screenHeight * 0.1,
    child: StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: screenWidth * 0.8,
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  TextField(
                    controller: emailController,
                    onChanged: (value) {
                      setState(() {
                        isEmailValid =
                            RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value);
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFD7433C)),
                      ),
                    ),
                  ),
                  Icon(
                    isEmailValid ? Icons.check : Icons.close,
                    color: isEmailValid ? Colors.green : Colors.red,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Container(
                  width: screenWidth * 0.2,
                  height: 60,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: DropdownButton<String>(
                      value: selectedPrefix,
                      items: [
                        '+216',
                        '+1',
                        '+44',
                        '+33',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                      onChanged: (newPrefix) {
                        setState(() {
                          selectedPrefix = newPrefix!;
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  width: screenWidth * 0.65,
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      TextField(
                        controller: phoneController,
                        onChanged: (value) {
                          setState(() {
                            isPhoneValid =
                                RegExp(r'^\d{8,15}$').hasMatch(value);
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter phone number',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFD7433C)),
                          ),
                        ),
                      ),
                      Icon(
                        isPhoneValid ? Icons.check : Icons.close,
                        color: isPhoneValid ? Colors.green : Colors.red,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              "Sign up with your email and phone number",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black.withOpacity(0.3),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isEmailValid && isPhoneValid
                  ? () {
                      // Implement your signup logic here
                    }
                  : null,
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
                  "Sign Up",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ),
  );
}

}
