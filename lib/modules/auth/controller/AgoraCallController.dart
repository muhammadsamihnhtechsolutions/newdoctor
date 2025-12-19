// import 'dart:async';

// import 'dart:developer';
// import 'package:beh_doctor/Handler/AgoraCallSocketHandler.dart';
// import 'package:beh_doctor/models/AppointmentModel.dart';
// import 'package:beh_doctor/repo/AuthRepo.dart';
// import 'package:beh_doctor/views/PrescriptionFlowScreen.dart';
// import 'package:get/get.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';

// class AgoraCallController extends GetxController {
//   final ApiRepo _repo = ApiRepo();

//   RtcEngine? engine;

//   var isJoined = false.obs;
//   var isRemoteUserJoined = false.obs;

//   // Remote user UID
//   var remoteUid = 0.obs;
//   RxBool isMuted = false.obs;
//   RxBool isSpeakerOn = false.obs;

//   /// Channel ID = Appointment ID
//   String channelId = "";

//   /// Doctor token from appointment
//   String doctorToken = "";

//   Appointment? currentAppointment;

//   var callDurationSec = 0.obs;
//   Timer? _callTimer;

//   // Prevent concurrent join attempts
//   bool _joining = false;

//   @override
//   void onClose() {
//     _stopTimer();
//     _cleanupEngine();
//     try {
//       AgoraCallSocketHandler.instance.disposeSocket();
//     } catch (_) {}
//     super.onClose();
//   }

//   // ------------------------------------------------
//   // SET APPOINTMENT
//   // ------------------------------------------------
//   void setAppointment(Appointment appt) {
//     currentAppointment = appt;

//     channelId = appt.id ?? "";
//     doctorToken = appt.doctorAgoraToken ?? "";

//     log("SET APPT => channel: $channelId | token: ${doctorToken.isNotEmpty ? '***' : 'EMPTY'}");
//     print("💡 Doctor Token set: $doctorToken");
//     print("currentAppointment${appt}");
//     print("channlid milgya${channelId}");
//   }

//   // ------------------------------------------------
//   // DOCTOR PRESS CALL NOW
//   // ------------------------------------------------
//   Future<void> callNow() async {
//     if (currentAppointment == null) {
//       Get.snackbar("Error", "Appointment not found");
//       log("callNow aborted: appointment null");
//       return;
//     }

//     print("💡 callNow() - Doctor Token: $doctorToken");

//     // 1 - Notify Server / Patient
//     try {
//       log("Calling API to notify patient...");
//       final res = await _repo.makeAppointmentCall(
//         appointmentId: currentAppointment!.id!,
//       );
//       log("CallNow API => $res");

//       if (res == null) {
//         Get.snackbar("Error", "Call API returned null");
//         return;
//       }
//       if (res is Map && res["status"] != "success") {
//         Get.snackbar("Error", res["message"] ?? "Failed to notify patient");
//         return;
//       }
//     } catch (e, st) {
//       log("CallNow API ERROR => $e\n$st");
//       Get.snackbar("Error", "Failed to notify patient. Check network.");
//       return;
//     }

//     // 2 - Init socket for patient events
//     try {
//       await AgoraCallSocketHandler.instance.initSocket(
//         appointmentId: channelId,
//         onJoinedEvent: (data) {
//           log("🔥 Socket => PATIENT JOINED (socket event) -> $data");
//           isRemoteUserJoined.value = true;
//         },
//         onRejectedEvent: (data) {
//           log("❌ PATIENT REJECTED (socket event) -> $data");
//           Get.snackbar("Rejected", "Patient rejected the call");
//           endCall();
//         },
//         onEndedEvent: (data) {
//           log("⚠ PATIENT ENDED CALL (socket event) -> $data");
//           endCall();
//         },
//       );
//     } catch (e) {
//       log("Socket init failed: $e");
//       Get.snackbar("Warning", "Socket init failed, continuing with call...");
//     }

//     // 3 - Join Agora
//     try {
//       await joinDoctorAgora();
//     } catch (e) {
//       log("joinDoctorAgora threw: $e");
//       Get.snackbar("Error", "Unable to start Agora. ${e.toString()}");
//       await _cleanupEngine();
//       return;
//     }

