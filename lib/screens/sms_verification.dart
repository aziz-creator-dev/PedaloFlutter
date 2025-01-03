import 'package:flutter/material.dart';
import 'package:projet_pfe/screens/client_home.dart';
import 'package:projet_pfe/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'rider_home.dart';
import 'package:projet_pfe/services/sms_service.dart';

class SmsVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  SmsVerificationScreen({required this.phoneNumber});

  @override
  _SmsVerificationScreenState createState() => _SmsVerificationScreenState();
}

class _SmsVerificationScreenState extends State<SmsVerificationScreen> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  final TextEditingController _controller5 = TextEditingController();
  final TextEditingController _controller6 = TextEditingController();

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  final FocusNode _focusNode5 = FocusNode();
  final FocusNode _focusNode6 = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _resendCode();
    });
  }

  void _verifyCode(BuildContext context) async {
    String code = _controller1.text +
        _controller2.text +
        _controller3.text +
        _controller4.text +
        _controller5.text +
        _controller6.text;

    if (code.length == 6) {
      bool success =
          await SmsService.verifyCode(widget.phoneNumber, code, 'VA1d9ef092ed8cc80d9b3de621541b3ee5');

      if (success) {
        // Retrieve the user role from SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? userRole = prefs.getString('userRole');

        if (userRole == 'client') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ClientHome()),
          );
        } else if (userRole == 'rider') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => RiderHome()),
          );
        } else {
          // Handle unexpected roles (if needed)
          showErrorDialog('Invalid user role');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Invalid verification code. Please try again.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid 6-digit code')),
      );
    }
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _resendCode() {
    SmsService.sendSms(widget.phoneNumber);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sending SMS...')),
    );
  }

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
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
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
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Colors.white, Color(0xFFD7433C)],
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth * 0.07,
                    top: screenHeight * 0.12,
                    child: Text(
                      'Verification',
                      style: TextStyle(
                        color: Color(0xFF3D003E),
                        fontSize: screenWidth * 0.08,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
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
                              children: [
                                _buildCodeField(
                                    _controller1, _focusNode1, _focusNode2),
                                _buildCodeField(
                                    _controller2, _focusNode2, _focusNode3),
                                _buildCodeField(
                                    _controller3, _focusNode3, _focusNode4),
                                _buildCodeField(
                                    _controller4, _focusNode4, _focusNode5),
                                _buildCodeField(
                                    _controller5, _focusNode5, _focusNode6),
                                _buildCodeField(
                                    _controller6, _focusNode6, null),
                              ],
                            ),
                            SizedBox(height: 20),
                            Text(
                              'An SMS has been sent to ${widget.phoneNumber}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                            SizedBox(height: 20),
                            GestureDetector(
                              onTap: _resendCode,
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
                            Center(
                              child: ElevatedButton(
                                onPressed: () => _verifyCode(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFD7433C),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  'Verify Code',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
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

  Widget _buildCodeField(TextEditingController controller, FocusNode focusNode,
      FocusNode? nextFocusNode) {
    return Container(
      width: 40.0,
      height: 60.0,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFD7433C), width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        onChanged: (value) {
          if (value.isNotEmpty && nextFocusNode != null) {
            FocusScope.of(context).requestFocus(nextFocusNode);
          } else if (value.isEmpty && focusNode != _focusNode1) {
            FocusScope.of(context).requestFocus(focusNode);
          }
        },
        decoration: InputDecoration(
          counterText: '',
          border: InputBorder.none,
        ),
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
