// import 'dart:developer';
// import 'package:beh_doctor/apiconstant/apiconstant.dart';
// import 'package:beh_doctor/views/CallsOptionBottomSheet.dart';
// import 'package:flutter/material.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';

// import 'package:beh_doctor/modules/auth/controller/AgoraCallController.dart';

// class AgoraDoctorCallScreen extends StatefulWidget {
//   final String channelId;
//   final String token;

//   const AgoraDoctorCallScreen({
//     Key? key,
//     required this.channelId,
//     required this.token,
//   }) : super(key: key);

//   @override
//   State<AgoraDoctorCallScreen> createState() => _AgoraDoctorCallScreenState();
// }

// class _AgoraDoctorCallScreenState extends State<AgoraDoctorCallScreen> {
//   final AgoraCallController controller = Get.put(AgoraCallController());

//   @override
//   void initState() {
//     super.initState();
//     _prepareAndJoin();
//   }

//   Future<void> _prepareAndJoin() async {
//     await [Permission.camera, Permission.microphone].request();

//     if (controller.isJoined.value == true) return;

//     try {
//       await controller.joinCall(
//         channelId: widget.channelId,
//         token: widget.token,
//       );
//     } catch (e) {
//       log('❌ joinCall failed: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Obx(() {
//         final isJoined = controller.isJoined.value;
//         final engine = controller.engine;
//         final remoteUid = controller.remoteUid.value;
//         final isRemoteJoined = controller.isRemoteUserJoined.value;

//         if (!isJoined || engine == null) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         return SafeArea(
//           child: Stack(
//             children: [
//               /// REMOTE VIDEO (BACKGROUND)
//               Positioned.fill(
//                 child: isRemoteJoined && remoteUid != 0
//                     ? AgoraVideoView(
//                         controller: VideoViewController.remote(
//                           rtcEngine: engine,
//                           canvas: VideoCanvas(uid: remoteUid),
//                           connection: RtcConnection(
//                             channelId: widget.channelId,
//                           ),
//                         ),
//                       )
//                     : Container(color: Colors.white),
//               ),

//               /// CENTER CALLING UI
//         /// CALLING UI (ONLY BEFORE PATIENT JOINS)
// if (!controller.isRemoteUserJoined.value)
//   Align(
//     alignment: Alignment.center,
//     child: SingleChildScrollView(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const Text(
//             "Calling...",
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.grey,
//             ),
//           ),

//           const SizedBox(height: 6),

//           /// PATIENT NAME
//           Text(
//             controller.currentAppointment?.patient?.name ?? "Unknown",
//             style: const TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),

//           const SizedBox(height: 30),

