

import 'package:beh_doctor/models/AppoinmentDetailModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../apiconstant/apiconstant.dart';

/// ================= GRID VIEW =================

class PrescriptionGridView extends StatelessWidget {
  final List<Prescription> prescriptions;

  const PrescriptionGridView({
    super.key,
    required this.prescriptions,
  });

  @override
  Widget build(BuildContext context) {
    if (prescriptions.isEmpty) {
      return Center(child: Text("no_prescriptions_found".tr));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      itemCount: prescriptions.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // ✅ ALWAYS 2 CARDS PER ROW
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, index) {
        return PrescriptionTileWidget(
          prescription: prescriptions[index],
        );
      },
    );
  }
}

/// ================= CARD =================

class PrescriptionTileWidget extends StatelessWidget {
  final Prescription prescription;

  const PrescriptionTileWidget({
    super.key,
    required this.prescription,
  });

  bool isPdf(String url) => url.toLowerCase().endsWith('.pdf');

  bool isImage(String url) =>
      url.toLowerCase().endsWith('.png') ||
      url.toLowerCase().endsWith('.jpg') ||
      url.toLowerCase().endsWith('.jpeg') ||
      url.toLowerCase().endsWith('.webp');

  String formatDate(String? date) {
    if (date == null || date.isEmpty) return '';
    try {
      return DateFormat('dd MMM yyyy')
          .format(DateTime.parse(date).toLocal());
    } catch (_) {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String? fileUrl = prescription.file == null ||
            prescription.file!.trim().isEmpty
        ? null
        : prescription.file!.startsWith('http')
            ? prescription.file
            : ApiConstants.imageBaseUrl + prescription.file!;

    final bool pdf = fileUrl != null && isPdf(fileUrl);
    final bool image = fileUrl != null && isImage(fileUrl);

    return Card(
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// ---------- IMAGE / PDF ----------
          InkWell(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(14),
            ),
            onTap: fileUrl == null
                ? null
                : () {
                    if (pdf) {
                      Get.to(() => PdfViewerScreen(url: fileUrl));
                    } else if (image) {
                      Get.to(() => FullscreenImageViewer(imageUrl: fileUrl));
                    }
                  },
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(14),
              ),
              child: Container(
                height: 160,
                width: double.infinity,
                color: Colors.grey.shade100,
                child: fileUrl == null
                    ? const Icon(Icons.image_not_supported, size: 40)
                    : pdf
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.picture_as_pdf,
                                  size: 46, color: Colors.red),
                              SizedBox(height: 6),
                              Text("Open PDF"),
                            ],
                          )
                        : Image.network(
                            fileUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.broken_image, size: 40),
                          ),
              ),
            ),
          ),

          /// ---------- TITLE + DATE ----------
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  prescription.title ?? "no_title".tr,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  formatDate(prescription.createdAt),
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= IMAGE VIEWER =================

class FullscreenImageViewer extends StatelessWidget {
  final String imageUrl;

  const FullscreenImageViewer({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: InteractiveViewer(
          constrained: true,
          minScale: 1,
          maxScale: 4,
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ),
    );
  }
}

/// ================= PDF VIEWER =================

class PdfViewerScreen extends StatelessWidget {
  final String url;

  const PdfViewerScreen({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Prescription PDF")),
      body: SfPdfViewer.network(url),
    );
  }
}
