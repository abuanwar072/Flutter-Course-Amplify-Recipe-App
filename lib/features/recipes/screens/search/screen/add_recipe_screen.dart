import 'package:amplify_recipe/features/common/data/recipe_repository.dart';
import 'package:amplify_recipe/main.dart';
import 'package:amplify_recipe/shared/constants/gaps.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

import '../../../../../shared/constants/constants.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  late final titleController = TextEditingController();
  late final descriptionController = TextEditingController();
  late final durationController = TextEditingController();
  late final serveController = TextEditingController();

  final recipeId = Uuid.v4().toString();
  final ingredients = <(String, String)>[];

  bool _isIngredientAddViewEnabled = false;
  String durationUnit = 'Minute';
  String category = 'Appetizer';
  String imagePath = '';

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    durationController.dispose();
    serveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Recipe'),
        actions: [
          IconButton(
            onPressed: () {
              final title = titleController.text.trim();
              final description = descriptionController.text.trim();
              final duration = durationController.text.trim();
              final serve = serveController.text.trim();
              if (title.isEmpty ||
                  description.isEmpty ||
                  duration.isEmpty ||
                  serve.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please fill all the fields'),
                  ),
                );
                return;
              }
              Navigator.of(context).pop();
              getIt.get<RecipeRepository>().addRecipe(
                    title,
                    description,
                    duration,
                    durationUnit,
                    category,
                    serve,
                    imagePath,
                    ingredients,
                  );
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(defaultPadding),
        children: [
          const Text('Recipe Title'),
          gapH8,
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              hintText: 'Enter recipe title',
            ),
          ),
          gapH16,
          const Text('Recipe Description'),
          gapH8,
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              hintText: 'Enter recipe description',
            ),
          ),
          gapH16,
          const Text('Duration for Cooking'),
          gapH8,
          TextField(
            controller: durationController,
            decoration: const InputDecoration(
              hintText: 'Enter duration for cooking',
            ),
            keyboardType: TextInputType.number,
          ),
          gapH16,
          const Text('Duration unit Cooking'),
          gapH8,
          DropdownButtonFormField(
            items: const <DropdownMenuItem>[
              DropdownMenuItem<String>(
                value: 'Minute',
                child: Text('Minute'),
              ),
              DropdownMenuItem<String>(
                value: 'Hour',
                child: Text('Hour'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                durationUnit = value as String;
              });
            },
            value: durationUnit,
          ),
          gapH16,
          const Text('Serves'),
          gapH8,
          TextField(
            controller: serveController,
            decoration: const InputDecoration(
              hintText: 'Enter the amount of serves',
            ),
            keyboardType: TextInputType.number,
          ),
          gapH16,
          const Text('Category'),
          gapH8,
          DropdownButtonFormField(
            items: const <DropdownMenuItem>[
              DropdownMenuItem<String>(
                value: 'Appetizer',
                child: Text('Appetizer'),
              ),
              DropdownMenuItem<String>(
                value: 'Dessert',
                child: Text('Dessert'),
              ),
              DropdownMenuItem<String>(
                value: 'Fish',
                child: Text('Fish'),
              ),
              DropdownMenuItem<String>(
                value: 'Main course',
                child: Text('Main course'),
              ),
              DropdownMenuItem<String>(
                value: 'Salad',
                child: Text('Salad'),
              ),
              DropdownMenuItem<String>(
                value: 'Soup',
                child: Text('Soup'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                category = value as String;
              });
            },
            value: category,
          ),
          gapH16,
          const Text('Ingredients'),
          gapH8,
          if (!_isIngredientAddViewEnabled) ...[
            Column(
              children: ingredients
                  .map((ingredient) => Row(
                        children: [
                          Expanded(
                            child: Text(ingredient.$1),
                          ),
                          Text(ingredient.$2),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                ingredients.remove(ingredient);
                              });
                            },
                            icon: const Icon(Icons.delete),
                          )
                        ],
                      ))
                  .toList(growable: false),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isIngredientAddViewEnabled = true;
                });
              },
              child: const Text(
                'Add Ingredient',
                style: TextStyle(color: Colors.white),
              ),
            )
          ] else
            _AddIngredientView(
              onIngredientSaved: (title, amount) {
                setState(() {
                  ingredients.add((title, amount));
                  _isIngredientAddViewEnabled = false;
                });
              },
              onCancelled: () {
                setState(() {
                  _isIngredientAddViewEnabled = false;
                });
              },
            ),
        ],
      ),
    );
  }
}

class _AddIngredientView extends StatefulWidget {
  const _AddIngredientView({
    required this.onIngredientSaved,
    required this.onCancelled,
  });

  final void Function(String, String) onIngredientSaved;
  final VoidCallback onCancelled;

  @override
  State<_AddIngredientView> createState() => _AddIngredientViewState();
}

class _AddIngredientViewState extends State<_AddIngredientView> {
  late final ingredientTitleController = TextEditingController();
  late final ingredientAmountController = TextEditingController();
  late final ingredientUnitController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: widget.onCancelled,
          child: const Row(
            children: [
              Expanded(child: Text('Cancel')),
              Icon(Icons.cancel),
            ],
          ),
        ),
        gapH16,
        TextField(
          controller: ingredientTitleController,
          decoration: const InputDecoration(
            hintText: 'Enter ingredient title',
          ),
        ),
        gapH16,
        TextField(
          controller: ingredientAmountController,
          decoration: const InputDecoration(
            hintText: 'Enter ingredient amount',
          ),
          keyboardType: TextInputType.number,
        ),
        gapH16,
        TextField(
          controller: ingredientUnitController,
          decoration: const InputDecoration(
            hintText: 'Enter ingredient unit',
          ),
        ),
        gapH16,
        ElevatedButton(
          onPressed: () {
            final title = ingredientTitleController.text.trim();
            final quantity = ingredientAmountController.text.trim();
            final unit = ingredientUnitController.text.trim();

            if (title.isEmpty ||
                quantity.trim().isEmpty ||
                unit.trim().isEmpty) {
              return;
            }

            widget.onIngredientSaved(
              title,
              '$quantity $unit',
            );
          },
          child: const Text(
            'Add Ingredient',
          ),
        ),
      ],
    );
  }
}