//           /// PATIENT IMAGE
//           Container(
//             padding: const EdgeInsets.all(6),
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               border: Border.all(
//                 color: Colors.green,
//                 width: 4,
//               ),
//             ),
//             child: ClipOval(
//               child: (controller.currentAppointment?.patient?.photo != null &&
//                       controller.currentAppointment!.patient!.photo!.isNotEmpty)
//                   ? Image.network(
//                       "${ApiConstants.imageBaseUrl}${controller.currentAppointment!.patient!.photo}",
//                       width: 180,
//                       height: 180,
//                       fit: BoxFit.cover,
//                     )
//                   : Image.asset(
//                       // "assets/images/profile_placeholder.png",
//                       "no profile patient",
//                       width: 180,
//                       height: 180,
//                       fit: BoxFit.cover,
//                     ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   ),

//               /// LOCAL VIDEO (TOP RIGHT)
//               Positioned(
//                 top: 12,
//                 right: 12,
//                 width: 110,
//                 height: 150,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: AgoraVideoView(
//                     controller: VideoViewController(
//                       rtcEngine: engine,
//                       canvas: const VideoCanvas(uid: 0),
//                     ),
//                   ),
//                 ),
//               ),

//               /// BOTTOM CONTROLS
//               Positioned(
//                 left: 0,
//                 right: 0,
//                 bottom: 30,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                   _circleIcon(
//   icon: Icons.description,
//   onTap: () {
//     Get.bottomSheet(
//       CallOptionsBottomSheet(),
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//     );
//   },
// ),

//                     _circleIcon(
//                       icon: controller.isSpeakerOn.value
//                           ? Icons.volume_up
//                           : Icons.volume_off,
//                       onTap: controller.toggleSpeaker,
//                     ),
//                     _circleIcon(
//                       icon: Icons.cameraswitch,
//                       onTap: controller.switchCamera,
//                     ),
//                     _circleIcon(
//                       icon: controller.isMuted.value
//                           ? Icons.mic_off
//                           : Icons.mic,
//                       onTap: controller.toggleMute,
//                     ),

//                     /// END CALL
//                     GestureDetector(
//                       onTap: () async {
//                         await controller.endCall();
//                       },
//                       child: Container(
//                         width: 64,
//                         height: 64,
//                         decoration: const BoxDecoration(
//                           color: Colors.red,
//                           shape: BoxShape.circle,
//                         ),
//                         child: const Icon(
//                           Icons.call_end,
//                           color: Colors.white,
//                           size: 30,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }

//   /// GREEN ROUND ICON
//   Widget _circleIcon({
//     required IconData icon,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 56,
//         height: 56,
//         decoration: BoxDecoration(
//           color: Colors.green.withOpacity(0.15),
//           shape: BoxShape.circle,
//         ),
//         child: Icon(
//           icon,
//           color: Colors.green,
//           size: 26,
//         ),
//       ),
//     );
//   }
// }
import 'dart:developer';
import 'package:beh_doctor/apiconstant/apiconstant.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:beh_doctor/modules/auth/controller/AgoraCallController.dart';

import 'CallsOptionBottomSheet.dart';

class AgoraDoctorCallScreen extends StatefulWidget {
  final String channelId;
  final String token;

  const AgoraDoctorCallScreen({
    Key? key,
    required this.channelId,
    required this.token,
  }) : super(key: key);

  @override
  State<AgoraDoctorCallScreen> createState() => _AgoraDoctorCallScreenState();
}

class _AgoraDoctorCallScreenState extends State<AgoraDoctorCallScreen> {
  // ❗ existing controller reuse karo
  final AgoraCallController controller = Get.find<AgoraCallController>();

  late final Worker _closeWorker;

  String _formatStopwatchTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    _prepareAndJoin();

    _closeWorker = ever<bool>(controller.shouldCloseCallScreen, (shouldClose) {
      if (!shouldClose) return;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      });
    });
  }

  @override
  void dispose() {
    _closeWorker.dispose();
    super.dispose();
  }

  Future<void> _prepareAndJoin() async {
    await [Permission.camera, Permission.microphone].request();

    if (controller.isJoined.value == true) return;

    try {
      await controller.joinCall(
        channelId: widget.channelId,
        token: widget.token,
      );
    } catch (e) {
      log('❌ joinCall failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        final isJoined = controller.isJoined.value;
        final engine = controller.engine;
        final remoteUid = controller.remoteUid.value;
        final isRemoteJoined = controller.isRemoteUserJoined.value;

        if (!isJoined || engine == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return SafeArea(
          child: Stack(
            children: [
              /// REMOTE VIDEO
              Positioned.fill(
                child: isRemoteJoined && remoteUid != 0
                    ? ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                        child: AgoraVideoView(
                          controller: VideoViewController.remote(
                            rtcEngine: engine,
                            canvas: VideoCanvas(uid: remoteUid),
                            connection: RtcConnection(
                              channelId: widget.channelId,
                            ),
                          ),
                        ),
                      )
                    : Container(color: Colors.white),
              ),

              if (isRemoteJoined)
                Positioned(
                  top: 16,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.35),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _formatStopwatchTime(controller.callDurationSec.value),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),

              /// CALLING UI (before patient joins)
              if (!controller.isRemoteUserJoined.value)
                Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "calling".tr,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          controller.currentAppointment?.patient?.name ??
                              "Unknown",
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.green, width: 5),
                          ),
                          child: ClipOval(
                            child:
                                (controller
                                            .currentAppointment
                                            ?.patient
                                            ?.photo !=
                                        null &&
                                    controller
                                        .currentAppointment!
                                        .patient!
                                        .photo!
                                        .isNotEmpty)
                                ? Image.network(
                                    "${ApiConstants.imageBaseUrl}${controller.currentAppointment!.patient!.photo}",
                                    width: 180,
                                    height: 180,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    width: 180,
                                    height: 180,
                                    color: Colors.grey.shade300,
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.person,
                                      size: 56,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              /// LOCAL VIDEO
              Positioned(
                top: 12,
                right: 12,
                width: 110,
                height: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AgoraVideoView(
                    controller: VideoViewController(
                      rtcEngine: engine,
                      canvas: const VideoCanvas(uid: 0),
                    ),
                  ),
                ),
              ),

              /// BOTTOM CONTROLS
              Positioned(
                left: 0,
                right: 0,
                bottom: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AgoraCallButton(
                      buttonColor: const Color(0xFFCCE7D9),
                      icon: Icons.list,
                      iconColor: const Color(0xFF008541),
                      callBackFunction: () async {
                        // await controller.endCall(goToPrescription: true);
                        Get.bottomSheet(
                          CallOptionsBottomSheet(),
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                        );
                      },
                    ),
                    const SizedBox(width: 16),
                    AgoraCallButton(
                      buttonColor: const Color(0xFFCCE7D9),
                      icon: controller.isSpeakerOn.value
                          ? Icons.volume_up
                          : Icons.volume_off,
                      iconColor: const Color(0xFF008541),
                      callBackFunction: controller.toggleSpeaker,
                    ),
                    const SizedBox(width: 16),
                    AgoraCallButton(
                      buttonColor: const Color(0xFFCCE7D9),
                      icon: Icons.flip_camera_ios_outlined,
                      iconColor: const Color(0xFF008541),
                      callBackFunction: controller.switchCamera,
                    ),
                    const SizedBox(width: 16),
                    AgoraCallButton(
                      buttonColor: const Color(0xFFEFEFEF),
                      icon: controller.isMuted.value
                          ? Icons.mic_off_outlined
                          : Icons.mic_none_outlined,
                      iconColor: Colors.black,
                      callBackFunction: controller.toggleMute,
                    ),
                    const SizedBox(width: 16),
                    AgoraCallButton(
                      buttonColor: const Color(0xFFF14F4A),
                      icon: Icons.phone,
                      iconColor: Colors.white,
                      callBackFunction: () async {
                        await controller.endCall(goToPrescription: true);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class AgoraCallButton extends StatelessWidget {
  final Color buttonColor;
  final IconData icon;
  final Color iconColor;
  final VoidCallback callBackFunction;

  const AgoraCallButton({
    super.key,
    required this.buttonColor,
    required this.icon,
    required this.iconColor,
    required this.callBackFunction,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callBackFunction,
      borderRadius: BorderRadius.circular(40),
      child: Container(
        height: 56,
        width: 56,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Icon(icon, color: iconColor, size: 26),
      ),
    );
  }
}
