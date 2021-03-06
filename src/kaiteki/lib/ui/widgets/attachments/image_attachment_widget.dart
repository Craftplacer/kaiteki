import 'package:flutter/material.dart';
import 'package:kaiteki/fediverse/model/attachment.dart';
import 'package:mdi/mdi.dart';

class ImageAttachmentWidget extends StatelessWidget {
  final Attachment attachment;

  const ImageAttachmentWidget(this.attachment);

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.circular(8);

    return GestureDetector(
      onTap: () => enlargeImage(context),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Image.network(
          attachment.previewUrl, // ?? attachment.url
          loadingBuilder: (_, w, c) {
            if (c == null) {
              return w;
            }

            var hasValue = c.expectedTotalBytes != null;

            return Center(
              child: CircularProgressIndicator(
                value: hasValue
                    ? (c.cumulativeBytesLoaded / c.expectedTotalBytes!)
                    : null,
              ),
            );
          },
          errorBuilder: (_, w, c) {
            return const Center(child: Icon(Mdi.alert));
          },
          //width: 100,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.medium,
          isAntiAlias: true,
        ),
      ),
    );
  }

  void enlargeImage(BuildContext context) {
    var background = Colors.black.withOpacity(0.5);

    showDialog(
      context: context,
      builder: (_) {
        return Scaffold(
          backgroundColor: background,
          appBar: AppBar(
            backgroundColor: Colors.black.withOpacity(0.5),
          ),
          body: InteractiveViewer(
            child: Center(
              child: Image.network(
                attachment.url,
                fit: BoxFit.fill,
                semanticLabel: attachment.description,
              ),
            ),
          ),
        );
      },
    );
  }
}