//     // 4 - Wait for join success
//     try {
//       await isJoined.stream.firstWhere((v) => v == true).timeout(
//         const Duration(seconds: 20),
//         onTimeout: () {
//           throw TimeoutException("Agora join timed out");
//         },
//       );

//       _startTimer();

//       Get.toNamed("/AgoraDoctorCallScreen");
//     } on TimeoutException catch (te) {
//       log("Agora join timeout: $te");
//       Get.snackbar("Error", "Unable to join call (timeout).");
//       await _cleanupEngine();
//     } catch (e) {
//       log("Error waiting for join: $e");
//       Get.snackbar("Error", "Unable to start call.");
//       await _cleanupEngine();
//     }
//   }

// Future<void> joinDoctorAgora() async {
//   print("🔵 joinDoctorAgora() CALLED");

//   if (channelId.isEmpty || doctorToken.isEmpty) {
//     print("❌ channelId or token EMPTY");
//     Get.snackbar("Error", "Agora token or channel missing");
//     return;
//   }

//   if (_joining) {
//     print("⚠️ Already joining, ignored");
//     return;
//   }

//   _joining = true;

//   try {
//     // ---------------- ENGINE INIT ----------------
//     try {
//       print("🟡 Creating Agora Engine");
//       if (engine == null) {
//         engine = createAgoraRtcEngine();
//         await engine!.initialize(
//           const RtcEngineContext(
//             appId: "0fb1a1ecf5a34db2b51d9896c994652a",
//           ),
//         );
//         print("✅ AGORA ENGINE INITIALIZED");
//       } else {
//         print("ℹ️ Engine already exists");
//       }
//     } catch (e, st) {
//       print("❌ ENGINE INIT FAILED: $e");
//       print(st);
//       rethrow;
//     }

//     // ---------------- EVENT HANDLER ----------------
//     try {
//       print("🟡 Registering Event Handler");
//       engine!.registerEventHandler(
//         RtcEngineEventHandler(
//           onJoinChannelSuccess: (connection, elapsed) {
//             print("✅ DOCTOR JOINED CHANNEL");
//              print("✅ DOCTOR JOINED CHANNEL");
//   print("🆔 LOCAL UID (Doctor) => ${connection.localUid}");
//             isJoined.value = true;
//           },
//           onUserJoined: (connection, uid, elapsed) {
//             print("👤 PATIENT JOINED UID => $uid");
//             remoteUid.value = uid;
//             isRemoteUserJoined.value = true;
//           },
//           onUserOffline: (connection, uid, reason) {
//             print("❌ PATIENT LEFT => $reason");
//             isRemoteUserJoined.value = false;
//             endCall();
//           },
//           onError: (code, msg) {
//             print("🔥 AGORA ERROR => $code | $msg");
//           },
//         ),
//       );
//       print("✅ Event Handler Registered");
//     } catch (e, st) {
//       print("❌ EVENT HANDLER ERROR: $e");
//       print(st);
//     }

//     // ---------------- VIDEO / AUDIO ----------------
//   // ---------------- VIDEO / AUDIO ----------------

// try {
//   print("🟡 Enabling Video");
//   await engine!.enableVideo();
//   print("✅ enableVideo DONE");
// } catch (e, st) {
//   print("❌ enableVideo ERROR: $e");
//   print(st);
// }

// try {
//   print("🟡 Enabling Audio");
//   await engine!.enableAudio();
//   print("✅ enableAudio DONE");
// } catch (e, st) {
//   print("❌ enableAudio ERROR: $e");
//   print(st);
// }

// try {
//   print("🟡 Enabling Local Video");
//   await engine!.enableLocalVideo(true);
//   print("✅ enableLocalVideo DONE");
// } catch (e, st) {
//   print("❌ enableLocalVideo ERROR: $e");
//   print(st);
// }

// try {
//   print("🟡 Unmute Local Video");
//   await engine!.muteLocalVideoStream(false);
//   print("✅ muteLocalVideoStream(false) DONE");
// } catch (e, st) {
//   print("❌ muteLocalVideoStream ERROR: $e");
//   print(st);
// }

