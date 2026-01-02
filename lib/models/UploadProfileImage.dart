class UploadProfileImageResponse {
  String? status;
  String? message;
  UploadInfo? uploadInfo;

  UploadProfileImageResponse({
    this.status,
    this.message,
    this.uploadInfo,
  });

  UploadProfileImageResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    uploadInfo = json['uploadInfo'] != null
        ? UploadInfo.fromJson(json['uploadInfo'])
        : null;
  }
}

class UploadInfo {
  String? location;

  UploadInfo({this.location});

  UploadInfo.fromJson(Map<String, dynamic> json) {
    location = json['Location']; // ⚠️ capital L
  }
}
