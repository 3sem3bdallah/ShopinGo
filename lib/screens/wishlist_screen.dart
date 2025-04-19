// import 'package:flutter/material.dart';
// import '../utils/user_data.dart';
// import '../widgets/product_card.dart';

// class WishlistScreen extends StatelessWidget {
//   const WishlistScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final wishlist = UserData.wishlist;

//     return Scaffold(
//       appBar: AppBar(title: const Text("Wishlist")),
//       body: wishlist.isEmpty
//           ? const Center(child: Text("Your wishlist is empty."))
//           : GridView.builder(
//               padding: const EdgeInsets.all(12),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 12,
//                 crossAxisSpacing: 12,
//               ),
//               itemCount: wishlist.length,
//               itemBuilder: (context, index) =>
//                   ProductCard(product: wishlist[index]),
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:shoppingo/screens/product.dart';
import '../utils/user_data.dart';
import '../widgets/product_card.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  // دالة لحذف المنتج من القائمة المفضلة
  void _removeFromWishlist(BuildContext context, Product product) {
    UserData.wishlist.removeWhere((item) => item.name == product.name);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${product.name} has been removed from your wishlist"),
        duration: Duration(seconds: 2),
      ),
    );
    // Note: في StatelessWidget لا نستطيع استخدام setState
    // سيحتاج هذا إلى استخدام state management مثل Provider أو إعادة تحميل الصفحة
  }

  @override
  Widget build(BuildContext context) {
    // تصفية القائمة لإزالة التكرارات
    final uniqueWishlist = UserData.wishlist.fold(<Product>[], (list, product) {
      if (!list.any((item) => item.name == product.name)) {
        list.add(product);
      }
      return list;
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Wishlist")),
      body: uniqueWishlist.isEmpty
          ? const Center(
              child: Text("Your wishlist is empty.",
                  style: TextStyle(fontSize: 16)),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemCount: uniqueWishlist.length,
              itemBuilder: (context, index) {
                final product = uniqueWishlist[index];
                return Stack(
                  children: [
                    ProductCard(product: product),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton(
                        icon: Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: () => _removeFromWishlist(context, product),
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
