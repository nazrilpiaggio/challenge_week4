
import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/drink.dart';
import 'cart_page.dart';
import 'home_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<CartItem> _cartItems = [];

  final List<Drink> _drinkList = const [
    Drink(
      id: 'd1',
      name: 'Espresso',
      price: 18000,
      imageUrl: 'assets/cafe.png',
    ),
    Drink(
      id: 'd2',
      name: 'Americano',
      price: 20000,
      imageUrl: 'assets/cafe.png',
    ),
    Drink(
      id: 'd3',
      name: 'Matcha Latte',
      price: 28000,
      imageUrl: 'assets/cafe.png',
    ),
    Drink(
      id: 'd4',
      name: 'Chocolate Frappe',
      price: 30000,
      imageUrl: 'assets/cafe.png',
    ),
  ];

  void _addToCart(Drink drink, int quantity) {
    if (quantity < 1) return;

    setState(() {
      final index = _cartItems.indexWhere(
        (item) => item.drink.id == drink.id,
      );

      if (index >= 0) {
        _cartItems[index].quantity += quantity;
      } else {
        _cartItems.add(
          CartItem(drink: drink, quantity: quantity),
        );
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$quantity ${drink.name} ditambahkan ke keranjang.',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _removeFromCart(String drinkId) {
    setState(() {
      _cartItems.removeWhere(
        (item) => item.drink.id == drinkId,
      );
    });
  }

  void _clearCart() {
    setState(() {
      _cartItems.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(
        drinkList: _drinkList,
        onAddToCart: _addToCart,
      ),
      CartPage(
        cartItems: _cartItems,
        onRemoveFromCart: _removeFromCart,
        onCheckout: _clearCart,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.local_cafe),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_cart),
            label: 'Keranjang',
            tooltip:
                '${_cartItems.fold<int>(0, (sum, item) => sum + item.quantity)} item',
          ),
        ],
      ),
    );
  }
}