//     // ---------------- ROLE ----------------
//     try {
//       print("🟡 Setting Client Role = BROADCASTER");
//       await engine!.setClientRole(
//         role: ClientRoleType.clientRoleBroadcaster,
//       );
//       print("✅ Client Role Set");
//     } catch (e, st) {
//       print("❌ ROLE SET ERROR: $e");
//       print(st);
//     }

//     // ---------------- LOCAL VIDEO SETUP ----------------
//     try {
//       print("🟡 setupLocalVideo()");
//       await engine!.setupLocalVideo(
//         const VideoCanvas(
//           uid: 0,
//           sourceType: VideoSourceType.videoSourceCamera,
//         ),
//       );
//       print("✅ setupLocalVideo DONE");
//     } catch (e, st) {
//       print("❌ setupLocalVideo ERROR: $e");
//       print(st);
//     }

//     // ---------------- PREVIEW ----------------
//     try {
//       print("🟡 startPreview()");
//       await engine!.startPreview();
//       print("✅ Preview Started");
//     } catch (e, st) {
//       print("❌ startPreview ERROR: $e");
//       print(st);
//     }

//     // ---------------- JOIN CHANNEL ----------------
//     try {
//       print("🟡 joinChannel()");
//       print("➡️ channelId: $channelId");
//       print("➡️ token length: ${doctorToken.length}");

//       await engine!.joinChannel(
//         token: doctorToken,
//         channelId: channelId,
//         uid: 0,
//         options: const ChannelMediaOptions(
//           clientRoleType: ClientRoleType.clientRoleBroadcaster,
//           publishCameraTrack: true,
//           publishMicrophoneTrack: true,
//           autoSubscribeAudio: true,
//           autoSubscribeVideo: true,
//         ),
//       );

//       print("✅ joinChannel API CALLED");
//     } catch (e, st) {
//       print("❌ joinChannel ERROR: $e");
//       print(st);
//     }

//   } catch (e, st) {
//     print("🔥 FATAL ERROR joinDoctorAgora: $e");
//     print(st);
//   } finally {
//     _joining = false;
//     print("🔵 joinDoctorAgora() FINISHED");
//   }
// }

//   // ------------------------------------------------
//   // CLEAN TOKEN
//   // ------------------------------------------------
//   String cleanToken(String token) {
//     return token.replaceAll('\n', '').replaceAll('\r', '').trim();
//   }

//   // ------------------------------------------------
//   // END CALL
//   // ------------------------------------------------
//   Future<void> endCall() async {
//     try {
//       AgoraCallSocketHandler.instance.emitEndCall(
//         appointmentId: channelId,
//       );
//     } catch (_) {}

//     await _cleanupEngine();
//     _stopTimer();

//     if (Get.currentRoute == "/AgoraDoctorCallScreen") {
//       try {
//         Get.back();
//       } catch (_) {}
//     }
//   }

//   // ------------------------------------------------
//   // CLEANUP
//   // ------------------------------------------------
//   Future<void> _cleanupEngine() async {
//     try {
//       if (engine != null) {
//         try {
//           await engine!.leaveChannel();
//         } catch (_) {}
//         try {
//           await engine!.stopPreview();
//         } catch (_) {}
//         try {
//           await engine!.release();
//         } catch (_) {}
//         engine = null;
//       }
//       isJoined.value = false;
//       isRemoteUserJoined.value = false;
//       remoteUid.value = 0;
//     } catch (e) {
//       log("CLEANUP ERROR => $e");
//     }
//   }

//   // ------------------------------------------------
//   // TIMER
//   // ------------------------------------------------
//   void _startTimer() {
//     _callTimer?.cancel();
//     callDurationSec.value = 0;

//     _callTimer = Timer.periodic(Duration(seconds: 30), (_) {
//       callDurationSec.value++;
//     });
//   }

//   void _stopTimer() {
//     _callTimer?.cancel();
//     _callTimer = null;
//   }

//   /// UI compatible method
//   Future<void> joinCall({
//     required String channelId,
//     required String token,
//   }) async {
//     log("joinCall() UI Triggered");
//     print("💡 joinCall() with token: $token");

//     this.channelId = channelId;
//     this.doctorToken = token;

