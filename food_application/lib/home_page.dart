import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedTabIndex = 0;
  bool showOnlyVeg = false;
  String searchQuery = '';

  final menuItems = [
    {
      'name': 'Special Dish',
      'image': 'assets/Vegetarian food platter.jpg',
      'type': 'South Indian',
      'price': 259,
      'isVeg': true,
      'quantity': 0,
    },
    {
      'name': 'Paneer Tikka',
      'image': 'assets/Paneer tikka.jpg',
      'type': 'North Indian',
      'price': 299,
      'isVeg': true,
      'quantity': 0,
    },
    {
      'name': 'Biryani',
      'image': 'assets/Biryani dish.jpg',
      'type': 'Hyderabadi',
      'price': 399,
      'isVeg': false,
      'quantity': 0,
    },
    {
      'name': 'Gulab Jamun',
      'image': 'assets/Gulab jamun.jpg',
      'type': 'Dessert',
      'price': 99,
      'isVeg': true,
      'quantity': 0,
    },
    {
      'name': 'Catering Service',
      'image': 'assets/Catering service logo.jpg',
      'type': 'Service',
      'price': 999,
      'isVeg': false,
      'quantity': 0,
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    return menuItems.where((item) {
      final matchesSearch = searchQuery.isEmpty ||
          item['name'].toString().toLowerCase().contains(searchQuery.toLowerCase());
      final matchesVeg = !showOnlyVeg || item['isVeg'] as bool;
      return matchesSearch && matchesVeg;
    }).toList();
  }

  List<Map<String, dynamic>> get cartItems {
    return menuItems.where((item) {
      final quantity = item['quantity'] as int? ?? 0; // Safely cast to int, defaulting to 0 if null
      return quantity > 0;
    }).toList();
  }

  int get cartTotal {
    return cartItems.fold<int>(0, (total, item) {
      final price = item['price'] as int? ?? 0;
      final quantity = item['quantity'] as int? ?? 0;
      return total + (price * quantity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interactive Food Menu'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearchBar(context),
          ),
          Switch(
            value: showOnlyVeg,
            onChanged: (value) => setState(() => showOnlyVeg = value),
            activeColor: Colors.green,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildServiceTabs(),
            Expanded(
              child: _buildMenuItems(context),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildServiceTabs() {
    final tabs = ['Breakfast', 'Lunch', 'Snacks', 'Dinner', 'Desserts'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          tabs.length,
              (index) => GestureDetector(
            onTap: () {
              setState(() => selectedTabIndex = index);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: selectedTabIndex == index ? Colors.purple : Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                tabs[index],
                style: TextStyle(
                  color: selectedTabIndex == index ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final item = filteredItems[index];
        return _buildMenuItem(item);
      },
    );
  }

  Widget _buildMenuItem(Map<String, dynamic> item) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(item['image']),
          onBackgroundImageError: (_, __) => const Icon(Icons.error),
        ),
        title: Text(item['name']),
        subtitle: Text('${item['type']} • ₹${item['price']}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  if (item['quantity'] > 0) item['quantity'] -= 1;
                });
              },
            ),
            Text(item['quantity'].toString()),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                setState(() {
                  item['quantity'] += 1;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Total: ₹$cartTotal', style: const TextStyle(fontSize: 18)),
          ),
          ElevatedButton(
            onPressed: cartItems.isEmpty
                ? null
                : () => _showCartDetails(context),
            child: const Text('View Cart'),
          ),
        ],
      ),
    );
  }

  void _showSearchBar(BuildContext context) {
    showSearch(
      context: context,
      delegate: FoodSearchDelegate(
        menuItems: menuItems,
        onQueryUpdate: (query) => setState(() => searchQuery = query),
      ),
    );
  }

  void _showCartDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: cartItems.length,
          itemBuilder: (context, index) {
            final item = cartItems[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(item['image']),
              ),
              title: Text(item['name']),
              subtitle: Text('Quantity: ${item['quantity']} • ₹${item['price'] * item['quantity']}'),
            );
          },
        );
      },
    );
  }
}

class FoodSearchDelegate extends SearchDelegate {
  final List<Map<String, dynamic>> menuItems;
  final ValueChanged<String> onQueryUpdate;

  FoodSearchDelegate({required this.menuItems, required this.onQueryUpdate});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          onQueryUpdate(query);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = menuItems.where((item) {
      return item['name'].toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final item = suggestions[index];
        return ListTile(
          title: Text(item['name']),
          onTap: () {
            query = item['name'];
            onQueryUpdate(query);
            close(context, null);
          },
        );
      },
    );
  }
}
