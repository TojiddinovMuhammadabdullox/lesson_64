import 'package:flutter/material.dart';
import 'package:lesson_64/model/card_mmodel.dart';
import 'package:lesson_64/model/product_model.dart';
import 'package:lesson_64/views/screens/cart_screen.dart';
import 'package:lesson_64/views/screens/order_scren.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  final List<Item> items = List.generate(
    30,
    (index) => Item(
      name: getColorName(index),
      color: Colors.primaries[index % Colors.primaries.length],
      price: (index + 1) * 10.0,
    ),
  );

  MyHomePage({super.key});

  static String getColorName(int index) {
    List<String> colorNames = [
      "Red",
      "Pink",
      "Purple",
      "Deep Purple",
      "Indigo",
      "Blue",
      "Light Blue",
      "Cyan",
      "Teal",
      "Green",
      "Light Green",
      "Lime",
      "Yellow",
      "Amber",
      "Orange",
      "Deep Orange",
      "Brown",
      "Grey",
      "Blue Grey",
      "Red Accent",
      "Pink Accent",
      "Purple Accent",
      "Deep Purple Accent",
      "Indigo Accent",
      "Blue Accent",
      "Light Blue Accent",
      "Cyan Accent",
      "Teal Accent",
      "Green Accent",
      "Light Green Accent"
    ];
    return colorNames[index % colorNames.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          "Catalog",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (ctx) => const CartScreen()),
              );
            },
            icon: const Icon(
              Icons.shopping_cart,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (ctx) => const OrdersScreen()),
              );
            },
            icon: const Icon(
              Icons.list,
              size: 30,
            ),
          ),
        ],
      ),
      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              int quantity = cart.items
                  .where((cartItem) => cartItem.item == items[index])
                  .map((cartItem) => cartItem.quantity)
                  .fold(0, (prev, element) => prev + element);
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: items[index].color,
                ),
                title: Text(items[index].name),
                subtitle: Text('\$${items[index].price.toStringAsFixed(2)}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        Provider.of<CartModel>(context, listen: false)
                            .removeItem(items[index]);
                      },
                    ),
                    Text('$quantity'),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        Provider.of<CartModel>(context, listen: false)
                            .addItem(items[index]);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
