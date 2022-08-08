import 'package:firebaseinsta/enums/enums.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.items,
    required this.onTap,
    required this.selectedItem,
  }) : super(key: key);

  final Map items;
  final ValueChanged<int> onTap;
  final BottomNavItem selectedItem;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: Colors.grey[500],
      selectedItemColor: Theme.of(context).primaryColor,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      onTap: onTap,
      currentIndex: BottomNavItem.values.indexOf(selectedItem),
      type: BottomNavigationBarType.fixed,
      items: [
        ...items
            .map((key, value) {
              return MapEntry(
                key.toString(),
                BottomNavigationBarItem(
                  icon: Icon(value),
                  label: key.toString(),
                ),
              );
            })
            .values
            .toList()
      ],
    );
  }
}
