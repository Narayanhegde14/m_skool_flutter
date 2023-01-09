// To parse this JSON data, do
//
//     final sectionDropdownModel = sectionDropdownModelFromJson(jsonString);

import 'dart:convert';

SectionDropdownModel? sectionDropdownModelFromJson(String str) =>
    SectionDropdownModel.fromJson(json.decode(str));

String sectionDropdownModelToJson(SectionDropdownModel? data) =>
    json.encode(data!.toJson());

class SectionDropdownModel {
  SectionDropdownModel({
    this.estMId,
    this.mIId,
    this.asmaYId,
    this.asmcLId,
    this.asmSId,
    this.amsTId,
    this.emEId,
    this.ismSId,
    this.roleid,
    this.estMMarks,
    this.id,
    this.loginDateTime,
    this.estMActiveFlg,
    this.seclist,
    this.emgRId,
    this.saveupdatecount,
    this.lastdateentry,
    this.lastdateentryflag,
    this.emsSId,
    this.emsEId,
    this.lastdateexam,
    this.lastdateexamflag,
  });

  int? estMId;
  int? mIId;
  int? asmaYId;
  int? asmcLId;
  int? asmSId;
  int? amsTId;
  int? emEId;
  int? ismSId;
  int? roleid;
  int? estMMarks;
  int? id;
  DateTime? loginDateTime;
  bool? estMActiveFlg;
  Seclist? seclist;
  int? emgRId;
  int? saveupdatecount;
  int? lastdateentry;
  bool? lastdateentryflag;
  int? emsSId;
  int? emsEId;
  int? lastdateexam;
  bool? lastdateexamflag;

  factory SectionDropdownModel.fromJson(Map<String, dynamic> json) =>
      SectionDropdownModel(
        estMId: json["estM_Id"],
        mIId: json["mI_Id"],
        asmaYId: json["asmaY_Id"],
        asmcLId: json["asmcL_Id"],
        asmSId: json["asmS_Id"],
        amsTId: json["amsT_Id"],
        emEId: json["emE_Id"],
        ismSId: json["ismS_Id"],
        roleid: json["roleid"],
        estMMarks: json["estM_Marks"],
        id: json["id"],
        loginDateTime: DateTime.parse(json["loginDateTime"]),
        estMActiveFlg: json["estM_ActiveFlg"],
        seclist: Seclist.fromJson(json["seclist"]),
        emgRId: json["emgR_Id"],
        saveupdatecount: json["saveupdatecount"],
        lastdateentry: json["lastdateentry"],
        lastdateentryflag: json["lastdateentryflag"],
        emsSId: json["emsS_Id"],
        emsEId: json["emsE_Id"],
        lastdateexam: json["lastdateexam"],
        lastdateexamflag: json["lastdateexamflag"],
      );

  Map<String, dynamic> toJson() => {
        "estM_Id": estMId,
        "mI_Id": mIId,
        "asmaY_Id": asmaYId,
        "asmcL_Id": asmcLId,
        "asmS_Id": asmSId,
        "amsT_Id": amsTId,
        "emE_Id": emEId,
        "ismS_Id": ismSId,
        "roleid": roleid,
        "estM_Marks": estMMarks,
        "id": id,
        "loginDateTime": loginDateTime?.toIso8601String(),
        "estM_ActiveFlg": estMActiveFlg,
        "seclist": seclist!.toJson(),
        "emgR_Id": emgRId,
        "saveupdatecount": saveupdatecount,
        "lastdateentry": lastdateentry,
        "lastdateentryflag": lastdateentryflag,
        "emsS_Id": emsSId,
        "emsE_Id": emsEId,
        "lastdateexam": lastdateexam,
        "lastdateexamflag": lastdateexamflag,
      };
}

class Seclist {
  Seclist({
    this.type,
    this.values,
  });

  String? type;
  List<Value?>? values;

  factory Seclist.fromJson(Map<String, dynamic> json) => Seclist(
        type: json["\$type"],
        values: json["\$values"] == null
            ? []
            : List<Value?>.from(
                json["\$values"]!.map((x) => Value.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class Value {
  Value({
    this.asmSId,
    this.mIId,
    this.asmCSectionName,
    this.asmCSectionCode,
    this.asmCOrder,
    this.asmCActiveFlag,
    this.asmCMaxCapacity,
    this.createdDate,
    this.updatedDate,
  });

  int? asmSId;
  int? mIId;
  String? asmCSectionName;
  String? asmCSectionCode;
  int? asmCOrder;
  int? asmCActiveFlag;
  int? asmCMaxCapacity;
  DateTime? createdDate;
  DateTime? updatedDate;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        asmSId: json["asmS_Id"],
        mIId: json["mI_Id"],
        asmCSectionName: json["asmC_SectionName"],
        asmCSectionCode: json["asmC_SectionCode"],
        asmCOrder: json["asmC_Order"],
        asmCActiveFlag: json["asmC_ActiveFlag"],
        asmCMaxCapacity: json["asmC_MaxCapacity"],
        createdDate: DateTime.parse(json["createdDate"]),
        updatedDate: DateTime.parse(json["updatedDate"]),
      );

  Map<String, dynamic> toJson() => {
        "asmS_Id": asmSId,
        "mI_Id": mIId,
        "asmC_SectionName": asmCSectionName,
        "asmC_SectionCode": asmCSectionCode,
        "asmC_Order": asmCOrder,
        "asmC_ActiveFlag": asmCActiveFlag,
        "asmC_MaxCapacity": asmCMaxCapacity,
        "createdDate": createdDate?.toIso8601String(),
        "updatedDate": updatedDate?.toIso8601String(),
      };
}
