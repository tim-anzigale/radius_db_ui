// subscription_model.dart

import '../models/plan_class.dart';

class Subscription {
  String id;
  String name;
  String password;
  String zcrmId;
  Location location;
  Plan plan;
  String pppoe;
  String macAdd;
  bool usePublicIp;
  Map<String, Ip> ips;
  Map<String, Ip> publicIps;
  LastCon lastCon;
  bool isDisconnected;
  bool isTerminated;
  String statusLevel;
  DateTime createdAt;
  DateTime updatedAt;

  Subscription({
    required this.id,
    required this.name,
    required this.password,
    required this.zcrmId,
    required this.location,
    required this.plan,
    required this.pppoe,
    required this.macAdd,
    required this.usePublicIp,
    required this.ips,
    required this.publicIps,
    required this.lastCon,
    required this.isDisconnected,
    required this.isTerminated,
    required this.statusLevel,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      password: json['password'] ?? '',
      zcrmId: json['zcrm_id'] ?? '',
      location: Location.fromJson(json['location'] ?? {}),
      plan: Plan.fromJson(json['plan'] ?? {}),
      pppoe: json['PPPoE'] ?? '',
      macAdd: json['mac_add'] ?? '',
      usePublicIp: json['usePublicIp'] ?? false,
      ips: Map<String, Ip>.from(json['ips']?.map((k, v) => MapEntry(k, Ip.fromJson(v))) ?? {}),
      publicIps: Map<String, Ip>.from(json['publicIps']?.map((k, v) => MapEntry(k, Ip.fromJson(v))) ?? {}),
      lastCon: LastCon.fromJson(json['last_con'] ?? {}),
      isDisconnected: json['isDisconnected'] ?? false,
      isTerminated: json['isTerminated'] ?? false,
      statusLevel: json['statusLevel'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'password': password,
      'zcrm_id': zcrmId,
      'location': location.toJson(),
      'plan': plan.toJson(),
      'PPPoE': pppoe,
      'mac_add': macAdd,
      'usePublicIp': usePublicIp,
      'ips': Map.from(ips).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      'publicIps': Map.from(publicIps).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      'last_con': lastCon.toJson(),
      'isDisconnected': isDisconnected,
      'isTerminated': isTerminated,
      'statusLevel': statusLevel,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class Location {
  String type;
  List<double> coordinates;

  Location({required this.type, required this.coordinates});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'] ?? '',
      coordinates: List<double>.from(json['coordinates']?.map((x) => x.toDouble()) ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': List<dynamic>.from(coordinates.map((x) => x)),
    };
  }
}

class Ip {
  String ip;
  String subnetMask;
  bool zabbixConnected;

  Ip({required this.ip, required this.subnetMask, required this.zabbixConnected});

  factory Ip.fromJson(Map<String, dynamic> json) {
    return Ip(
      ip: json['ip'] ?? '',
      subnetMask: json['subnetMask'] ?? '',
      zabbixConnected: json['zabbixConnected'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ip': ip,
      'subnetMask': subnetMask,
      'zabbixConnected': zabbixConnected,
    };
  }
}

class LastCon {
  String ip;
  String nas;
  String nasIp;
  DateTime time;
  String macAdd;

  LastCon({required this.ip, required this.nas, required this.nasIp, required this.time, required this.macAdd});

  factory LastCon.fromJson(Map<String, dynamic> json) {
    return LastCon(
      ip: json['ip'] ?? '',
      nas: json['NAS'] ?? '',
      nasIp: json['NAS_IP'] ?? '',
      time: DateTime.parse(json['time'] ?? DateTime.now().toIso8601String()),
      macAdd: json['mac_add'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ip': ip,
      'NAS': nas,
      'NAS_IP': nasIp,
      'time': time.toIso8601String(),
      'mac_add': macAdd,
    };
  }
}