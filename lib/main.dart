import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Search App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SearchPage(),
    );
  }
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> _allItems = [
    {
      'photo': 'assets/images/macbook.jpg',
      'name': 'MacBook Pro 13 2017',
      'price': '5,079,360 UZS'
    },
    {
      'photo': 'assets/images/macbook1.jpg',
      'name': 'Apple MacBookPro/Air',
      'price': '299,000 UZS'
    },
    {
      'photo': 'assets/images/macbook2.jpg',
      'name': 'MacBook PRO 2023',
      'price': '5,000,000 UZS'
    },
    {
      'photo': 'assets/images/macbook3.jpg',
      'name': 'MacBook Air 2020',
      'price': '4,000,000 UZS'
    },
    {
      'photo': 'assets/images/macbook.jpg',
      'name': 'MacBook Pro 16 2019',
      'price': '6,000,000 UZS'
    },
    {
      'photo': 'assets/images/macbook2.jpg',
      'name': 'MacBook 12 2015',
      'price': '3,000,000 UZS'
    },
    {
      'photo': 'assets/images/macbook1.jpg',
      'name': 'MacBook Pro 15 2018',
      'price': '5,500,000 UZS'
    },
    {
      'photo': 'assets/images/macbook3.jpg',
      'name': 'MacBook Air 2019',
      'price': '4,500,000 UZS'
    },
    {
      'photo': 'assets/images/macbook2.jpg',
      'name': 'MacBook Pro 14 2021',
      'price': '7,000,000 UZS'
    },
    {
      'photo': 'assets/images/macbook.jpg',
      'name': 'MacBook Air 2021',
      'price': '5,000,000 UZS'
    },
  ];
  List<Map<String, String>> _results = [];
  String _view = 'gallery';

  void _search() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _results = _allItems
          .where((item) => item['name']!.toLowerCase().contains(query))
          .toList();
    });
  }

  void _toggleView(String view) {
    setState(() {
      _view = view;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Page'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) => _search(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _search,
                  child: const Text('Search'),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _toggleView('gallery'),
                child: const Text('Gallery'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => _toggleView('list'),
                child: const Text('List'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => _toggleView('tile'),
                child: const Text('Tile'),
              ),
            ],
          ),
          Expanded(
            child: _results.isEmpty
                ? const Center(child: Text('No results found'))
                : _view == 'list'
                    ? _buildListView()
                    : _buildGridView(),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: _results.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.asset(
            _results[index]['photo'] ?? '',
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          title: Text(_results[index]['name'] ?? ''),
          subtitle: Text(_results[index]['price'] ?? ''),
        );
      },
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _view == 'gallery' ? 2 : 3,
        childAspectRatio: 2 / 3,
      ),
      itemCount: _results.length,
      itemBuilder: (context, index) {
        return Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                _results[index]['photo'] ?? '',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              Text(_results[index]['name'] ?? '', textAlign: TextAlign.center),
              const SizedBox(height: 10),
              Text(_results[index]['price'] ?? '', textAlign: TextAlign.center),
            ],
          ),
        );
      },
    );
  }
}
