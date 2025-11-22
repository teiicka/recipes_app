import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/meal_api.dart';

class MealDetailScreen extends StatefulWidget {
  final String mealId;

  const MealDetailScreen({super.key, required this.mealId});

  @override
  _MealDetailScreenState createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  dynamic meal;

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    meal = await MealAPI.getMealDetails(widget.mealId);
    setState(() {});
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (meal == null) return Scaffold(body: Center(child: CircularProgressIndicator()));

    return Scaffold(
      appBar: AppBar(title: Text(meal.name)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(meal.thumb),
            SizedBox(height: 16),
            Text("Ingredients", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ...meal.ingredients.map((i) => Text("• $i")),
            SizedBox(height: 16),
            Text("Instructions", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(meal.instructions),
            SizedBox(height: 16),
            if (meal.youtube.isNotEmpty)
              ElevatedButton(
                onPressed: () => _launchUrl(meal.youtube),
                child: Text("Watch on YouTube"),
              ),
          ],
        ),
      ),
    );
  }
}
