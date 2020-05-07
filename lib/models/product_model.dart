class Product {
  int id;
  int categoryId;
  String name;
  String description;
  double price;
  List images;
  List sizes;

  Product.fromMap(Map data) {
    this.id = data["id"];
    this.categoryId = data["categoryId"];
    this.name = data["name"];
    this.description = data["description"];
    this.price = data["price"];
    this.images = data["images"];
    this.sizes = data["sizes"];
  }
}