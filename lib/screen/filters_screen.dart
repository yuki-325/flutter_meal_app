import 'package:flutter/material.dart';
import 'package:meals_app/widget/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = "/filters";
  final Function(Map<String, bool>) saveFilters;
  final Map<String, bool> currentFilters;

  const FiltersScreen({
    Key? key,
    required this.saveFilters,
    required this.currentFilters,
  }) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegatorian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters["gluten"] as bool;
    _lactoseFree = widget.currentFilters["lactose"] as bool;
    _vegan = widget.currentFilters["vegan"] as bool;
    _vegatorian = widget.currentFilters["vegetarian"] as bool;

    super.initState();
  }

  Widget _buildSwitchList({
    required String title,
    required String description,
    required bool currentValue,
    required Function(bool) updateValue,
  }) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(description),
      value: currentValue,
      onChanged: updateValue,
      activeColor: Theme.of(context).colorScheme.secondary,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Filters"),
          actions: [
            IconButton(
              onPressed: () {
                final selectedFilter = {
                  "gluten": _glutenFree,
                  "lactose": _lactoseFree,
                  "vegan": _vegan,
                  "vegetarian": _vegatorian,
                };
                widget.saveFilters(selectedFilter);
              },
              icon: Icon(Icons.save),
            )
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                "Adjust your meal selection.",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildSwitchList(
                    title: "Gluten-free",
                    description: "Only include gluten-free meals.",
                    currentValue: _glutenFree,
                    updateValue: (newValue) {
                      setState(() {
                        _glutenFree = newValue;
                      });
                    },
                  ),
                  _buildSwitchList(
                    title: "Vegatorian",
                    description: "Only include vegatorian meals.",
                    currentValue: _vegatorian,
                    updateValue: (newValue) {
                      setState(() {
                        _vegatorian = newValue;
                      });
                    },
                  ),
                  _buildSwitchList(
                    title: "Vegan",
                    description: "Only include vegan meals.",
                    currentValue: _vegan,
                    updateValue: (newValue) {
                      setState(() {
                        _vegan = newValue;
                      });
                    },
                  ),
                  _buildSwitchList(
                    title: "Lactose-Free",
                    description: "Only include Lactose-Free meals.",
                    currentValue: _lactoseFree,
                    updateValue: (newValue) {
                      setState(() {
                        _lactoseFree = newValue;
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
