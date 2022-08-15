import 'package:flutter/material.dart';

class PElevatedButton extends StatelessWidget {
  const PElevatedButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.isBusy = false,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String label;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isBusy)
              const Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
              ),
            Text(label),
          ],
        ),
      ),
    );
  }
}
