

import 'dart:developer';

import '../../../Configure/injection.config.dart';
import '../../../Configure/status.dart';
import '../../configure/resource.dart';
import '../../utils/utils.dart';
import '../api_client/image_api_client.dart';
import 'image_repo.dart';

class ImageRepoImpl extends ImageRepo{
  ImageApiClient? _imageApiClient = getIt<ImageApiClient>();
  
  @override
  Future<Resource> getImages({
        String? q,
        String? image_type,
        int? page,
        int? per_page
      }) async{
    log('Images called');
    Resource data = await _imageApiClient!.getImages(
      q: q,
      image_type: image_type,
      page: page,
      per_page: per_page
      );
    if (data.status == STATUS.SUCCESS) {
      log('Succeed');
    } else {
      log('Failed');
    }
    return data;
  }
  
}