//     if (this.channelId.isEmpty || this.doctorToken.isEmpty) {
//       Get.snackbar("Error", "Missing channel or token");
//       return;
//     }

//     await joinDoctorAgora();
//   }

//   void toggleMute() {
//     isMuted.value = !isMuted.value;
//     engine?.muteLocalAudioStream(isMuted.value);
//   }

//   void switchCamera() {
//     engine?.switchCamera();
//   }

//   void toggleSpeaker() async {
//     isSpeakerOn.value = !isSpeakerOn.value;
//     await engine?.setEnableSpeakerphone(isSpeakerOn.value);
//   }

//   Future<void> submitPrescriptionAndCompleteCall({
//   required Map<String, dynamic> payload,
// }) async {
//   try {
//     log("📝 Submitting prescription...");

//     // 1️⃣ Submit Prescription
//     final res = await _repo.submitPrescription(payload);

//     if (res.status != "success") {
//       Get.snackbar(
//         "Error",
//         res.message ?? "Prescription submit failed",
//       );
//       return;
//     }

//     log("✅ Prescription submitted successfully");

//     // 2️⃣ Mark call as COMPLETED
//     try {
//       await _repo.markAppointmentCallAsCompleted(
//         channelId, // appointmentId
//         callDurationSec.value,
//       );
//       log("✅ Appointment marked as COMPLETED");
//     } catch (e) {
//       log("⚠ Failed to mark call complete: $e");
//       // ❗ app ko yahan fail mat karo
//     }

//     // // 3️⃣ End call (Agora + Socket)
//     await endCall();

//     // 4️⃣ Navigate doctor out of call flow
//     // Get.offAllNamed("/DoctorHome");

//   } catch (e, st) {
//     log("❌ submitPrescriptionAndCompleteCall ERROR => $e\n$st");
//     Get.snackbar("Error", "Something went wrong");
//   }
// }

// }
// import 'dart:async';
// import 'dart:developer';

// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:beh_doctor/Handler/AgoraCallSocketHandler.dart';
// import 'package:beh_doctor/models/AppointmentModel.dart';
// import 'package:beh_doctor/repo/AuthRepo.dart';
// import 'package:beh_doctor/views/PrescriptionFlowScreen.dart';
// import 'package:get/get.dart';

// class AgoraCallController extends GetxController {
//   final ApiRepo _repo = ApiRepo();

//   RtcEngine? engine;

//   var isJoined = false.obs;
//   var isRemoteUserJoined = false.obs;
//   var remoteUid = 0.obs;

//   RxBool isMuted = false.obs;
//   RxBool isSpeakerOn = false.obs;

//   String channelId = "";
//   String doctorToken = "";

//   Appointment? currentAppointment;

//   var callDurationSec = 0.obs;
//   Timer? _callTimer;
//   Timer? _patientJoinTimer;

//   bool _joining = false;

//   // ------------------------------------------------
//   // LIFECYCLE
//   // ------------------------------------------------
//   @override
//   void onClose() {
//     _stopAllTimers();
//     _cleanupEngine();
//     try {
//       AgoraCallSocketHandler.instance.disposeSocket();
//     } catch (_) {}
//     super.onClose();
//   }

//   // ------------------------------------------------
//   // SET APPOINTMENT
//   // ------------------------------------------------
//   void setAppointment(Appointment appt) {
//     currentAppointment = appt;
//     channelId = appt.id ?? "";
//     doctorToken = appt.doctorAgoraToken ?? "";

//     log("SET APPOINTMENT => channelId=$channelId");
//   }

//   // ------------------------------------------------
//   // 🔹 UI ENTRY POINT (FIX)
//   // ------------------------------------------------
//   /// Used by AgoraDoctorCallScreen
//   Future<void> joinCall({
//     required String channelId,
//     required String token,
//   }) async {
//     this.channelId = channelId;
//     doctorToken = token;

//     await joinDoctorAgora();
//   }

//   // ------------------------------------------------
//   // CALL NOW (Doctor presses call button)
//   // ------------------------------------------------
//   Future<void> callNow() async {
//     if (currentAppointment == null) {
//       Get.snackbar("Error", "Appointment not found");
//       return;
//     }

