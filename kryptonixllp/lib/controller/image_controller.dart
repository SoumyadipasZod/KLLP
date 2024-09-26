import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../configure/injection.config.dart';
import '../model/image_model.dart';
import '../repository/image_repo.dart';
import '../utils/dispose_safe_notifier.dart';
import '../utils/utils.dart';



class ImageListProvider extends DisposeSafeChangeNotifier{
  // final imageRepo = ImageRepo();
  ImageRepo? _imageRepoImpl = getIt<ImageRepo>();
  // List<UserModel> userData = [];
  List<ImageModel> imagesData = [];
  Future<void> getImages({
    required bool isReset,
    required String query,
    required int page ,
    required int per_page
    }) async{
    EasyLoading.show(
        status: "Loading", indicator: const CircularProgressIndicator());
    try {
      await _imageRepoImpl!.getImages(
      q: query,
      page: page,
      per_page: per_page
      ).then((value){
        log("Value.data : ${value.data}");
        log("page : $page");
        log("per_page : ${per_page}");
        // imagesData = value.data as List<ImageModel>;
        if(value.data != null){
          if (isReset == true) {
              imagesData.clear();
            }
          imagesData.addAll(value.data);
          notifyListeners();
        }else{
            log("No data");
          imagesData = [];
          notifyListeners();
        }
        
        // print(imagesData.length);
        // if (imagesData != null) {
        //   if (imagesData!.isNotEmpty) {
        //     if (isReset == true) {
        //       imagesData.clear();
        //     }
        //     imagesData = value.data as List<ImageModel>;
        //     log("imageslength : ${imagesData.length}");
        //     notifyListeners();
        //   }
        // }else{
        //   log("No data");
        //   imagesData = [];
        //   notifyListeners();
        // }

        notifyListeners();
        EasyLoading.dismiss();

    });
    } catch (e) {
      log("No data");
      EasyLoading.dismiss();
    }
    
  }
}