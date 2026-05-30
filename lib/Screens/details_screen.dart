
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final dynamic news;

  const DetailsScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f7fb),
      body: Stack(
        children: [
          Image.network(
            news['image'],
            height: 420,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          SafeArea(
            child: IconButton(
              icon: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.arrow_back, color: Colors.black),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 360),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(28),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(35),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.calendar_month, size: 20),
                          SizedBox(width: 8),
                          Text("May 28, 2026"),
                          SizedBox(width: 15),
                          Text("•"),
                          SizedBox(width: 15),
                          Text("2 min read"),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Text(
                        news['title'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),

                      const SizedBox(height: 30),

                      Text(
                        news['description'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 21,
                          height: 1.8,
                          color: Color(0xff2f3343),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
