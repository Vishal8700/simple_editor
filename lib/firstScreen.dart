import 'dart:io';
import 'package:flutter/material.dart';
import 'package:editor/homeScreen.dart'; 
import 'package:editor/imagepicker.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  File? _selectedImage;
  final ImagePickerService _imagePickerService = ImagePickerService();

  Future<void> _pickImage() async {
    final pickedFile = await _imagePickerService.pickImage();
    if (pickedFile != null) {
      setState(() {
        _selectedImage = pickedFile;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(
            title: 'Crop Image',
            imageFile: pickedFile,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Editor'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Select Image',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _pickImage,
              child: DottedBorderBox(
                child: _selectedImage == null
                    ? const Icon(
                        Icons.add_a_photo,
                        size: 100,
                        color: Colors.grey,
                      )
                    : Image.file(
                        _selectedImage!,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Pick Image'),
            ),
          ],
        ),
      ),
    );
  }
}

class DottedBorderBox extends StatelessWidget {
  final Widget child;

  const DottedBorderBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: child,
      ),
    );
  }
}
