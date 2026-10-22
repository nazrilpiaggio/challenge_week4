
import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartPage extends StatefulWidget {
  final List<CartItem> cartItems;
  final Function(String) onRemoveFromCart;
  final VoidCallback onCheckout;

  const CartPage({
    super.key,
    required this.cartItems,
    required this.onRemoveFromCart,
    required this.onCheckout,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _mejaController = TextEditingController();

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
  void dispose() {
    _namaController.dispose();
    _mejaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = widget.cartItems.fold<int>(
      0,
      (sum, item) =>
          sum + item.drink.price * item.quantity,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
        centerTitle: true,
      ),
      body: widget.cartItems.isEmpty
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 72,
                    color: Colors.brown,
                  ),
                  SizedBox(height: 12),
                  Text('Keranjang kamu masih kosong.'),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(12),
                    children: [
                      ...widget.cartItems.map((item) {
                        return Card(
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                item.drink.imageUrl,
                                width: 48,
                                height: 48,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) =>
                                        const Icon(
                                  Icons.local_cafe,
                                  color: Colors.brown,
                                ),
                              ),
                            ),
                            title: Text(item.drink.name),
                            subtitle: Text(
                              '${item.quantity} cup × '
                              '${_formatRupiah(item.drink.price)}'
                              '\nSubtotal: '
                              '${_formatRupiah(item.drink.price * item.quantity)}',
                            ),
                            isThreeLine: true,
                            trailing: IconButton(
                              tooltip: 'Hapus',
                              onPressed: () =>
                                  widget.onRemoveFromCart(
                                item.drink.id,
                              ),
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        );
                      }),

                      const SizedBox(height: 16),

                      const Text(
                        'Data Pemesan',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16),

                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Field Nama Pemesan
                            TextFormField(
                              controller: _namaController,
                              decoration: const InputDecoration(
                                labelText: 'Nama Pemesan',
                                hintText: 'Masukkan nama pemesan',
                                prefixIcon: Icon(Icons.person_outline),
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty) {
                                  return 'Nama Pemesan tidak boleh kosong';
                                }

                                return null;
                              },
                            ),

                            const SizedBox(height: 16),

                            // Field Nomor Meja
                            TextFormField(
                              controller: _mejaController,
                              keyboardType:
                                  TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Nomor Meja',
                                hintText: 'Masukkan nomor meja (1-20)',
                                prefixIcon: Icon(Icons.table_restaurant),
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty) {
                                  return 'Nomor Meja tidak boleh kosong';
                                }

                                if (!RegExp(r'^[0-9]+$')
                                    .hasMatch(value.trim())) {
                                  return 'Nomor Meja harus berupa angka';
                                }

                                final nomorMeja =
                                    int.parse(value.trim());

                                if (nomorMeja < 1 ||
                                    nomorMeja > 20) {
                                  return 'Nomor Meja harus antara 1-20';
                                }

                                return null;
                              },
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),
                    ],
                  ),
                ),

                // Total harga dan tombol Checkout
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total harga',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _formatRupiah(totalPrice),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      ElevatedButton(
                        onPressed: () {
                          // Periksa validasi semua field
                          if (_formKey.currentState!.validate()) {
                            _showCheckoutDialog(
                              context,
                              totalPrice,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                        ),
                        child: const Text('Checkout'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  void _showCheckoutDialog(
    BuildContext context,
    int totalPrice,
  ) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Checkout Berhasil'),
        content: Text(
          'Pesanan atas nama ${_namaController.text.trim()} '
          'untuk meja ${_mejaController.text.trim()} '
          'berhasil dibuat dengan total '
          '${_formatRupiah(totalPrice)}.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              widget.onCheckout();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
