import 'package:flutter/material.dart';
import 'package:diary/home_page.dart'; // Import the HomePage

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _errorMessage;

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username.isNotEmpty && password.isNotEmpty) {
      setState(() {
        _errorMessage = 'Login Successful.....';
      });
      // Pass the username to the HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              HomePage(username: username), // Pass the username here
        ),
      );
    } else {
      setState(() {
        _errorMessage = 'Please enter both username and password :(';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Login'),
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.network(
              'https://tse3.mm.bing.net/th?id=OIP.BdFwMwpRvn0gYDrHEmHYogHaDY&pid=Api&P=0&h=180', // Replace with a working image URL if needed
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Container(
              width: 350, // Set container width
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white
                    .withOpacity(0.8), // Background color with transparency
                borderRadius: BorderRadius.circular(16), // Rounded corners
              ),
              child: Column(
                mainAxisSize:
                    MainAxisSize.min, // Minimize the size of the column
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Center the input fields
                children: [
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person), // Default username icon
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock), // Default password icon
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _login,
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 10),
                  if (_errorMessage != null) // Show error message if it exists
                    Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
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
