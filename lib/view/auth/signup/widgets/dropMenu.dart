import 'package:flutter/material.dart';

class DropMenu extends StatelessWidget {
  final List<String> dropDownList;
  final String? initialValue;
  final Function(String?) onChanged;
  final double? height;
  final double? width;

  const DropMenu({
    Key? key,
    required this.dropDownList,
    this.initialValue,
    required this.onChanged,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50,
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade400, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        
        child: DropdownButton<String>(
          
          value: initialValue,
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.black,
            size: 28,
          ),
          elevation: 16,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          onChanged: (String? value) {
            onChanged(value); // Pass the selected value to the parent widget.
          },
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(10),
          items: dropDownList.map<DropdownMenuItem<String>>((String value) {
            
            return DropdownMenuItem<String>(
              
              value: value,
              child: Text(
                value,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
