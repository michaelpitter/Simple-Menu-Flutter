import 'package:Simple_menu/Model/menu.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatefulWidget {
  final Key key;
  Function() onTap;
  final Menu menu;
  final ValueChanged<bool> isSelected;

  MenuWidget({
    this.key,
    this.menu,
    this.isSelected,
  });

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  @override
  bool isSelected = false;
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xffff9742) : Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.grey[300],
          )
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          isSelected = !isSelected;
          widget.isSelected(isSelected);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 110,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    widget.menu.url,
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Container(
              padding: EdgeInsets.all(7),
              width: double.infinity,
              alignment: Alignment.bottomLeft,
              child: Text(
                widget.menu.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(6),
              width: double.infinity,
              alignment: Alignment.topRight,
              child: Text(
                widget.menu.price.toString(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
