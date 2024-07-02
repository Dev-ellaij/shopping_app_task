import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int indexCategory = 0;
  final Color primaryColors = Colors.blue;
  List<FoodDetail> cartItems = [];

  void addToCart(FoodDetail food) {
    setState(() {
      cartItems.add(food);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        selectedItemColor: primaryColors,
        unselectedItemColor: Colors.green[200],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, size: 30),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, size: 30),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check, size: 30),
            label: "Checkout",
          ),
        ],
        onTap: (index) {
          if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderConfirmationPage(
                  cartItems: cartItems,
                ),
              ),
            );
          }
        },
      ),
      body: ListView(
        children: [
          const SizedBox(height: 15),
          HeaderParts(
            indexCategory: indexCategory,
            primaryColors: primaryColors,
            onTapCategory: (index) {
              setState(() {
                indexCategory = index;
              });
            },
          ),
          const SizedBox(height: 20),
          ItemsDisplay(primaryColors: primaryColors, addToCart: addToCart),
        ],
      ),
    );
  }
}

class OrderConfirmationPage extends StatelessWidget {
  final List<FoodDetail> cartItems;

  const OrderConfirmationPage({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Confirmation"),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {},
              ),
              Positioned(
                right: 7,
                top: 7,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    '${cartItems.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You have placed ${cartItems.length} items in the cart",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text("Order Successful! Thank you for shopping with us."),
          ],
        ),
      ),
    );
  }
}

class HeaderParts extends StatefulWidget {
  final int indexCategory;
  final Color primaryColors;
  final Function(int) onTapCategory;

  // ignore: use_super_parameters
  const HeaderParts({
    Key? key,
    required this.indexCategory,
    required this.primaryColors,
    required this.onTapCategory,
  }) : super(key: key);

  @override
  State<HeaderParts> createState() => _HeaderPartsState();
}

class _HeaderPartsState extends State<HeaderParts> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        topHeader(),
        const SizedBox(height: 30),
        title(),
        const SizedBox(height: 21),
        searchBar(),
        const SizedBox(height: 30),
        categorySelection(),
      ],
    );
  }

  Padding categorySelection() {
    List<String> list = ["All", "Fruits", "Vegetables", "Grocery"];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 35,
        child: ListView.builder(
          itemCount: list.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                widget.onTapCategory(index);
              },
              child: Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    list[index],
                    style: TextStyle(
                      fontSize: 20,
                      color: widget.indexCategory == index
                          ? widget.primaryColors
                          : Colors.black45,
                      fontWeight: widget.indexCategory == index
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Container searchBar() {
    return Container(
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: widget.primaryColors,
                ),
                hintText: "Search food",
                hintStyle: const TextStyle(color: Colors.black26),
              ),
            ),
          ),
          Material(
            color: widget.primaryColors,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.insert_emoticon_sharp,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding title() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hi, welcome",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              fontSize: 18,
            ),
          ),
          Text(
            "Find your food",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 34,
            ),
          ),
        ],
      ),
    );
  }

  Padding topHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Material(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_open_rounded,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 18,
          ),
          const Text(
            "Lagos",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black38,
            ),
          ),
          const Spacer(),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              "assets/female.png",
              height: 40,
              width: 40,
            ),
          ),
        ],
      ),
    );
  }
}

class ItemsDisplay extends StatefulWidget {
  final Color primaryColors;
  final Function(FoodDetail) addToCart;

  const ItemsDisplay(
      {super.key, required this.primaryColors, required this.addToCart});

  @override
  State<ItemsDisplay> createState() => _ItemsDisplayState();
}

class _ItemsDisplayState extends State<ItemsDisplay> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: foodsItems.length,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        FoodDetail food = foodsItems[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CheckoutPage(food: food),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(125),
                        child: Image.asset(
                          food.image,
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        food.name,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Cooking Time: ${food.cookingTime}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            food.rate.toString(),
                            style: const TextStyle(color: Colors.black38),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        '\$${food.price}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 150, top: 10),
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.black45,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Material(
                    color: widget.primaryColors,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    child: InkWell(
                      onTap: () {
                        widget.addToCart(food);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class FoodDetail {
  final String name;
  final String image;
  final String cookingTime;
  final double rate;
  final double price;

  FoodDetail({
    required this.name,
    required this.image,
    required this.cookingTime,
    required this.rate,
    required this.price,
  });
}

List<FoodDetail> foodsItems = [
  FoodDetail(
    name: 'Apple',
    image: 'assets/apple.jpg',
    cookingTime: '5 min',
    rate: 4.5,
    price: 1.99,
  ),
  FoodDetail(
    name: 'Apple',
    image: 'assets/apple.jpg',
    cookingTime: '5 min',
    rate: 4.2,
    price: 0.99,
  ),
];

class CheckoutPage extends StatelessWidget {
  final FoodDetail food;

  const CheckoutPage({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(food.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(125),
                child: Image.asset(
                  food.image,
                  height: 250,
                  width: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              food.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${food.price}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Cooking Time: ${food.cookingTime}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 18,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  food.rate.toString(),
                  style: const TextStyle(color: Colors.black38),
                ),
              ],
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const OrderConfirmationPage(cartItems: []),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Proceed to Checkout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
