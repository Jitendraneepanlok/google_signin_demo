import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfilePage extends StatelessWidget {
  final String email;
  final String? name;
  final GoogleSignIn googleSignIn;

  const ProfilePage({
    Key? key,
    required this.email,
    required this.name,
    required this.googleSignIn,
  }) : super(key: key);

  Future<void> _signOut(BuildContext context) async {
    await googleSignIn.signOut();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Signed out successfully')),
    );

    // Navigate back to login screen
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Logged in as:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),

              Text(
                name!,
                style: Theme.of(context).textTheme.titleMedium,
              ),

              const SizedBox(height: 10),

              Text(
                email,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () => _signOut(context),
                icon: const Icon(Icons.logout),
                label: const Text('Sign Out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
