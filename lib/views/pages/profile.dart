import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _selectedImage;
  String _ocrResult = 'No receipt scanned yet\n\nPick an image to extract text';

  // Pick image and run OCR
  Future<void> _scanReceipt() async {
    final picker = ImagePicker();

    try {
      final XFile? imageFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85, // balance quality & size
      );

      if (imageFile == null) {
        setState(() {
          _ocrResult = 'No image selected';
        });
        return;
      }

      setState(() {
        _selectedImage = File(imageFile.path);
        _ocrResult = 'Processing...';
      });

      // Create InputImage from file
      final inputImage = InputImage.fromFilePath(imageFile.path);

      // Initialize recognizer (Latin script is default - good for English + numbers)
      final textRecognizer = TextRecognizer(
        script: TextRecognitionScript.latin,
      );

      // Process image
      final RecognizedText recognizedText = await textRecognizer.processImage(
        inputImage,
      );

      // Collect all extracted text
      StringBuffer extracted = StringBuffer();
      for (TextBlock block in recognizedText.blocks) {
        print(block.text);
        extracted.writeln(block.text);
        extracted.writeln('---'); // separator between blocks
      }

      setState(() {
        _ocrResult = extracted.toString().isEmpty
            ? 'No text found in image'
            : 'Extracted Text:\n\n${extracted.toString().trim()}';
      });

      // Clean up
      textRecognizer.close();
    } catch (e) {
      setState(() {
        _ocrResult = 'Error during OCR:\n$e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Receipt Scanner')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image preview
            if (_selectedImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.file(
                  _selectedImage!,
                  height: 280,
                  fit: BoxFit.contain,
                ),
              )
            else
              Container(
                height: 280,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Icon(Icons.receipt_long, size: 80, color: Colors.grey),
                ),
              ),

            const SizedBox(height: 24),

            // Result display
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Text(
                _ocrResult,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.4,
                  color: _ocrResult.contains('Error')
                      ? Colors.red
                      : Colors.black87,
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Scan button
            ElevatedButton.icon(
              onPressed: _scanReceipt,
              icon: const Icon(Icons.camera_alt),
              label: const Text('Scan Transfer Receipt'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
