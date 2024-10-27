import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'watchlist/watchlist_provider.dart'; // Import WatchlistProvider
import 'auth/signup.dart'; // Your signup page
import 'auth/login.dart'; // Your login page
import 'pages/home_page.dart'; // Your home page (with movie listings)

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => WatchlistProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie App'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        foregroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text('Login'),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                backgroundColor: Color.fromARGB(255, 0, 0, 0),
                foregroundColor: Color.fromARGB(255, 255, 255, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignupPage()),
                );
              },
              child: const Text('Sign Up'),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                backgroundColor: Color.fromARGB(255, 5, 5, 5),
                foregroundColor: Color.fromARGB(255, 255, 255, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 70),
            GestureDetector(
              onTap: () {
                // Navigate to the home page with movie listings
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage()), // Home page for movies
                );
              },
              child: const Text(
                'Continue without signin',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(
                      255, 0, 0, 0), // Change this to your desired text color
                  decoration:
                      TextDecoration.underline, // Optional: underline the text
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
