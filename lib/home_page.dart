import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<String> _dogImages = [];

  @override
  void initState() {
    super.initState();
    _fetchDogImages();
  }

  Future<void> _fetchDogImages() async {
    final response = await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random/10'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _dogImages = List<String>.from(data['message']);
      });
    } else {
      throw Exception('Failed to load dog images');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ), 
      body: _dogImages.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              padding: const EdgeInsets.all(10.0),
              itemCount: _dogImages.length,
              itemBuilder: (context, index) {
                return Image.network(_dogImages[index]);
              },
            ),
    );
  }
}