//     // 1️⃣ Notify server
//     try {
//       final res = await _repo.makeAppointmentCall(
//         appointmentId: currentAppointment!.id!,
//       );

//       if (res == null || (res is Map && res["status"] != "success")) {
//         Get.snackbar("Error", "Failed to notify patient");
//         return;
//       }
//     } catch (e) {
//       Get.snackbar("Error", "Network error");
//       return;
//     }

//     // 2️⃣ Init socket
//     await AgoraCallSocketHandler.instance.initSocket(
//       appointmentId: channelId,
//       onJoinedEvent: (_) {
//         isRemoteUserJoined.value = true;
//         _patientJoinTimer?.cancel();
//       },
//       onRejectedEvent: (_) {
//         Get.snackbar("Rejected", "Patient rejected the call");
//         endCall();
//       },
//       onEndedEvent: (_) {
//         endCall();
//       },
//     );

//     // 3️⃣ Join Agora
//     await joinDoctorAgora();

//     // 4️⃣ Wait for join
//     try {
//       await isJoined.stream
//           .firstWhere((v) => v == true)
//           .timeout(const Duration(seconds: 20));

//       _startCallTimer();
//       _startPatientJoinTimeout();

//       Get.toNamed("/AgoraDoctorCallScreen");
//     } catch (_) {
//       Get.snackbar("Error", "Unable to start call");
//       await _cleanupEngine();
//     }
//   }

//   // ------------------------------------------------
//   // JOIN AGORA CORE
//   // ------------------------------------------------
//   Future<void> joinDoctorAgora() async {
//     if (channelId.isEmpty || doctorToken.isEmpty || _joining) return;
//     _joining = true;

//     try {
//       engine ??= createAgoraRtcEngine();
//       await engine!.initialize(
//         const RtcEngineContext(
//           appId: "0fb1a1ecf5a34db2b51d9896c994652a",
//         ),
//       );

//       engine!.registerEventHandler(
//         RtcEngineEventHandler(
//           onJoinChannelSuccess: (_, __) {
//             isJoined.value = true;
//           },
//           onUserJoined: (_, uid, __) {
//             remoteUid.value = uid;
//             isRemoteUserJoined.value = true;
//             _patientJoinTimer?.cancel();
//           },
//           onUserOffline: (_, __, ___) {
//             endCall();
//           },
//         ),
//       );

//       await engine!.enableVideo();
//       await engine!.enableAudio();
//       await engine!.setClientRole(
//         role: ClientRoleType.clientRoleBroadcaster,
//       );

//       await engine!.joinChannel(
//         token: doctorToken,
//         channelId: channelId,
//         uid: 0,
//         options: const ChannelMediaOptions(
//           publishCameraTrack: true,
//           publishMicrophoneTrack: true,
//         ),
//       );
//     } finally {
//       _joining = false;
//     }
//   }

//   // ------------------------------------------------
//   // END CALL
//   // ------------------------------------------------
//   Future<void> endCall({bool goToPrescription = false}) async {
//     try {
//       AgoraCallSocketHandler.instance.emitEndCall(
//         appointmentId: channelId,
//       );
//     } catch (_) {}

//     await _cleanupEngine();
//     _stopAllTimers();

//     if (goToPrescription && currentAppointment != null) {
//       Get.off(() => PrescriptionFlowScreen(
//             appointment: currentAppointment!,
//             callDuration: callDurationSec.value,
//           ));
//       return;
//     }

//     if (Get.currentRoute == "/AgoraDoctorCallScreen") {
//       Get.back();
//     }
//   }

//   // ------------------------------------------------
//   // SUBMIT PRESCRIPTION
//   // ------------------------------------------------
//   Future<void> submitPrescriptionAndCompleteCall({
//     required Map<String, dynamic> payload,
//   }) async {
//     try {
//       final res = await _repo.submitPrescription(payload);

//       if (res.status != "success") {
//         Get.snackbar("Error", res.message ?? "Submit failed");
//         return;
//       }

//       try {
//         await _repo.markAppointmentCallAsCompleted(
//           channelId,
//           callDurationSec.value,
//         );
//       } catch (_) {}

//       await endCall(goToPrescription: true);
//     } catch (_) {
//       Get.snackbar("Error", "Something went wrong");
//     }
//   }

