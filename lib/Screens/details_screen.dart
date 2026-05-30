import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final dynamic news;

  const DetailsScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("News Details")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              news['title'],

              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Text(news['description'], style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
