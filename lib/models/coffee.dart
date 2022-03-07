final coffees = List.generate(
  _names.length,
  (index) => Coffee(
    name: _names[index],
    image: 'assets/images/${index + 1}.png',
    price: _prices[index],
  ),
);

class Coffee {
  Coffee({
    required this.name,
    required this.image,
    required this.price,
  });

  final String name;
  final String image;
  final String price;
}

final _names = [
  'Caramel Macchiato',
  'Caramel Cold Drink',
  'Iced Coffe Mocha',
  'Caramelized Pecan Latte',
  'Toffee Nut Latte',
  'Capuchino',
  'Toffee Nut Iced Latte',
  'Americano',
  'Vietnamese-Style Iced Coffee',
  'Black Tea Latte',
  'Classic Irish Coffee',
  'Toffee Nut Crunch Latte',
];

final _prices = [
  '5.0',
  '10.5',
  '20.0',
  '22.0',
  '15.0',
  '18.0',
  '11.0',
  '8.0',
  '12.0',
  '10.0',
  '15.0',
  '23.0',
];