//   // ------------------------------------------------
//   // TIMERS
//   // ------------------------------------------------
//   void _startCallTimer() {
//     _callTimer?.cancel();
//     callDurationSec.value = 0;

//     _callTimer = Timer.periodic(
//       const Duration(seconds: 1),
//       (_) => callDurationSec.value++,
//     );
//   }

//   /// ⏱ Patient 30 sec tak join na kare → call auto end
//   void _startPatientJoinTimeout() {
//     _patientJoinTimer?.cancel();

//     _patientJoinTimer = Timer(const Duration(seconds: 30), () {
//       if (!isRemoteUserJoined.value) {
//         Get.snackbar(
//           "Call Ended",
//           "Patient did not answer the call",
//         );
//         endCall();
//       }
//     });
//   }

//   void _stopAllTimers() {
//     _callTimer?.cancel();
//     _patientJoinTimer?.cancel();
//     _callTimer = null;
//     _patientJoinTimer = null;
//   }

//   // ------------------------------------------------
//   // CLEANUP
//   // ------------------------------------------------
//   Future<void> _cleanupEngine() async {
//     if (engine != null) {
//       try {
//         await engine!.leaveChannel();
//         await engine!.release();
//       } catch (_) {}
//       engine = null;
//     }

//     isJoined.value = false;
//     isRemoteUserJoined.value = false;
//     remoteUid.value = 0;
//   }

//   // ------------------------------------------------
//   // UI CONTROLS
//   // ------------------------------------------------
//   void toggleMute() {
//     isMuted.value = !isMuted.value;
//     engine?.muteLocalAudioStream(isMuted.value);
//   }

//   void toggleSpeaker() async {
//     isSpeakerOn.value = !isSpeakerOn.value;
//     await engine?.setEnableSpeakerphone(isSpeakerOn.value);
//   }

// ignore_for_file: unnecessary_type_check, unnecessary_null_comparison

//   void switchCamera() {
//     engine?.switchCamera();
//   }
// }
import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:beh_doctor/Handler/AgoraCallSocketHandler.dart';
import 'package:beh_doctor/models/AppointmentModel.dart';
import 'package:beh_doctor/repo/AuthRepo.dart';
import 'package:beh_doctor/views/PrescriptionFlowScreen.dart';
import 'package:get/get.dart';

class AgoraCallController extends GetxController {
  final ApiRepo _repo = ApiRepo();

  RtcEngine? engine;

  var isJoined = false.obs;
  var isRemoteUserJoined = false.obs;
  var remoteUid = 0.obs;
  RxBool isPrescriptionLoading = false.obs;
  RxBool shouldCloseCallScreen = false.obs;

  RxBool isMuted = false.obs;
  RxBool isSpeakerOn = false.obs;

  String channelId = "";
  String doctorToken = "";

  Appointment? currentAppointment;

  var callDurationSec = 0.obs;
  Timer? _callTimer;
  Timer? _patientJoinTimer;

  bool _joining = false;

  bool _callEnded = false; // 🔥 FIX: prevent multiple end calls

  // ------------------------------------------------
  // LIFECYCLE
  // ------------------------------------------------
  @override
  void onClose() {
    _stopAllTimers();
    _cleanupEngine();
    try {
      AgoraCallSocketHandler.instance.disposeSocket();
    } catch (_) {}
    super.onClose();
  }

  // ------------------------------------------------
  // SET APPOINTMENT
  // ------------------------------------------------
  void setAppointment(Appointment appt) {
    currentAppointment = appt;
    channelId = appt.id ?? "";
    doctorToken = appt.doctorAgoraToken ?? "";
    _callEnded = false; // 🔥 FIX reset for new call
    shouldCloseCallScreen.value = false;
  }

  // ------------------------------------------------
  // UI JOIN
  // ------------------------------------------------
  Future<void> joinCall({
    required String channelId,
    required String token,
  }) async {
    this.channelId = channelId;
    doctorToken = token;
    await joinDoctorAgora();
  }

  // ------------------------------------------------
  // CALL NOW
  // ------------------------------------------------
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

