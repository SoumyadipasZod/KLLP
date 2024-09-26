import 'dart:developer';

import 'package:flutter/material.dart';

import '../model/image_model.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';

class ImageFullViewPage extends StatefulWidget {
  final String likes;
  final ImageModelLinks links;
  final Urls urls;
  final User user;
  final String tag; // Pass the hero tag

  const ImageFullViewPage({super.key, required this.tag, required this.likes, required this.urls, required this.user, required this.links});

  @override
  State<ImageFullViewPage> createState() => _ImageFullViewPageState();
}

class _ImageFullViewPageState extends State<ImageFullViewPage> {

  download() async {
  await FileDownloader.downloadFile(
    notificationType: NotificationType.all,
    url: "${widget.links.download}",
    name: "cryptonix_${DateTime.now()}", //(optional)
    // onProgress: (String fileName, double progress) {
    //   print('FILE fileName HAS PROGRESS $progress');
    // },
    onDownloadCompleted: (String path) {
      // Show SnackBar on download complete
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Download completed! File saved at: $path'),
          duration: Duration(seconds: 3),
        ),
      );
    },
    onDownloadError: (String error) {
      print('DOWNLOAD ERROR: $error');
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fullscreen background
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context); // Return to previous screen on tap
            },
            onLongPress: () async{
              log("Download");
              await download();
            },
            child: Center(
              child: Hero(
                tag: widget.tag, // Use the same hero tag
                child: Image.network(
                  widget.urls.full.toString(),
                  fit: BoxFit.fitHeight,
                  width: double.infinity, // Full width
                  height: double.infinity, // Full height
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),

          // Positioned widget to show like and comment counts
          Positioned(
            bottom: 20, // Adjust based on your preference
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Like count
                Row(
                  children: [
                    const Icon(Icons.favorite, color: Colors.red), // Like icon
                    const SizedBox(width: 5),
                    Text(
                      '${widget.likes}', // Replace with actual like count
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),

                // Comment count
                Row(
                  children: [
                    const Icon(Icons.person, color: Colors.white), // Comment icon
                    const SizedBox(width: 5),
                    Text(
                      '${widget.user.name}', // Replace with actual comment count
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
