import 'package:flutter/material.dart';
import 'package:lesson_64/model/card_mmodel.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          "Your Orders",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          return ListView.builder(
            itemCount: cart.orders.length,
            itemBuilder: (context, index) {
              final order = cart.orders[index];
              return ExpansionTile(
                title: Text('Order ${order.id}'),
                subtitle: Text(
                  'Date: ${order.date.toString()} - Total: \$${order.products.fold(0.0, (total, current) => total + current.price).toStringAsFixed(2)}',
                ),
                children: order.products.map((cartItem) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: cartItem.item.color,
                    ),
                    title: Text(cartItem.item.name),
                    subtitle: Text(
                      '\$${cartItem.item.price.toStringAsFixed(2)} x ${cartItem.quantity}',
                    ),
                  );
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }
}
