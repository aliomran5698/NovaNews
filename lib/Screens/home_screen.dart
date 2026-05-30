import 'package:flutter/material.dart';

import '../main.dart';
import 'details_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List news = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();

    getNews();
  }

  Future<void> getNews() async {
    final data = await supabase.from('news').select();

    setState(() {
      news = data;
      loading = false;
    });
  }

  Future<void> logout() async {
    await supabase.auth.signOut();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News App"),

        actions: [
          IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
        ],
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : news.isEmpty
          ? const Center(child: Text("No News"))
          : RefreshIndicator(
              onRefresh: getNews,

              child: ListView.builder(
                itemCount: news.length,

                itemBuilder: (context, index) {
                  final item = news[index];

                  return Card(
                    margin: const EdgeInsets.all(10),

                    child: ListTile(
                      title: Text(item['title']),

                      subtitle: Text(item['description'], maxLines: 2),

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailsScreen(news: item),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}
