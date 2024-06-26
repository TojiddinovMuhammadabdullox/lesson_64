import 'package:flutter/material.dart';
import 'product_model.dart';

class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double get totalBalance => _items.fold(
      0.0, (total, current) => total + current.price * current.quantity);

  void addItem(Item item) {
    int index = _items.indexWhere((cartItem) => cartItem.item == item);
    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(item: item, quantity: 1));
    }
    notifyListeners();
  }

  void removeItem(Item item) {
    int index = _items.indexWhere((cartItem) => cartItem.item == item);
    if (index >= 0) {
      _items[index].quantity--;
      if (_items[index].quantity == 0) {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void editItem(Item item, int quantity) {
    int index = _items.indexWhere((cartItem) => cartItem.item == item);
    if (index >= 0) {
      _items[index].quantity = quantity;
      notifyListeners();
    }
  }

  void purchaseItems() {
    if (_items.isNotEmpty) {
      Order order = Order(
        id: DateTime.now().toString(),
        products: List.from(_items),
        date: DateTime.now(),
      );
      _orders.add(order);
      _items.clear();
      notifyListeners();
    }
  }

  List<Order> _orders = [];

  List<Order> get orders => _orders;
}

class CartItem {
  final Item item;
  int quantity;

  CartItem({required this.item, required this.quantity});

  double get price => item.price * quantity;
}

class Order {
  final String id;
  final List<CartItem> products;
  final DateTime date;

  Order({required this.id, required this.products, required this.date});
}
