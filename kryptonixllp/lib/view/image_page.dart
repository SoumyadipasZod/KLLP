import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../controller/image_controller.dart';
import '../utils/app_style.dart';
import 'image_full_view_page.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ImageList extends StatefulWidget {
  const ImageList({super.key});

  @override
  State<ImageList> createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  late ScrollController _scrollController;
  int _currentPage = 1;
  TextEditingController _controller = TextEditingController(text: '');
  Timer? _debounce;
  int imagePerPage = 10;
  bool isFirstBuild = true;
  // bool isNavigating = false;

  void _onScroll() {
    // if (isNavigating) return; // Prevent scroll logic when navigating

    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        _currentPage += 1;
      });

      Provider.of<ImageListProvider>(context, listen: false).getImages(
          query: _controller.text,
          page: _currentPage,
          per_page: imagePerPage,
          isReset: false);
    }
  }

  search() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _currentPage = 1;
        Provider.of<ImageListProvider>(context, listen: false).getImages(
            query: _controller.text,
            page: _currentPage,
            per_page: imagePerPage,
            isReset: true);
      });
    });
  }

  // void _setImagePerPage() {
  //   double screenWidth = MediaQuery.of(context).size.width;

  //   if (kIsWeb) {
  //     // For web, adjust the number of images per page based on screen size
  //     if (screenWidth > 1200) {
  //       imagePerPage = 30; // Large screen, show more images per page
  //     } else if (screenWidth > 800) {
  //       imagePerPage = 20; // Medium screen, show a moderate number of images
  //     } else {
  //       imagePerPage = 15; // Smaller web screen size
  //     }
  //   } else {
  //     // For mobile, use default imagePerPage = 10
  //     imagePerPage = 10;
  //   }
  // }

  // getImages() async {
  //   // Define the API URL and parameters
  //   var url = Uri.https(
  //       'api.unsplash.com', 'photos');
  //   log("url : ${url}");
  //   var response = await http.get(
  //     url,
  //     headers: {
  //       'Authorization':
  //           'Client-ID eUjykK1eXhjDmfHCDZIfBT4_p2lyIZPymYXdLM8Qdcg',
  //       'Content-Type': 'application/json',
  //     },
  //   );

  //   // Log the response status and body
  //   print('Response status: ${response.statusCode}');
  //   print('Response body: ${response.body}');
  // }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    Provider.of<ImageListProvider>(context, listen: false).getImages(
        query: _controller.text,
        page: _currentPage,
        per_page: imagePerPage,
        isReset: true);
  }

  @override
  void dispose() {
    // Clean up the scroll controller and debounce when disposing
    _scrollController
        .removeListener(_onScroll); // Remove listener to avoid issues
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   if (isFirstBuild) {
  //     _setImagePerPage(); // Moved the image per page calculation to didChangeDependencies
  //     Provider.of<ImageListProvider>(context, listen: false).getImages(
  //         query: _controller.text,
  //         page: _currentPage,
  //         per_page: imagePerPage,
  //         isReset: true);
  //     isFirstBuild = false;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kryptonix LLP"),
      ),
      body: Provider.of<ImageListProvider>(context).imagesData.isEmpty
          ? const Center(child: Text('No Data Found'))
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10),
                  child: Center(
                    child: Container(
                      decoration: commoCardBoxDecoration,
                      child: TextField(
                        controller: _controller,
                        onChanged: (value) {
                          search();
                        },
                        decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Color(0XFF4880FF),
                            ),
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  _controller.clear();
                                  // if (_currentPage != 1) {
                                  _currentPage = 1;
                                  Provider.of<ImageListProvider>(context,
                                          listen: false)
                                      .getImages(
                                          query: _controller.text,
                                          page: _currentPage,
                                          per_page: imagePerPage,
                                          isReset: true);
                                  setState(() {});
                                  // }
                                },
                                child: const Icon(
                                  Icons.close,
                                  color: Color(0XFF4880FF),
                                )),

                            // suffixIcon: Icon(Icons.filter_list),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 10.0)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          double screenWidth =
                              MediaQuery.of(context).size.width;

                          // Set number of columns based on screen width
                          int columns;
                          if (screenWidth > 600) {
                            // Screen width larger than typical phone size
                            columns = (constraints.maxWidth / 200)
                                .floor(); // Larger grid items for larger screens
                          } else {
                            columns =
                                2; // Default to 2 columns for phone screens
                          }
                          return MasonryGridView.builder(
                            controller: _scrollController,
                            gridDelegate:
                                SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: columns, // Number of columns
                            ),
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            itemCount: Provider.of<ImageListProvider>(context)
                                .imagesData
                                .length,
                            itemBuilder: (context, index) {
                              var imageData =
                                  Provider.of<ImageListProvider>(context)
                                      .imagesData;
                              return GestureDetector(
                                onTap: () {
                                  log("Clicking on images");
                                  FocusManager.instance.primaryFocus?.unfocus();

                                  _scrollController.removeListener(_onScroll);

                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return ImageFullViewPage(
                                        key: ValueKey(index),
                                        tag: 'imageHero$index',
                                        urls: imageData[index].urls!,
                                        likes:
                                            imageData[index].likes!.toString(),
                                        user: imageData[index].user!,
                                        links: imageData[index].links!,
                                      );
                                    },
                                  )).then((_) {
                                    _scrollController.addListener(_onScroll);
                                  });
                                },
                                child: Hero(
                                  tag: 'imageHero$index',
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      imageData[index].urls!.regular.toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      )),
                ),
              ],
            ),
    );
  }
}
