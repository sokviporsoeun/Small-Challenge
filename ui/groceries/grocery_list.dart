import 'package:flutter/material.dart';
import '../../models/grocery.dart';
import '../../data/mock_grocery_repository.dart';
import 'grocery_form.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {

  final ScrollController _scrollController = ScrollController();
// TODO-4 - Navigate to the form screen using the Navigator push 
  Future<void> onCreate() async {
    // Push the form and await the created Grocery via pop()
    final newGrocery = await Navigator.of(context).push<Grocery>(
      MaterialPageRoute(builder: (ctx) => const NewItem()),
    );

    if (newGrocery != null) {
      setState(() {
        dummyGroceryItems.add(newGrocery);
      });

      // After the frame is rendered, scroll to the bottom to reveal the new item
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent + 100,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Added "${newGrocery.name}"')),
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (dummyGroceryItems.isNotEmpty) {
      // TODO-1 - Display groceries with an Item builder and  LIst Tile
      // Display groceries with an Item builder and ListTile
      content = ListView.builder(
        controller: _scrollController,
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
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Tapped "${grocery.name}"')),
        // );
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
