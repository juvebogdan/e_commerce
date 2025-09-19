import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/services/products_list.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final String _collectionName = "user information";
  late CollectionReference _ref;
  String? firstName;
  String? lastName;
  String? address;
  String? phoneNumber;
  String? userId;
  List<Product> cart = [];

  User? _cachedUser;

  UserService() {
    _ref = _fireStore.collection(_collectionName);
  }

  Future<void> getUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        _cachedUser = user;
        userId = _cachedUser!.uid;

        var document = _ref.doc(userId);
        var value = await document.get();
        var data = value.data() as Map<String, dynamic>?;

        if (data != null) {
          firstName = data["first name"] as String?;
          lastName = data["last name"] as String?;
          address = data["address"] as String?;
          phoneNumber = data["phone number"] as String?;
          List<String> cartProductIds = List<String>.from(data["cart"] ?? []);
          await _loadCartProducts(cartProductIds);
        }
      }
    } catch (e) {
      print("Error in getUser: $e");
    }
  }

  Future<void> _loadCartProducts(List<String> productIds) async {
    cart.clear();
    ListOfProducts listOfProducts = ListOfProducts();
    for (String id in productIds) {
      Product? product = await listOfProducts.getProductById(id);
      if (product != null) {
        cart.add(product);
      }
    }
  }

  double getCartTotal() {
    double total = 0;
    for (Product product in cart) {
      total += double.tryParse(product.price) ?? 0.0;
    }
    return total;
  }

  Future<void> addProductToCart(Product product) async {
    cart.add(product);
    await _updateCartInFirestore();
  }

  Future<void> removeProductFromCart(Product product) async {
    cart.removeWhere((p) => p.id == product.id);
    await _updateCartInFirestore();
  }

  Future<void> _updateCartInFirestore() async {
    try {
      if (userId != null) {
        List<String> cartProductIds = cart.map((p) => p.id).toList();
        await _ref.doc(userId).update({"cart": cartProductIds});
      }
    } catch (e) {
      print("Error updating cart in Firestore: $e");
    }
  }
}
