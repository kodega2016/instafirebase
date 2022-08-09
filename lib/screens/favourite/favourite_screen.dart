import 'package:flutter/material.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(
                child: Text('I am here:)'),
              ),
            ),
          ),
        );
      }),
      body: const Center(
        child: Text('Favourite'),
      ),
    );
  }
}
