

import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:beh_doctor/Handler/AgoraCallSocketHandler.dart';
import 'package:beh_doctor/models/AppointmentModel.dart';
import 'package:beh_doctor/repo/AuthRepo.dart';
import 'package:beh_doctor/views/PrescriptionFlowScreen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AgoraCallController extends GetxController {
  final ApiRepo _repo = ApiRepo();

  RtcEngine? engine;

  var isJoined = false.obs;
  var isRemoteUserJoined = false.obs;
  var remoteUid = 0.obs;
  RxBool isPrescriptionLoading = false.obs;
  RxBool shouldCloseCallScreen = false.obs;
  RxBool isVoiceActive = false.obs;
  


  RxBool isMuted = false.obs;
  RxBool isSpeakerOn = false.obs;

  String channelId = "";
  String doctorToken = "";

  Appointment? currentAppointment;

  var callDurationSec = 0.obs;
  Timer? _callTimer;
  Timer? _patientJoinTimer;

  bool _joining = false;
  bool _callEnded = false;

  @override
  void onClose() {
    _stopAllTimers();
    _cleanupEngine();
    try {
      AgoraCallSocketHandler.instance.disposeSocket();
    } catch (_) {}
    super.onClose();
  }

  void setAppointment(Appointment appt) {
    currentAppointment = appt;
    channelId = appt.id ?? "";
    doctorToken = appt.doctorAgoraToken ?? "";
    _callEnded = false;
    shouldCloseCallScreen.value = false;
  }

  Future<void> joinCall({
    required String channelId,
    required String token,
  }) async {
    this.channelId = channelId;
    doctorToken = token;
    await joinDoctorAgora();
  }

  Future<void> callNow() async {
    if (currentAppointment == null) return;

    try {
      final res = await _repo.makeAppointmentCall(
        appointmentId: currentAppointment!.id!,
      );

      if (res == null || (res is Map && res["status"] != "success")) {
        Get.snackbar("error".tr, "failed_to_notify_patient".tr);
        return;
      }
    } catch (_) {
      Get.snackbar("error".tr, "network_error".tr);
      return;
    }

    await AgoraCallSocketHandler.instance.initSocket(
      appointmentId: channelId,
      onJoinedEvent: (_) {
        isRemoteUserJoined.value = true;
        _patientJoinTimer?.cancel();
      },
      onRejectedEvent: (_) {
        _handleRemoteEnd("patient_rejected_call".tr);
      },
      onEndedEvent: (_) {
        _handleRemoteEnd("patient_ended_call".tr);
      },
    );

    await joinDoctorAgora();

    try {
      await isJoined.stream
          .firstWhere((v) => v == true)
          .timeout(const Duration(seconds: 20));

      _startCallTimer();
      _startPatientJoinTimeout();

      Get.toNamed("/AgoraDoctorCallScreen");
    } catch (_) {
      await _cleanupEngine();
    }
  }

  Future<void> joinDoctorAgora() async {
    if (_joining || channelId.isEmpty || doctorToken.isEmpty) return;
    _joining = true;

    try {
      engine ??= createAgoraRtcEngine();
      await engine!.initialize(
        const RtcEngineContext(appId: "0fb1a1ecf5a34db2b51d9896c994652a"),
      );

      engine!.registerEventHandler(
        RtcEngineEventHandler(
          onJoinChannelSuccess: (_, __) {
            isJoined.value = true;
          },
          onUserJoined: (_, uid, __) {
            remoteUid.value = uid;
            isRemoteUserJoined.value = true;
            _patientJoinTimer?.cancel();
          },
          onUserOffline: (_, __, ___) {
            _handleRemoteEnd("patient_disconnected_call".tr);
          },
          
        ),
      );

      await engine!.enableVideo();
      await engine!.enableAudio();
      await engine!.setClientRole(
        role: ClientRoleType.clientRoleBroadcaster,
      );

      await engine!.joinChannel(
        token: doctorToken,
        channelId: channelId,
        uid: 0,
        options: const ChannelMediaOptions(
          publishCameraTrack: true,
          publishMicrophoneTrack: true,
        ),
      );
    } finally {
      _joining = false;
    }
  }

  Future<void> _markCallDropped(String message) async {
    if (_callEnded) return;
    _callEnded = true;

    try {
      await _repo.markAppointmentCallAsDropped(channelId);
    } catch (_) {}

    Get.snackbar("call_ended".tr, message);

    await _endCallInternal(
      emitEndCallEvent: false,
      goToPrescription: false,
    );
  }

  Future<void> _handleRemoteEnd(String message) async {
    if (_callEnded) return;
    _callEnded = true;

    Get.snackbar("call_ended".tr, message);

    await _endCallInternal(
      emitEndCallEvent: false,
      goToPrescription: false,
    );
  }

  Future<void> endCall({required bool goToPrescription}) async {
    if (_callEnded) return;
    _callEnded = true;

    await _endCallInternal(
      emitEndCallEvent: true,
      goToPrescription: goToPrescription,
    );
  }

  // ================= FIXED (TRY CATCH + LOGS ONLY) =================
  Future<void> _endCallInternal({
    required bool emitEndCallEvent,
    required bool goToPrescription,
  }) async {
    try {
      final bool hadPatientJoined = isRemoteUserJoined.value;

      print("🟡 endCallInternal");
      print("appointmentId: ${currentAppointment?.id}");
      print("callDuration: ${callDurationSec.value}");
      print("goToPrescription: $goToPrescription");
      print("hadPatientJoined: $hadPatientJoined");

      if (emitEndCallEvent) {
        try {
          AgoraCallSocketHandler.instance
              .emitEndCall(appointmentId: channelId);
        } catch (e) {
          print("❌ emitEndCall error: $e");
        }
      }

      try {
        AgoraCallSocketHandler.instance.disposeSocket();
      } catch (e) {
        print("❌ disposeSocket error: $e");
      }

      try {
        await _cleanupEngine();
      } catch (e) {
        print("❌ cleanupEngine error: $e");
      }

      _stopAllTimers();

      if (goToPrescription &&
          hadPatientJoined &&
          currentAppointment != null) {
        try {
        WidgetsBinding.instance.addPostFrameCallback((_) {
  Get.off(
    () => PrescriptionFlowScreen(
      appointmentId: currentAppointment!.id!,
      callDuration: callDurationSec.value,
    ),
  );
});

          return;
        } catch (e) {
          print("❌ navigation error: $e");
        }
      }

      shouldCloseCallScreen.value = true;

      try {
        final current = Get.currentRoute;
        if (current.contains("AgoraDoctorCallScreen")) {
          Get.back();
          return;
        }

        if (Get.key.currentState?.canPop() ?? false) {
          Get.back();
        }
      } catch (e) {
        print("❌ back error: $e");
      }
    } catch (e, s) {
      print("🔥 endCallInternal crash prevented");
      print(e);
      print(s);
    }
  }

  // ================= SUBMIT =================
  Future<void> submitPrescriptionAndCompleteCall({
    required Map<String, dynamic> payload,
  }) async {
    if (isPrescriptionLoading.value) return;

    isPrescriptionLoading.value = true;
    print("🟡 submit start");

    try {
      final res = await _repo.submitPrescription(payload);
      print("✅ submit response: ${res.status}");

      if (res.status != "success") {
        isPrescriptionLoading.value = false;
        Get.snackbar("error".tr, res.message ?? "submit_failed".tr);
        return;
      }

      try {
        await _repo.markAppointmentCallAsCompleted(
          channelId,
          callDurationSec.value,
        );
        print("✅ call marked completed");
      } catch (e) {
        print("❌ call complete failed");
      }

      isPrescriptionLoading.value = false;

      if (Get.key.currentState?.canPop() ?? false) Get.back();
      if (Get.key.currentState?.canPop() ?? false) Get.back();
    } catch (e, s) {
      isPrescriptionLoading.value = false;
      print("❌ submit error");
      print(e);
      print(s);
      Get.snackbar("error".tr, "something_went_wrong".tr);
    }
  }

  void _startCallTimer() {
    callDurationSec.value = 0;
    _callTimer?.cancel();
    _callTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => callDurationSec.value++,
    );
  }

  void _startPatientJoinTimeout() {
    _patientJoinTimer?.cancel();
    _patientJoinTimer = Timer(
      const Duration(seconds: 30),
      () {
        if (!isRemoteUserJoined.value) {
          _markCallDropped("patient_did_not_pick_up".tr);
        }
      },
    );
  }

  void _stopAllTimers() {
    _callTimer?.cancel();
    _patientJoinTimer?.cancel();
    _callTimer = null;
    _patientJoinTimer = null;
  }

  Future<void> _cleanupEngine() async {
    if (engine != null) {
      try {
        await engine!.leaveChannel();
        await engine!.release();
      } catch (_) {}
      engine = null;
    }

    isJoined.value = false;
    isRemoteUserJoined.value = false;
    remoteUid.value = 0;
  }

  void toggleMute() {
    isMuted.value = !isMuted.value;
    engine?.muteLocalAudioStream(isMuted.value);
  }

  void toggleSpeaker() async {
    isSpeakerOn.value = !isSpeakerOn.value;
    await engine?.setEnableSpeakerphone(isSpeakerOn.value);
  }

  void switchCamera() {
    engine?.switchCamera();
  }
}


