import 'package:flutter/material.dart';

class SeccionInformativa extends StatelessWidget {
  final String title;
  final String content;
  final Color color;
  final VoidCallback onConfirm;

  const SeccionInformativa({
    Key? key,
    required this.title,
    required this.content,
    required this.color,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration( // Utilizar solo la propiedad decoration
              color: color,
              borderRadius: BorderRadius.circular(5),
            ),
            height: 200,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    content,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 3.5),
          SizedBox(
            height: 30,
            child: ElevatedButton(
              onPressed: onConfirm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amberAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                shadowColor: Colors.grey
              ),
              child: const Text(
                'LIMPIAR',
                style: TextStyle(fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
