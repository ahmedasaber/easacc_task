import 'package:flutter/material.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({
    super.key, required this.onPressed,
  });
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(12),
            )
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Scan Devices'),
            SizedBox(width: 4,),
            Icon(Icons.help)
          ],
        )
    );
  }
}
