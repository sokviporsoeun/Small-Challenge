import 'package:flutter/material.dart';
import '../../models/grocery.dart';
import '../../data/mock_grocery_repository.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {


  void onCreate() {
    // TODO-4 - Navigate to the form screen using the Navigator push 
    // Navigate to a simple form screen (placeholder)
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const AddGroceryScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (dummyGroceryItems.isNotEmpty) {
      // TODO-1 - Display groceries with an Item builder and  LIst Tile
      // Display groceries with an Item builder and ListTile
      content = ListView.builder(
        itemCount: dummyGroceryItems.length,
        itemBuilder: (ctx, index) => GroceryTile(grocery: dummyGroceryItems[index]),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: onCreate,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}

class GroceryTile extends StatelessWidget {
  const GroceryTile({super.key, required this.grocery});

  final Grocery grocery;

  @override
  Widget build(BuildContext context) {
      //  2 - Display groceries with an Item builder and  LIst Tile
      // Build a tappable ListTile that shows category color name and quantity
    return ListTile(
      leading: Container( width: 15,height: 15,
        decoration: BoxDecoration(
          color: grocery.category.color,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      title: Text(  grocery.name),
      trailing: Text(grocery.quantity.toString()),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tapped "${grocery.name}"')),
        );
      },
    );
  }
}

class AddGroceryScreen extends StatelessWidget {
  const AddGroceryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Grocery')),
      
    );
  }
}
