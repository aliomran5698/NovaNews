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

  List filteredNews = [];

  bool loading = true;

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    getNews();
  }

  Future<void> getNews() async {
    final data = await supabase.from('news').select();

    setState(() {
      news = data;

      filteredNews = data;

      loading = false;
    });
  }

  void searchNews(String value) {
    setState(() {
      filteredNews = news.where((item) {
        final title = item['title'].toString().toLowerCase();

        return title.contains(value.toLowerCase());
      }).toList();
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
      backgroundColor: const Color(0xffF4F4F4),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: const Text(
          "All News",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout, color: Colors.black),
          ),
        ],
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),

                  child: TextField(
                    controller: searchController,
                    onChanged: searchNews,

                    decoration: InputDecoration(
                      hintText: "Search news...",
                      prefixIcon: const Icon(Icons.search),

                      filled: true,
                      fillColor: Colors.white,

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: RefreshIndicator(
                    onRefresh: getNews,

                    child: filteredNews.isEmpty
                        ? const Center(child: Text("No News"))
                        : ListView.builder(
                            itemCount: filteredNews.length,

                            itemBuilder: (context, index) {
                              final item = filteredNews[index];

                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => DetailsScreen(news: item),
                                    ),
                                  );
                                },

                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 10,
                                  ),

                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),

                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,

                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            const BorderRadius.vertical(
                                              top: Radius.circular(30),
                                            ),

                                        child: Image.network(
                                          item['image'],
                                          height: 220,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(20),

                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,

                                          children: [
                                            const Text(
                                              "4 MIN READ",

                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),

                                            const SizedBox(height: 15),

                                            Text(
                                              item['title'],

                                              style: const TextStyle(
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),

                                            const SizedBox(height: 15),

                                            Text(
                                              item['description'],
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black54,
                                                height: 1.5,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
    );
  }
}
