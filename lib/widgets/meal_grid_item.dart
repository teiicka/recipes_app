import 'package:flutter/material.dart';
import '../models/meal.dart';

class MealGridItem extends StatelessWidget {
  final Meal meal;
  final VoidCallback onTap;

  const MealGridItem({Key? key, required this.meal, required this.onTap})
      : super(key: key); // const constructor

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GridTile(
        child: Image.network(meal.thumb, fit: BoxFit.cover),
        footer: Container(
          color: Colors.black54,
          padding: const EdgeInsets.all(4),
          child: Text(
            meal.name,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
