
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
              /// /// PATIENT INFO BAR (image wali UI)
/// PATIENT INFO BAR (image wali UI)
if (controller.isRemoteUserJoined.value)
  Positioned(
    left: 16,
    right: 16,
    bottom: 110,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.60),

   // ✅ opacity WORKING
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          /// PROFILE IMAGE
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.green, width: 3),
            ),
            child: ClipOval(
              child: (controller.currentAppointment?.patient?.photo != null &&
                      controller.currentAppointment!.patient!.photo!.isNotEmpty)
                  ? Image.network(
                      "${ApiConstants.imageBaseUrl}${controller.currentAppointment!.patient!.photo}",
                      width: 46,
                      height: 46,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: 46,
                      height: 46,
                      color: Colors.grey.shade300,
                      child:
                          const Icon(Icons.person, color: Colors.white, size: 26),
                    ),
            ),
          ),

          const SizedBox(width: 12),

          /// NAME + TIMER
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.currentAppointment?.patient?.name ?? "Unknown",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _formatStopwatchTime(
                    controller.callDurationSec.value,
                  ),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          /// VOICE WAVE (speaker ON/OFF)
          Obx(() {
            return Container(
              height: 42,
              width: 42,
              decoration: const BoxDecoration(
                color: Colors.green, // ✅ wave visible
                shape: BoxShape.circle,
              ),
              child: Center(
                child: controller.isSpeakerOn.value
                    ? const _VoiceWave(isActive: true)
                    : const _VoiceWave(isActive: false),
              ),
            );
          }),
        ],
      ),
    ),
  ),

// showpatatintprofilename
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

// wavekiwidget
class _VoiceWave extends StatefulWidget {
  final bool isActive;
  const _VoiceWave({this.isActive = true});

  @override
  State<_VoiceWave> createState() => _VoiceWaveState();
}

class _VoiceWaveState extends State<_VoiceWave>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    if (widget.isActive) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant _VoiceWave oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive) {
      _controller.repeat();
    } else {
      _controller.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(4, (index) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              final value = (_controller.value + index * 0.2) % 1;
              final height = 6 + (value * 10);

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 1.5),
                width: 3,
                height: height, // ✅ ACTUAL animated height
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
