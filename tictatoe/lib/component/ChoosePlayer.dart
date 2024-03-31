import 'package:flutter/material.dart';

class NameAndColorPickerInput extends StatelessWidget {
  final TextEditingController nameController;
  final String nameLabelText;
  final Color selectedColor;
  final List<Color> availableColors;
  final ValueChanged<Color> onColorChanged;

  const NameAndColorPickerInput({
    super.key,
    required this.nameController,
    required this.nameLabelText,
    required this.selectedColor,
    required this.availableColors,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Input for name
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: nameLabelText,
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  filled: true, // Activez le remplissage du champ de texte
                  fillColor: Theme.of(context)
                      .primaryColor, // Utilisez la couleur primaire du thème
                ),
              ),

              const SizedBox(height: 10),
              // Color picker
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: availableColors.map((color) {
                    return GestureDetector(
                      onTap: () {
                        onColorChanged(color);
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: selectedColor == color
                                ? Colors.white
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ));
  }
}
