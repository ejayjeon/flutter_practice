import 'package:cached_network_image/cached_network_image.dart';
import 'package:cookbook/app/const/app_layout.dart';
import 'package:flutter/material.dart';

// Fade in images with a placeholder
class LoadingImageView extends StatelessWidget {
  const LoadingImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppLayout(
      appTitle: 'LoadingImage View',
      body: LoadingImage(),
    );
  }
}

class LoadingImage extends StatefulWidget {
  const LoadingImage({super.key});

  @override
  State<LoadingImage> createState() => _LoadingImageState();
}

class _LoadingImageState extends State<LoadingImage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: double.infinity,
      child: Center(
        child: CachedNetworkImage(
          imageUrl: 'https://picsum.photos/250?image=13',
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                // fit: BoxFit.cover,
                colorFilter: const ColorFilter.mode(
                  Colors.grey,
                  BlendMode.color,
                ),
              ),
            ),
          ),
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
