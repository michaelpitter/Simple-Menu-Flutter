class Menu {
  final String url, name;
  final int price;

  Menu({
    this.url,
    this.name,
    this.price,
  });

  factory Menu.fromjson(Map<String, dynamic> js) {
    return Menu(
      url: js['url'],
      name: js['name'],
      price: js['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'name': name,
      'price': price,
    };
  }
}
