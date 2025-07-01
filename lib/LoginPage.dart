import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_android/google_sign_in_android.dart';

import 'ProfilePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

 // final GoogleSignIn _googleSignIn = GoogleSignIn.standard(); // ✅ Fixed
  final GoogleSignIn _googleSignIn = GoogleSignIn(); // ✅ Use default constructor

  String? _userEmail;

  void _login() {
    String email = _emailController.text;
    String password = _passwordController.text;

    // You can add real authentication logic here
    print('Email: $email');
    print('Password: $password');
  }

  Future<void> _loginWithGoogle() async {
    print('Login with Google pressed');
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        setState(() {
          _userEmail = account.email;
          print('gmail :${_userEmail}');

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfilePage(
                email: account.email,
                name: account.displayName, // ✅ Now supported
                googleSignIn: _googleSignIn,
              ),
            ),
          );
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Logged in as ${account.email}')),
        );
      } else {
        // User cancelled
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login cancelled')),
        );
      }
    } catch (error) {
      print('Google Sign-In error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            Row(
              children: const [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("OR"),
                ),
                Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: _loginWithGoogle,
              icon: Image.asset(
                'assets/google.png', // Add your own Google logo in assets
                height: 24,
              ),
              label: const Text('Login with Google'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                foregroundColor: Colors.black, // 👈 Set text/icon color here
                side: const BorderSide(color: Colors.black12), // Optional: border style
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
