import 'package:flutter/material.dart';

void popUpImage(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Selecionar foto"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Row(
                children: [
                  Icon(Icons.camera_alt_outlined),
                  Text("Camera"),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Row(
                children: [
                  Icon(Icons.image),
                  Text("Galeria"),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Row(
                children: [
                  Icon(Icons.delete),
                  Text("Remover"),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
