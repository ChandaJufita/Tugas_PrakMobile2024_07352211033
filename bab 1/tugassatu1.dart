import 'dart:async';
enum Role { Admin, Customer }
class Product {
  String productName;
  double price;
  bool inStock;

  Product(this.productName, this.price, this.inStock);

  @override
  String toString() {
    return '$productName - Rp$price - ${inStock ? "Ada" : "Habis"}';
  }
}

abstract class User {
  String name;
  int age;
  late List<Product> _products;
  Role role;

  User(this.name, this.age, this.role) {
    _products = [];
  }
  List<Product> get products => _products;
  void showInfo() {
    print('Nama: $name, Usia: $age, Peran: ${role.name}');
  }
}

class AdminUser extends User {
  AdminUser(String name, int age) : super(name, age, Role.Admin);

  void addProduct(Product product) {
    if (product.inStock) {
      if (!products.any((p) => p.productName == product.productName)) {
        products.add(product);
        print('${product.productName} berhasil ditambahkan oleh Admin.');
      } else {
        print('${product.productName} sudah ada dalam daftar.');
      }
    } else {
      throw Exception('Produk ${product.productName} tidak ada stok!');
    }
  }

  void removeProduct(String productName) {
    products.removeWhere((product) => product.productName == productName);
    print('$productName berhasil dihapus dari daftar produk.');
  }
}

class CustomerUser extends User {
  CustomerUser(String name, int age) : super(name, age, Role.Customer);

  void viewProducts() {
    print('\nDAFTAR PRODUK');
    if (products.isEmpty) {
      print('Produk tidak tersedia.');
    } else {
      for (var product in products) {
        print(product);
      }
    }
  }
}

Future<List<Product>> fetchProductDetails() async {
  print('Mengambil detail dari produk');
  await Future.delayed(Duration(seconds: 2));
  print('Detail produk berhasil diambil.');
  return [
    Product('iphone', 4000000.0, true),
    Product('samsung', 2000000.0, true),
    Product('lenovo', 150000.0, false)
  ];
}

void main() async {
  // Membuat objek Admin dan Customer
  AdminUser admin = AdminUser('Chanda', 19);
  CustomerUser customer = CustomerUser('Jufita', 19);

  try {
    admin.addProduct(Product('Sepatu', 200000.0, true));
    admin.addProduct(Product('Baju', 250000.0, true));
    admin.addProduct(Product('Tas', 450000.0, false));
  } on Exception catch (e) {
    print('Error pada bagian: $e');
  }
  admin.showInfo();
  customer.showInfo();
  customer.products.addAll(admin.products);
  customer.viewProducts();
  List<Product> additionalProducts = await fetchProductDetails();
  for (var product in additionalProducts) {
    try {
      admin.addProduct(product);
    } on Exception catch (e) {
      print('Error pada bagian: $e');
    }
  }

  customer.products.clear();
  customer.products.addAll(admin.products);
  customer.viewProducts();
  Map<String, Product> productMap = {
    for (var product in admin.products) product.productName: product
  };
  print('\nDaftar Produk Di Map');
  productMap.forEach((key, value) {
    print('$key - $value');
  });
  Set<Product> uniqueProducts = {...admin.products};
  print('\nDafatar Produk Unik');
  uniqueProducts.forEach((product) {
    print(product);
  });
}
