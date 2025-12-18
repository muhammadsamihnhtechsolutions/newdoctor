// lib/socket/agora_call_socket_handler.dart
import 'dart:developer';
import 'package:beh_doctor/apiconstant/apiconstant.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
// 

typedef SocketCallback = void Function(dynamic data);

class AgoraCallSocketHandler {
  AgoraCallSocketHandler._internal();
  static final AgoraCallSocketHandler instance = AgoraCallSocketHandler._internal();

  IO.Socket? socket;
  bool _connected = false;

  Future<void> initSocket({
    required String appointmentId,
    required SocketCallback onJoinedEvent,
    required SocketCallback onRejectedEvent,
    required SocketCallback onEndedEvent,
    void Function()? onConnected,
    void Function(dynamic)? onError,
  }) async {
    if (socket != null && _connected) {
      // already connected and joined room
      log("Socket already initialized for appointment: $appointmentId");
      return;
    }

    socket = IO.io(
      ApiConstants.baseUrl,
      <String, dynamic>{
        'path': '/socket',
        'transports': ['websocket'],
        'autoConnect': true,
      },
    );

    socket?.onConnect((_) {
      _connected = true;
      log("Socket connected");
      if (onConnected != null) onConnected();

      // join room for this appointment
      socket?.emit('joinAppointmentRoom', {'appointmentId': appointmentId});
      log("Socket emitted joinAppointmentRoom for $appointmentId");
    });

    socket?.on('joinedCall', (data) {
      log("Socket.on joinedCall -> $data");
      onJoinedEvent(data);
    });

    socket?.on('rejectCall', (data) {
      log("Socket.on rejectCall -> $data");
      onRejectedEvent(data);
    });

    socket?.on('endCall', (data) {
      log("Socket.on endCall -> $data");
      onEndedEvent(data);
    });

    socket?.onDisconnect((_) {
      _connected = false;
      log("Socket disconnected");
    });

    socket?.onConnectError((err) {
      log("Socket connect error: $err");
      if (onError != null) onError(err);
    });

    socket?.onError((err) {
      log("Socket error: $err");
      if (onError != null) onError(err);
    });
  }

  /// Dispose and disconnect socket
  void disposeSocket() {
    try {
      socket?.disconnect();
      socket = null;
      _connected = false;
      log("Socket disposed");
    } catch (e) {
      log("Socket dispose error: $e");
    }
  }

  /// Helper emits (in case you want client->server emits)
  void emitJoinedCall({required String appointmentId}) {
    socket?.emit('joinedCall', {'appointmentId': appointmentId});
    log("Socket emitted joinedCall for $appointmentId");
  }

  void emitRejectCall({required String appointmentId}) {
    socket?.emit('rejectCall', {'appointmentId': appointmentId});
    log("Socket emitted rejectCall for $appointmentId");
  }

  void emitEndCall({required String appointmentId}) {
    socket?.emit('endCall', {'appointmentId': appointmentId});
    log("Socket emitted endCall for $appointmentId");
  }
}
