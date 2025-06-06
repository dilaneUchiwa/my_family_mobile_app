import 'package:flutter/material.dart';
import 'package:my_family_mobile_app/views/components/custom_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('My Family Tree'),
      ),
      body: const Center(
        child: Text(
          'Welcome to the Home Page!',
        ),
      ),
    );
  }
}