  // ------------------------------------------------
  // JOIN AGORA
  // ------------------------------------------------
  Future<void> joinDoctorAgora() async {
    // if (_joining || channelId.isEmpty || doctorToken.isEmpty) return;
    if (_joining ||
        isJoined.value ||
        engine != null && isJoined.value ||
        channelId.isEmpty ||
        doctorToken.isEmpty) {
      return;
    }
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
      await engine!.setClientRole(role: ClientRoleType.clientRoleBroadcaster);

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

  // ------------------------------------------------
  // CALL DROPPED / REJECTED
  // ------------------------------------------------
  Future<void> _markCallDropped(String message) async {
    if (_callEnded) return; // 🔥 FIX
    _callEnded = true;

    try {
      await _repo.markAppointmentCallAsDropped(channelId);
    } catch (_) {}

    Get.snackbar("call_ended".tr, message);

    await _endCallInternal(emitEndCallEvent: false, goToPrescription: false);
  }

  Future<void> _handleRemoteEnd(String message) async {
    if (_callEnded) return;
    _callEnded = true;

    Get.snackbar("call_ended".tr, message);

    await _endCallInternal(emitEndCallEvent: false, goToPrescription: false);
  }

  // ------------------------------------------------
  // END CALL
  // ------------------------------------------------
  Future<void> endCall({required bool goToPrescription}) async {
    if (_callEnded) return;
    _callEnded = true;

    await _endCallInternal(
      emitEndCallEvent: true,
      goToPrescription: goToPrescription,
    );
  }

  Future<void> _endCallInternal({
    required bool emitEndCallEvent,
    required bool goToPrescription,
  }) async {
    final bool hadPatientJoined = isRemoteUserJoined.value;

    if (emitEndCallEvent) {
      try {
        AgoraCallSocketHandler.instance.emitEndCall(appointmentId: channelId);
      } catch (_) {}
    }

    try {
      AgoraCallSocketHandler.instance.disposeSocket();
    } catch (_) {}

    await _cleanupEngine();
    _stopAllTimers();

    // BLoC behavior: only go to prescription if patient actually joined.
    if (goToPrescription && hadPatientJoined && currentAppointment != null) {
      Get.off(
        () => PrescriptionFlowScreen(
          appointmentId: currentAppointment!.id!,
          callDuration: callDurationSec.value,
        ),
      );
      return;
    }

    // Signal UI to close call screen (prevents loader loop when engine/isJoined reset)
    shouldCloseCallScreen.value = true;

    // Close call screen (avoid being stuck on loader after cleanup)
    try {
      final current = Get.currentRoute;
      if (current.contains("AgoraDoctorCallScreen")) {
        Get.back();
        return;
      }

      if (Get.key.currentState?.canPop() ?? false) {
        Get.back();
      }
    } catch (_) {}
  }

  // ------------------------------------------------
  // SUBMIT PRESCRIPTION
  // ------------------------------------------------
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

      await _repo.markAppointmentCallAsCompleted(
        channelId,
        callDurationSec.value,
      );

      print("✅ call marked completed");

      // 🔥 loader OFF
      isPrescriptionLoading.value = false;

      // BLoC behavior: close overview + flow
      try {
        if (Get.key.currentState?.canPop() ?? false) {
          Get.back();
        }
        if (Get.key.currentState?.canPop() ?? false) {
          Get.back();
        }
      } catch (_) {}
    } catch (e, s) {
      isPrescriptionLoading.value = false;
      print("❌ submit error");
      print(e);
      print(s);
      Get.snackbar("error".tr, "something_went_wrong".tr);
    }
  }

  // ------------------------------------------------
  // TIMERS
  // ------------------------------------------------
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
    _patientJoinTimer = Timer(const Duration(seconds: 30), () {
      if (!isRemoteUserJoined.value) {
        _markCallDropped("patient_did_not_pick_up".tr);
      }
    });
  }

  void _stopAllTimers() {
    _callTimer?.cancel();
    _patientJoinTimer?.cancel();
    _callTimer = null;
    _patientJoinTimer = null;
  }

  // ------------------------------------------------
  // CLEANUP
  // ------------------------------------------------
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

  // ------------------------------------------------
  // UI CONTROLS
  // ------------------------------------------------
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
