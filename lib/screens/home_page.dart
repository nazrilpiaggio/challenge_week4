
import 'package:flutter/material.dart';
import '../models/drink.dart';
import 'drink_detail_page.dart';
import 'add_product.dart';

class HomePage extends StatefulWidget {
  final List<Drink> drinkList;
  final Function(Drink, int) onAddToCart;

  const HomePage({
    super.key,
    required this.drinkList,
    required this.onAddToCart,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _searchText = '';

  String _formatRupiah(int price) {
    final digits = price.toString();
    final result = StringBuffer();

    for (int i = 0; i < digits.length; i++) {
      result.write(digits[i]);
      final remaining = digits.length - i - 1;
      if (remaining > 0 && remaining % 3 == 0) {
        result.write('.');
      }
    }

    return 'Rp$result';
  }

  @override
  Widget build(BuildContext context) {
    final filteredDrinks = widget.drinkList.where((drink) {
      return drink.name.toLowerCase().contains(_searchText);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Minuman'),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.local_cafe),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Cari minuman',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchText = value.toLowerCase().trim();
                });
              },
            ),
          ),
          Expanded(
            child: filteredDrinks.isEmpty
                ? const Center(
                    child: Text('Minuman tidak ditemukan.'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      12, 0, 12, 12,
                    ),
                    itemCount: filteredDrinks.length,
                    itemBuilder: (context, index) {
                      final drink = filteredDrinks[index];

                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                          ),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                drink.imageUrl,
                                width: 54,
                                height: 54,
                                fit: BoxFit.cover,
                                errorBuilder: (
                                  context,
                                  error,
                                  stackTrace,
                                ) =>
                                    const Icon(
                                  Icons.local_cafe,
                                  color: Colors.brown,
                                ),
                              ),
                            ),
                            title: Text(
                              drink.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              _formatRupiah(drink.price),
                            ),
                            trailing: Wrap(
                              spacing: 4,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            DrinkDetailPage(
                                          drink: drink,
                                          onAddToCart:
                                              widget.onAddToCart,
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text('Detail'),
                                ),
                                ElevatedButton(
                                  onPressed: () =>
                                      widget.onAddToCart(drink, 1),
                                  child: const Text('Pesan'),
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

      // FloatingActionButton untuk membuka form tambah produk
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddProductPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}