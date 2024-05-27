import 'dart:io';

import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';
import 'package:aws_s3_upload/enum/acl.dart';
import 'package:aws_s3_upload/src/utils.dart';
import 'package:basqary/domain/s3/amazon_policy.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:recase/recase.dart';

class AmazonS3 {

  static Future<String?> uploadFile({

    required String accessKey,
    required String secretKey,
    required String bucket,

    required File file,
    String? key,
    String destDir = '',
    String region = 'us-east-1',
    ACL acl = ACL.public_read,
    String? filename,
    String contentType = 'binary/octet-stream',
    Map<String, String>? metadata,
  }) async {
    final endpoint = 'https://$bucket.object.pscloud.io';

    var uploadKey;

    if (key != null) {
      uploadKey = key;
    } else if (destDir.isNotEmpty) {
      uploadKey = '$destDir/${filename ?? path.basename(file.path)}';
    } else {
      uploadKey = '${filename ?? path.basename(file.path)}';
    }

    final stream = http.ByteStream(Stream.castFrom(file.openRead()));
    final length = await file.length();

    final uri = Uri.parse(endpoint);
    final req = http.MultipartRequest("POST", uri);
    final multipartFile = http.MultipartFile('file', stream, length,
        filename: path.basename(file.path));

    // Convert metadata to AWS-compliant params before generating the policy.
    final metadataParams = _convertMetadataToParams(metadata);

    // Generate pre-signed policy.
    final policy = Policy.fromS3PresignedPost(
      uploadKey,
      bucket,
      accessKey,
      15,
      length,
      acl,
      region: region,
      metadata: metadataParams,
    );

    final signingKey =
    SigV4.calculateSigningKey(secretKey, policy.datetime, region, 's3');
    final signature = SigV4.calculateSignature(signingKey, policy.encode());

    req.files.add(multipartFile);
    req.fields['key'] = policy.key;
    req.fields['acl'] = aclToString(acl);
    req.fields['X-Amz-Credential'] = policy.credential;
    req.fields['X-Amz-Algorithm'] = 'AWS4-HMAC-SHA256';
    req.fields['X-Amz-Date'] = policy.datetime;
    req.fields['Policy'] = policy.encode();
    req.fields['X-Amz-Signature'] = signature;
    req.fields['Content-Type'] = contentType;

    // If metadata isn't null, add metadata params to the request.
    if (metadata != null) {
      req.fields.addAll(metadataParams);
    }

    try {
      final res = await req.send();

      if (res.statusCode == 204) return '$endpoint/$uploadKey';
    } catch (e) {
      print('Failed to upload to AWS, with exception:');
      print(e);
      return null;
    }
  }

  static Map<String, String> _convertMetadataToParams(
      Map<String, String>? metadata) {
    Map<String, String> updatedMetadata = {};

    if (metadata != null) {
      for (var k in metadata.keys) {
        updatedMetadata['x-amz-meta-${k.paramCase}'] = metadata[k]!;
      }
    }

    return updatedMetadata;
  }
}
