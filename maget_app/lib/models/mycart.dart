import 'package:flutter/widgets.dart';

import 'cartitem_model.dart';


// class MyCart extends ChangeNotifier {
//   List<CartItemModel> items = [];
//   List<CartItemModel> get cartItems => items;

//   bool addItem(CartItemModel cartItem) {
//     for (CartItem cart in cartItems) {
//       if (cartItem.Productid != cart.Productid) {
//         return false;
//       }
//       if (cartItem.name == cart.name) {
//         cartItems[cartItems.indexOf(cart)].quantity++;
//         notifyListeners();
//         return true;
//       }
//     }

//     items.add(cartItem);
//     notifyListeners();
//     return true;
//   }

//   void clearCart() {
//     items.clear();
//     notifyListeners();
//   }

//   void decreaseItem(CartItem cartModel) {
//     if (cartItems[cartItems.indexOf(cartModel)].quantity <= 1) {
//       return;
//     }
//     cartItems[cartItems.indexOf(cartModel)].quantity--;
//     notifyListeners();
//   }

//   void increaseItem(CartItem cartModel) {
//     cartItems[cartItems.indexOf(cartModel)].quantity++;
//     notifyListeners();
//   }

//   void removeAllInCart(Product food) {
//     cartItems.removeWhere((f) {
//       return f.notes.name == food.name;
//     });
//     notifyListeners();
//   }
// }

// class CartItem {
//   final Product notes;
//   int quantity;

//   CartItem({required this.notes, required this.quantity});
// }
