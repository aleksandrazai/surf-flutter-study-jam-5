import 'package:flutter/material.dart';
import 'package:meme_generator/widgets/image_picker.dart';

class ImageOptions extends StatefulWidget {
  const ImageOptions({
    super.key,
    required this.imageLinkController,
    required this.imageGalleryController,
  });

  final TextEditingController imageLinkController;
  final ImageController imageGalleryController;

  @override
  State<ImageOptions> createState() => _ImageOptionsState();
}

class _ImageOptionsState extends State<ImageOptions> {
  @override
  void initState() {
    super.initState();
    widget.imageLinkController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: widget.imageLinkController,
          decoration: const InputDecoration(
              hintText: 'Ссылка на изображение', border: OutlineInputBorder()),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text('ИЛИ'),
        ),
        TextButton(
            onPressed: () async {
              await widget.imageGalleryController.getImageFromGallery();
              _updateImage();
            },
            child: const Text('Загрузить с устройства')),
        GestureDetector(
          onTap: () {},
          child: (widget.imageGalleryController.selectedImage != null)
              ? Stack(
                  children: [
                    Image.file(widget.imageGalleryController.selectedImage!),
                    Positioned.directional(
                        textDirection: TextDirection.ltr,
                        end: 0,
                        child: IconButton.filled(
                            onPressed: () {
                              widget.imageGalleryController.clearImage();
                              _updateImage();
                            },
                            icon: const Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                              weight: 10,
                            ))),
                  ],
                )
              : Container(),
        )
      ],
    );
  }

  void _updateImage() {
    setState(() {});
  }
}
