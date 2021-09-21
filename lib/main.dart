import 'dart:convert';

import 'package:Simple_menu/menuwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';

import 'Model/menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple menu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Kisaku Cafe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String ddValue = "Gofood";

  Color primaryColor = Color(0xffff9742);

  List<Menu> slsMenu = [];

  Future<List<Menu>> readJson() async {
    List<Menu> _return = [];
    final String response = await rootBundle.loadString('assets/data.json');
    jsonDecode(response).forEach((x) {
      _return.add(Menu.fromjson(x));
    });
    return List.generate(_return.length, (index) => _return[index]);
  }

  String total() {
    int _return = 0;
    slsMenu.forEach((x) {
      _return = _return + x.price;
    });

    return (NumberFormat.currency(locale: 'id', decimalDigits: 0, symbol: "")
        .format(_return));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
              backgroundColor: primaryColor,
              title: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: ddValue,
                          items: <String>["Gofood", "Grab"]
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                              ),
                            );
                          }).toList(),
                          onChanged: (String value) {
                            setState(() {
                              ddValue = value;
                            });
                          },
                          icon: Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: Colors.white,
                          ),
                          dropdownColor: Colors.orange,
                          iconSize: 32,
                          elevation: 16,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        widget.title.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(80.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.apps,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: TextField(
                                controller: TextEditingController(),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  suffixIcon: Icon(
                                    Icons.search,
                                    color: primaryColor,
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  labelText: "Cari produk",
                                  filled: true,
                                  labelStyle: TextStyle(fontSize: 14),
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.qr_code_scanner_rounded,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 8),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  "Kategori",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 24),
                                padding: EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 35,
                      child: TabBar(
                        indicatorColor: Colors.white,
                        isScrollable: false,
                        labelColor: Colors.white,
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        indicatorSize: TabBarIndicatorSize.label,
                        tabs: [
                          Tab(text: "Semua"),
                          Tab(icon: Icon(Icons.favorite)),
                          Tab(
                            icon: SvgPicture.asset(
                              'assets/icon/discount.svg',
                              height: 20,
                              color: Colors.white,
                            ),
                          ),
                          Tab(text: "Promo"),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: null,
            backgroundColor: Colors.green,
            label: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    slsMenu.length.toString() + " item",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        total(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Icon(
                          Feather.shopping_cart,
                          color: Colors.white,
                          size: 18,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: primaryColor,
            fixedColor: Colors.white,
            unselectedItemColor: Colors.white,
            items: [
              BottomNavigationBarItem(
                label: "Menu",
                icon: Icon(Feather.book_open),
              ),
              BottomNavigationBarItem(
                label: "Pesanan",
                icon: Icon(Feather.shopping_cart),
              ),
              BottomNavigationBarItem(
                label: "Akun",
                icon: Icon(Feather.clipboard),
              ),
            ],
          ),
          body: TabBarView(
            children: [
              Container(
                child: FutureBuilder(
                    future: readJson(),
                    builder: (context, data) {
                      if (data.hasData) {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.9,
                            crossAxisSpacing: 8,
                          ),
                          itemCount: data.data.length,
                          padding: EdgeInsets.all(8),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            Menu currentMenu = data.data[index];
                            return MenuWidget(
                              key: Key(currentMenu.name),
                              menu: currentMenu,
                              isSelected: (value) {
                                setState(() {
                                  if (value) {
                                    slsMenu.add(currentMenu);
                                  } else {
                                    slsMenu.removeWhere(
                                        (x) => x.name == currentMenu.name);
                                  }
                                });
                              },
                            );
                          },
                        );
                      } else if (data.hasError) {
                        return Text("Error");
                      }
                      return Text("Loading...");
                    }),
              ),
              Container(
                color: Colors.cyan,
              ),
              Container(
                color: Colors.greenAccent,
              ),
              Container(
                color: Colors.purple,
              ),
            ],
          )),
    );
  }
}
