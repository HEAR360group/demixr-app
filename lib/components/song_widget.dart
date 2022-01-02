import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:demixr_app/constants.dart';
import 'package:demixr_app/models/failure/failure.dart';
import 'package:demixr_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'extended_widgets.dart';

class SongInfos extends StatelessWidget {
  final String title;
  final List<String> artists;
  final double size;
  final bool alignCenter;

  const SongInfos(
      {Key? key,
      required this.title,
      required this.artists,
      this.size = 16,
      this.alignCenter = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpacedColumn(
      spacing: 5,
      crossAxisAlignment:
          alignCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: size,
              color: ColorPalette.onSurface,
              fontWeight: FontWeight.w600),
        ),
        Text(
          artists.join(', '),
          style: TextStyle(
              fontSize: size - 2,
              color: ColorPalette.onSurface,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}

class SongWidget extends StatelessWidget {
  final String title;
  final List<String> artists;
  final Either<Failure, Uint8List> cover;
  final VoidCallback? onRemovePressed;

  const SongWidget({
    Key? key,
    required this.title,
    required this.artists,
    required this.cover,
    this.onRemovePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final coverImage = cover.fold(
      (failure) => Image.asset(
        getAssetPath('default_cover', AssetType.image),
        fit: BoxFit.contain,
        width: 65,
        height: 65,
      ),
      (cover) => Image.memory(
        cover,
        fit: BoxFit.cover,
        width: 65,
        height: 65,
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SpacedRow(
          spacing: 15,
          children: [
            coverImage,
            SongInfos(title: title, artists: artists),
          ],
        ),
        PopupMenuButton(
          padding: const EdgeInsets.all(0),
          color: ColorPalette.surfaceVariant,
          icon: SvgPicture.asset(
            getAssetPath('dots', AssetType.icon),
          ),
          itemBuilder: (context) => [
            PopupMenuItem(
              child: SpacedRow(
                spacing: 5,
                children: const [
                  Icon(
                    Icons.delete,
                    color: ColorPalette.onSurfaceVariant,
                  ),
                  Text("Remove"),
                ],
              ),
              onTap: onRemovePressed,
            ),
          ],
        ),
      ],
    );
  }
}