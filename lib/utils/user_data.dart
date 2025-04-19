import '../screens/product.dart';

class UserData {
  static String username = "Guest";
  static List<Product> cart = [];
  static List<Product> wishlist = [];
  
  // إضافة قاموس لتخزين بيانات المستخدمين
  static Map<String, Map<String, String>> users = {
    // يمكن إضافة بعض المستخدمين الافتراضيين هنا
    'user.com': {
      'name': 'Test',
      'password': '123456'
    },
  };
}