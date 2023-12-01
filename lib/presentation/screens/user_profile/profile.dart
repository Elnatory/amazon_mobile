// import 'package:amazon_mobile/presentation/screens/auth_view/login_view.dart';
// import 'package:amazon_mobile/presentation/screens/auth_view/phone.dart';
// import 'package:amazon_mobile/presentation/screens/cart_view/cart.dart';
import 'package:amazon_mobile/presentation/resources/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
    static String routeName = '/profile';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State <ProfileScreen> {
  CloudFirestoreClass firestoreClass = CloudFirestoreClass(); // Replace with your Firestore class instance
  late String userName;
  late String userEmail;
  late String createdAt;

Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut(); // Sign out the user
      // Navigate to the login screen or any other screen after logout
      Navigator.of(context).pushReplacementNamed('/Login'); // Replace '/login' with your login screen route
    } catch (e) {
      print('Error logging out: $e');
    }
  }
  
@override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() async {
    Map<String, dynamic> userData = await firestoreClass.getNameAndEmail();
    setState(() {
      userName = userData['name'] ?? 'No Name';
      userEmail = userData['email'] ?? 'No Email';
      createdAt = userData['createdAt'] ?? 'No Creation Date';
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF131820),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Implement action for left button
          },
        ),
        title: Text('Profile'),
      ),
      backgroundColor: Colors.black, // Set background color to black
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(
                  'https://as2.ftcdn.net/v2/jpg/01/17/95/91/1000_F_117959178_mOp22kjhdhWdoSoePHPafN7GLUYyvFNY.jpg'),
            ),
          ),
          SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Implement checkout functionality
                        // Navigate to the checkout page
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFfacd14), // Set button color to #facd14
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12), // Adjust button padding
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart),
                          SizedBox(width: 8),
                          Text('Checkout', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        // Implement payment method functionality
                        // Navigate to the payment method page
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFfacd14), // Set button color to #facd14
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12), // Adjust button padding
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.payment),
                          SizedBox(width: 8),
                          Text('Payment Method', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        // Implement settings functionality
                        // Navigate to the desired page here
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFfacd14), // Set button color to #facd14
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12), // Adjust button padding
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.settings),
                          SizedBox(width: 8),
                          Text('Settings', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
            onPressed: _logout, // Call the logout function when button is pressed
            style: ElevatedButton.styleFrom(
              primary: Color(0xFFfacd14),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.logout),
                SizedBox(width: 8),
                Text('Logout', style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
                  ],
                ),
              ),

              SizedBox(width: 50),


              Expanded(
                child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'UserName: $userName',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Email: $userEmail',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Created At: $createdAt',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
                    SizedBox(height: 8),
                    Text(
                      'PassWord:  ******** ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),


                    SizedBox(height: 8),
                    Text(
                      'Mobile Number:     +201146223301 ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    
                   
                    SizedBox(height: 8),
                    Text(
                      'First address:    Qena-qeft-el Fath-street 1',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),


                    Text(
                      'alter address: Qena-elAwaydat-street ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
             
            ],
          ),
        ],
      ),
    );
  }
}

