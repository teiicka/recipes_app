import 'package:flutter/material.dart';
import '../services/meal_api.dart';
import '../widgets/meal_grid_item.dart';
import 'meal_detail_screen.dart';

class MealsScreen extends StatefulWidget {
  final String category;

  const MealsScreen({Key? key, required this.category}) : super(key: key); // const

  @override
  _MealsScreenState createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  List meals = [];
  String search = "";

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    meals = await MealAPI.getMealsByCategory(widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final filtered = meals
        .where((m) => m.name.toLowerCase().contains(search.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              onChanged: (value) => setState(() => search = value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search meals",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: filtered
                  .map((m) => MealGridItem(
                        meal: m,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MealDetailScreen(mealId: m.id),
                            ),
                          );
                        },
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
