import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meme_generator/widgets/custom_textfield.dart';
import 'package:meme_generator/widgets/custom_dialog.dart';
import 'package:meme_generator/widgets/image_options.dart';
import 'package:meme_generator/widgets/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class MemeGeneratorScreen extends StatefulWidget {
  const MemeGeneratorScreen({Key? key}) : super(key: key);

  @override
  State<MemeGeneratorScreen> createState() => _MemeGeneratorScreenState();
}

class _MemeGeneratorScreenState extends State<MemeGeneratorScreen> {
  TextEditingController imageLinkController = TextEditingController();
  TextEditingController headerEditingController = TextEditingController();
  TextEditingController bodyEditingController = TextEditingController();

  final ImageController imageGalleryController = ImageController();
  static GlobalKey imageKey = GlobalKey();
  String imageUrl = '';
  File? imageGallery;
  String headerText = '';
  String bodyText = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    imageLinkController.dispose();
    headerEditingController.dispose();
    bodyEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      border: Border.all(
        color: Colors.white,
        width: 2,
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
          title: const Text('Демотиватор онлайн',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black,
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  _shareImage();
                },
                icon: const Icon(Icons.share, color: Colors.white)),
          ]),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: RepaintBoundary(
            key: imageKey,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: ColoredBox(
                color: Colors.black,
                child: DecoratedBox(
                  decoration: decoration,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 20,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          child: DecoratedBox(
                            decoration: decoration,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: GestureDetector(
                                onTap: () {
                                  CustomDialog.showCustomDialog(
                                      context: context,
                                      content: ImageOptions(
                                        imageLinkController:
                                            imageLinkController,
                                        imageGalleryController:
                                            imageGalleryController,
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              _loadImage();
                                            },
                                            child: const Text('Загрузить'))
                                      ]);
                                },
                                //Проверяем, что можно отобразить на месте картинки
                                child: (imageUrl.isNotEmpty)
                                    ? Image.network(
                                        imageUrl,
                                        fit: BoxFit.contain,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const SizedBox(
                                            child: Text(
                                              'Не удалось загрузить изображение :(',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: 'Impact',
                                                fontSize: 20,
                                                color: Colors.pinkAccent,
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : (imageGallery != null)
                                        ? Image.file(imageGallery!)
                                        : Container(
                                            height: 200,
                                            width: 200,
                                            color: Colors.white,
                                            child: const Center(
                                                child:
                                                    Text('Загрузить картинку')),
                                          ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.black54,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomTextField(
                                textEditingController: headerEditingController,
                                fontSize: 40,
                                hintText: 'Заголовок',
                              ),
                              CustomTextField(
                                textEditingController: bodyEditingController,
                                fontSize: 18,
                                hintText: 'Текст',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _loadImage() {
    setState(() {
      imageUrl = imageLinkController.text;
      imageGallery = imageGalleryController.selectedImage;
    });
    Navigator.of(context).pop();
  }

  Future<void> _shareImage() async {
    RenderRepaintBoundary? boundary =
        imageKey.currentContext!.findRenderObject() as RenderRepaintBoundary?;
    if (boundary != null) {
      ui.Image image = await boundary.toImage();
      final directory = (await getApplicationDocumentsDirectory()).path;
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      File imgFile = File('$directory/meme.png');
      imgFile.writeAsBytes(pngBytes);
      Share.shareXFiles([XFile(imgFile.path)]);
    }
  }
}
