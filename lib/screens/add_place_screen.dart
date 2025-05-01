import 'dart:io';

import 'package:favourite_places_flutter/models/place.dart';
import 'package:favourite_places_flutter/providers/user_places.dart';
import 'package:favourite_places_flutter/widgets/image_input.dart';
import 'package:favourite_places_flutter/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
  }

  void _savePlace() {
    final enteredTitle = _titleController.text;
    if (enteredTitle.isEmpty ||
        _selectedImage == null ||
        _selectedLocation == null) {
      return;
    }
    print("Saving place...");
    ref
        .read(userPlacesProvider.notifier)
        .addPlace(enteredTitle, _selectedImage!, _selectedLocation!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a New Place"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Title"),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            ImageInput(
              onPickImage: (image) {
                _selectedImage = image;
              },
            ),
            const SizedBox(
              height: 8,
            ),
            LocationInput(
              onSelectLocation: (location) {
                _selectedLocation = location;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton.icon(
              onPressed: _savePlace,
              icon: const Icon(Icons.add_location),
              label: const Text("Add Place"),
            ),
          ],
        ),
      ),
    );
  }
}
