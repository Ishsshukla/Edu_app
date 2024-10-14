import 'package:flutter/material.dart';

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({super.key});

  @override
  State<PrivacyPage> createState() => _PrivacyState();
}

class _PrivacyState extends State<PrivacyPage> {
  bool isSelected1 = false;
  bool isSelected2 = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final padding = screenWidth * 0.05; // 5% of screen width
    final fontSize = screenWidth * 0.04; // 4% of screen width

    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(padding, padding, padding, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Privacy Policy',
                style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                'data built the Educate Live app as a Commercial app. This SERVICE is provided by Education and is intended for use as is.',
                style: TextStyle(fontSize: fontSize),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                'This page is used to inform visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service.',
                style: TextStyle(fontSize: fontSize),
              ),
              SizedBox(height: screenHeight * 0.03),
              Text(
                'Google Play Services',
                style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                'If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.',
                style: TextStyle(fontSize: fontSize),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                'The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible at Educate Live unless otherwise defined in this Privacy Policy.',
                style: TextStyle(fontSize: fontSize),
              ),
              SizedBox(height: screenHeight * 0.03),
              Text(
                'Information Collection and Use',
                style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
              ),
              Text(
                'For a better experience, while using our Service, we may require you to provide us with certain personally identifiable information, including but not limited to users name, email address, phone number, location, device information. The information that we request will be retained by us and used as described in this privacy policy.',
                style: TextStyle(fontSize: fontSize),
              ),
              Text(
                'The app does use third party services that may collect information used to identify you.',
                style: TextStyle(fontSize: fontSize),
              ),
              Text(
                'Link to privacy policy of third party service providers used by the app',
                style: TextStyle(fontSize: fontSize),
              ),
              Text(
                'Google Play Services',
                style: TextStyle(fontSize: fontSize),
              ),
              Text(
                'Log Data',
                style: TextStyle(fontSize: fontSize),
              ),
              Text(
                'We want to inform you that whenever you use our Service, in a case of an error in the app we collect data and information (through third party products) on your phone called Log Data. This Log Data may include information such as your devices Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing our Service, the time and date of your use of the Service, and other statistics.',
                style: TextStyle(fontSize: fontSize),
              ),
              Text(
                'Cookies',
                style: TextStyle(fontSize: fontSize),
              ),
              Text(
                'Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your devices internal memory.',
                style: TextStyle(fontSize: fontSize),
              ),
              Text(
                'This Service does not use these “cookies” explicitly. However, the app may use third party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.',
                style: TextStyle(fontSize: fontSize),
              ),
              Text(
                'Service Providers',
                style: TextStyle(fontSize: fontSize),
              ),
              Text(
                'We may employ third-party companies and individuals due to the following reasons:',
                style: TextStyle(fontSize: fontSize),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
