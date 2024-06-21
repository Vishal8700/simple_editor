import 'package:flutter/material.dart';
import 'package:editor/saveImage.dart';


class DisplayCroppedImage extends StatefulWidget {
  final Image croppedImage;
  final Function(Image) onSave;

  const DisplayCroppedImage({
    super.key,
    required this.croppedImage,
    required this.onSave,
  });

  @override
  _DisplayCroppedImageState createState() => _DisplayCroppedImageState();
}

class _DisplayCroppedImageState extends State<DisplayCroppedImage> {
  String? selectedFrame;
  final GlobalKey _globalKey = GlobalKey();

  final List<String> frameImages = [
    'assets/user_image_frame_1.png',
    'assets/user_image_frame_2.png',
    'assets/user_image_frame_3.png',
    'assets/user_image_frame_4.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Border'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                RepaintBoundary(
                  key: _globalKey,
                  child: widget.croppedImage,
                ),
                if (selectedFrame != null)
                  Image.asset(
                    selectedFrame!,
                    width: 500,
                    height: 500,
                    fit: BoxFit.cover,
                  ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Select a Frame:'),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: frameImages.map((frameImage) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFrame = frameImage;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(1.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color.fromARGB(255, 50, 50, 51), width: 2.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          frameImage,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (selectedFrame != null) {
                  Image selectedFrameImage = Image.asset(selectedFrame!);
                  widget.onSave(selectedFrameImage);
                }
              },
              child: const Text('Add frame'),
            ),
            ElevatedButton(
              onPressed: _saveImage,
              child: const Text('Save Image to Gallery'),
            ),
          ],
        ),
      ),
    );
  }



  Future<void> _saveImage() async {
    final savedFilePath = await saveImage(_globalKey);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Image saved to $savedFilePath'),
    ));
  }

  
}
