import 'package:flutter/material.dart';

class NameAndColorPickerInput extends StatelessWidget {
  final TextEditingController nameController;
  final String nameLabelText;
  final Color selectedColor;
  final List<Color> availableColors;
  final ValueChanged<Color> onColorChanged;

  const NameAndColorPickerInput({
    Key? key,
    required this.nameController,
    required this.nameLabelText,
    required this.selectedColor,
    required this.availableColors,
    required this.onColorChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(23, 91, 111, 0.3),
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Input for name
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: nameLabelText,
                  prefixIcon:
                      Icon(Icons.person_outline), // Ajout du préfixe d'icône
                  border: OutlineInputBorder(
                    // Ajout de la bordure
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Colors.grey), // Couleur de la bordure
                  ),
                ),
              ),
              SizedBox(height: 10),
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
