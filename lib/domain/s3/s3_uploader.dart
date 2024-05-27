import 'dart:io';

import 'package:basqary/domain/s3/amazon_s3.dart';

class S3Uploader {

  final String _bucket = "category";
  final String _accessKey = "URX3ZKK7N6GTOWYQ4K7D";
  final String _secretKey = "YDxmFSpI2TtChhGzkCBNHBJVn7zunz5Zd0AO8aDi";
  final String _url = "https://category.object.pscloud.io";

  Future<String> uploadFileToS3(File file) async {
    try {
      var key = _generateKey(file);
      await AmazonS3.uploadFile(
          accessKey: _accessKey,
          secretKey: _secretKey,
          bucket: _bucket,
          file: file,
          key: key
      );
      return "$_url/$key";
    } catch(error) {
      throw Exception("Upload error");
    }
  }

  String _getFileType(
      File file
  ) => file.path.substring(file.path.lastIndexOf(".") + 1);

  String _generateKey(
      File file
  ) => "${
      DateTime.now().millisecondsSinceEpoch
  }.${_getFileType(file)}";
}