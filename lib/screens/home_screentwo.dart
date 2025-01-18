import 'package:flutter/material.dart';
import 'package:myapp/providers/gradient_provider.dart';
import 'package:provider/provider.dart';

class HomeScreentwo extends StatelessWidget {
  const HomeScreentwo({super.key});

  @override
  Widget build(BuildContext context) {
    final gradientColors = Provider.of<GradientProvider>(context).colors;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Home Screen'),
      //   actions: [
          // IconButton(
          //   icon: Icon(Icons.settings),
          //   onPressed: () {
          //     Navigator.pushNamed(context, '/settings');
          //   },
          // ),
      //   ],
      // ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topCenter, // Custom alignment for HomeScreentwo
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
            const Center(
              child: Text(
                'Home Screen',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
