import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image/image.dart' as image_lib;

import 'package:edit_snap/gen/assets.gen.dart';

class ImageEditScreen extends StatefulWidget {
  const ImageEditScreen({super.key, required this.imageBitmap});

  final Uint8List imageBitmap;

  @override
  State<ImageEditScreen> createState() => _ImageEditScreenState();
}

class _ImageEditScreenState extends State<ImageEditScreen> {
  late Uint8List _imageBitmap;

  @override
  void initState() {
    super.initState();
    _imageBitmap = widget.imageBitmap;
  }

  void _rotateImage() {
    final image = image_lib.decodeImage(_imageBitmap);
    if (image == null) return;
    final rotatedImage = image_lib.copyRotate(image, angle: 90);

    // 状態を更新
    setState(() {
      _imageBitmap = image_lib.encodeBmp(rotatedImage);
    });
  }

  void _flipImage() {
    final image = image_lib.decodeImage(_imageBitmap);
    if (image == null) return;
    final flippedImage = image_lib.flipHorizontal(image);

    // 状態を更新
    setState(() {
      _imageBitmap = image_lib.encodeBmp(flippedImage);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(l10n.imageEditScreenTitle)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.memory(_imageBitmap),
            IconButton(
              onPressed: () => _rotateImage(),
              icon: Assets.rotateIcon.svg(
                width: 24,
                height: 24,
              ),
            ),
            IconButton(
              onPressed: () => _flipImage(),
              icon: Assets.flipIcon.svg(
                width: 24,
                height: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
