import 'package:flutter/material.dart';

class BlogView extends StatefulWidget {
  @override
  _BlogViewState createState() => _BlogViewState();
}

class _BlogViewState extends State<BlogView> {
  final List<Map<String, String>> _blogPosts = [
    {
      "title": "Introduction to Flutter",
      "author": "John Doe",
      "date": "Oct 27, 2024",
      "image": "",
      "excerpt":
          "Flutter is Google’s UI toolkit for building natively compiled applications..."
    },
    {
      "title": "The Rise of AI in Healthcare",
      "author": "Jane Smith",
      "date": "Oct 26, 2024",
      "image": "",
      "excerpt":
          "Artificial intelligence (AI) is transforming the healthcare industry..."
    },
    {
      "title": "How to Build a Mobile App",
      "author": "Alice Lee",
      "date": "Oct 25, 2024",
      "image": "",
      "excerpt":
          "Building a mobile app involves planning, designing, and coding..."
    },
    // Add more blog posts here
  ];

  String _searchText = "";
  final List<String> _categories = [
    "All",
    "Tech",
    "Health",
    "Business",
    "Lifestyle"
  ];
  String _selectedCategory = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blog"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search articles...",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onChanged: (value) {
                setState(() {
                  _searchText = value.toLowerCase();
                });
              },
            ),
          ),

          // Categories
          Container(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                String category = _categories[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: _selectedCategory == category
                          ? Colors.green
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: TextStyle(
                          color: _selectedCategory == category
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Blog List
          Expanded(
            child: ListView.builder(
              itemCount: _blogPosts.length,
              itemBuilder: (context, index) {
                final blogPost = _blogPosts[index];
                // Filter posts by search text and category
                if ((_selectedCategory != "All" &&
                        blogPost["title"] != _selectedCategory) ||
                    (!_searchText.isEmpty &&
                        !blogPost["title"]!
                            .toLowerCase()
                            .contains(_searchText))) {
                  return Container();
                }
                return GestureDetector(
                  onTap: () {
                    // Navigate to detailed blog view
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          // Thumbnail image
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: AssetImage(blogPost["image"]!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          // Blog details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  blogPost["title"]!,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "By ${blogPost["author"]} • ${blogPost["date"]}",
                                  style: TextStyle(
                                      color: Colors.grey[600], fontSize: 12),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  blogPost["excerpt"]!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
