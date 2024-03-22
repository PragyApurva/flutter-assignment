import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Repositories',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> repositories = [];

  Future<void> fetchRepositories() async {
    final response = await http.get(Uri.parse('https://api.github.com/users/freeCodeCamp/repos'));
    if (response.statusCode == 200) {
      setState(() {
        repositories = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load repositories');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRepositories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub Repositories'),
      ),
      body: repositories.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: repositories.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(repositories[index]['name']),
                  subtitle: Text(repositories[index]['description'] ?? 'No description available'),
                  onTap: () {
                    // Add functionality to navigate to repository details if needed
                  },
                );
              },
            ),
    );
  }
}
