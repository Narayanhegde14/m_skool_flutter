// To parse this JSON data, do
//
//     final unreadDataModel = unreadDataModelFromJson(jsonString);

import 'dart:convert';

UnreadDataModel unreadDataModelFromJson(String str) =>
    UnreadDataModel.fromJson(json.decode(str));

String unreadDataModelToJson(UnreadDataModel data) =>
    json.encode(data.toJson());

class UnreadDataModel {
  UnreadDataModel({
    this.returnval,
    this.alreadyCnt,
    this.composeedto,
    this.userId,
    this.rolename,
    this.ivrmgCEnableStIntFlg,
    this.ivrmgCEnableCtIntFlg,
    this.ivrmgCEnableHodIntFlg,
    this.ivrmgCEnablePrincipalIntFlg,
    this.ivrmgCEnableAsIntFlg,
    this.asmclid,
    this.asmsid,
    this.amsTId,
    this.hrmEId1,
    this.studentId,
    this.hrmEId,
    this.userhrmEId,
    this.employeeId,
    this.asmcLId,
    this.asmSId,
    this.ivrmrTId,
    this.ivrmgCEnableEcIntFlg,
    this.subteacherlist,
    this.typelistrole,
    this.typelist,
    this.classteacherlist,
    this.viewmessage,
    this.getMsgcreator,
    this.inboxcount,
    this.isminTId,
    this.mIId,
    this.isminTInteractionId,
    this.asmaYId,
    this.isminTComposedByFlg,
    this.isminTComposedById,
    this.isminTDateTime,
    this.isminTActiveFlag,
    this.isminTCreatedBy,
    this.isminTUpdatedBy,
    this.istinTId,
    this.istinTToId,
    this.istinTComposedById,
    this.istinTDateTime,
    this.istinTInteractionOrder,
    this.istinTActiveFlag,
    this.istinTCreatedBy,
    this.istinTUpdatedBy,
    this.amcsTId,
    this.amcoid,
    this.ambid,
    this.amseid,
    this.acmsid,
    this.amcOId,
    this.amBId,
    this.amsEId,
    this.amBOrder,
    this.amsESemOrder,
    this.acmSId,
    this.acmSOrder,
  });

  bool? returnval;
  bool? alreadyCnt;
  String? composeedto;
  int? userId;
  String? rolename;
  bool? ivrmgCEnableStIntFlg;
  bool? ivrmgCEnableCtIntFlg;
  bool? ivrmgCEnableHodIntFlg;
  bool? ivrmgCEnablePrincipalIntFlg;
  bool? ivrmgCEnableAsIntFlg;
  int? asmclid;
  int? asmsid;
  int? amsTId;
  int? hrmEId1;
  int? studentId;
  int? hrmEId;
  int? userhrmEId;
  int? employeeId;
  int? asmcLId;
  int? asmSId;
  int? ivrmrTId;
  bool? ivrmgCEnableEcIntFlg;
  Classteacherlist? subteacherlist;
  Classteacherlist? typelistrole;
  Classteacherlist? typelist;
  Classteacherlist? classteacherlist;
  ViewMessage? viewmessage;
  Classteacherlist? getMsgcreator;
  int? inboxcount;
  int? isminTId;
  int? mIId;
  int? isminTInteractionId;
  int? asmaYId;
  String? isminTComposedByFlg;
  int? isminTComposedById;
  DateTime? isminTDateTime;
  bool? isminTActiveFlag;
  int? isminTCreatedBy;
  int? isminTUpdatedBy;
  int? istinTId;
  int? istinTToId;
  int? istinTComposedById;
  DateTime? istinTDateTime;
  int? istinTInteractionOrder;
  bool? istinTActiveFlag;
  int? istinTCreatedBy;
  int? istinTUpdatedBy;
  int? amcsTId;
  int? amcoid;
  int? ambid;
  int? amseid;
  int? acmsid;
  int? amcOId;
  int? amBId;
  int? amsEId;
  int? amBOrder;
  int? amsESemOrder;
  int? acmSId;
  int? acmSOrder;

  factory UnreadDataModel.fromJson(Map<String, dynamic> json) =>
      UnreadDataModel(
        returnval: json["returnval"],
        alreadyCnt: json["already_cnt"],
        composeedto: json["composeedto"],
        userId: json["userId"],
        rolename: json["rolename"],
        ivrmgCEnableStIntFlg: json["ivrmgC_EnableSTIntFlg"],
        ivrmgCEnableCtIntFlg: json["ivrmgC_EnableCTIntFlg"],
        ivrmgCEnableHodIntFlg: json["ivrmgC_EnableHODIntFlg"],
        ivrmgCEnablePrincipalIntFlg: json["ivrmgC_EnablePrincipalIntFlg"],
        ivrmgCEnableAsIntFlg: json["ivrmgC_EnableASIntFlg"],
        asmclid: json["asmclid"],
        asmsid: json["asmsid"],
        amsTId: json["amsT_Id"],
        hrmEId1: json["hrmE_Id1"],
        studentId: json["student_Id"],
        hrmEId: json["hrmE_Id"],
        userhrmEId: json["userhrmE_Id"],
        employeeId: json["employee_Id"],
        asmcLId: json["asmcL_Id"],
        asmSId: json["asmS_Id"],
        ivrmrTId: json["ivrmrT_Id"],
        ivrmgCEnableEcIntFlg: json["ivrmgC_EnableECIntFlg"],
        subteacherlist: Classteacherlist.fromJson(json["subteacherlist"]),
        typelistrole: Classteacherlist.fromJson(json["typelistrole"]),
        typelist: Classteacherlist.fromJson(json["typelist"]),
        classteacherlist: Classteacherlist.fromJson(json["classteacherlist"]),
        viewmessage: ViewMessage.fromJson(json["viewmessage"]),
        getMsgcreator: Classteacherlist.fromJson(json["get_msgcreator"]),
        inboxcount: json["inboxcount"],
        isminTId: json["isminT_Id"],
        mIId: json["mI_Id"],
        isminTInteractionId: json["isminT_InteractionId"],
        asmaYId: json["asmaY_Id"],
        isminTComposedByFlg: json["isminT_ComposedByFlg"],
        isminTComposedById: json["isminT_ComposedById"],
        isminTDateTime: DateTime.parse(json["isminT_DateTime"]),
        isminTActiveFlag: json["isminT_ActiveFlag"],
        isminTCreatedBy: json["isminT_CreatedBy"],
        isminTUpdatedBy: json["isminT_UpdatedBy"],
        istinTId: json["istinT_Id"],
        istinTToId: json["istinT_ToId"],
        istinTComposedById: json["istinT_ComposedById"],
        istinTDateTime: DateTime.parse(json["istinT_DateTime"]),
        istinTInteractionOrder: json["istinT_InteractionOrder"],
        istinTActiveFlag: json["istinT_ActiveFlag"],
        istinTCreatedBy: json["istinT_CreatedBy"],
        istinTUpdatedBy: json["istinT_UpdatedBy"],
        amcsTId: json["amcsT_Id"],
        amcoid: json["amcoid"],
        ambid: json["ambid"],
        amseid: json["amseid"],
        acmsid: json["acmsid"],
        amcOId: json["amcO_Id"],
        amBId: json["amB_Id"],
        amsEId: json["amsE_Id"],
        amBOrder: json["amB_Order"],
        amsESemOrder: json["amsE_SEMOrder"],
        acmSId: json["acmS_Id"],
        acmSOrder: json["acmS_Order"],
      );

  Map<String, dynamic> toJson() => {
        "returnval": returnval,
        "already_cnt": alreadyCnt,
        "composeedto": composeedto,
        "userId": userId,
        "rolename": rolename,
        "ivrmgC_EnableSTIntFlg": ivrmgCEnableStIntFlg,
        "ivrmgC_EnableCTIntFlg": ivrmgCEnableCtIntFlg,
        "ivrmgC_EnableHODIntFlg": ivrmgCEnableHodIntFlg,
        "ivrmgC_EnablePrincipalIntFlg": ivrmgCEnablePrincipalIntFlg,
        "ivrmgC_EnableASIntFlg": ivrmgCEnableAsIntFlg,
        "asmclid": asmclid,
        "asmsid": asmsid,
        "amsT_Id": amsTId,
        "hrmE_Id1": hrmEId1,
        "student_Id": studentId,
        "hrmE_Id": hrmEId,
        "userhrmE_Id": userhrmEId,
        "employee_Id": employeeId,
        "asmcL_Id": asmcLId,
        "asmS_Id": asmSId,
        "ivrmrT_Id": ivrmrTId,
        "ivrmgC_EnableECIntFlg": ivrmgCEnableEcIntFlg,
        "subteacherlist": subteacherlist!.toJson(),
        "typelistrole": typelistrole!.toJson(),
        "typelist": typelist!.toJson(),
        "classteacherlist": classteacherlist!.toJson(),
        "viewmessage": viewmessage!.toJson(),
        "get_msgcreator": getMsgcreator!.toJson(),
        "inboxcount": inboxcount,
        "isminT_Id": isminTId,
        "mI_Id": mIId,
        "isminT_InteractionId": isminTInteractionId,
        "asmaY_Id": asmaYId,
        "isminT_ComposedByFlg": isminTComposedByFlg,
        "isminT_ComposedById": isminTComposedById,
        "isminT_DateTime": isminTDateTime!.toIso8601String(),
        "isminT_ActiveFlag": isminTActiveFlag,
        "isminT_CreatedBy": isminTCreatedBy,
        "isminT_UpdatedBy": isminTUpdatedBy,
        "istinT_Id": istinTId,
        "istinT_ToId": istinTToId,
        "istinT_ComposedById": istinTComposedById,
        "istinT_DateTime": istinTDateTime!.toIso8601String(),
        "istinT_InteractionOrder": istinTInteractionOrder,
        "istinT_ActiveFlag": istinTActiveFlag,
        "istinT_CreatedBy": istinTCreatedBy,
        "istinT_UpdatedBy": istinTUpdatedBy,
        "amcsT_Id": amcsTId,
        "amcoid": amcoid,
        "ambid": ambid,
        "amseid": amseid,
        "acmsid": acmsid,
        "amcO_Id": amcOId,
        "amB_Id": amBId,
        "amsE_Id": amsEId,
        "amB_Order": amBOrder,
        "amsE_SEMOrder": amsESemOrder,
        "acmS_Id": acmSId,
        "acmS_Order": acmSOrder,
      };
}

class Classteacherlist {
  Classteacherlist({
    this.type,
    this.values,
  });

  String? type;
  List<Value>? values;

  factory Classteacherlist.fromJson(Map<String, dynamic> json) =>
      Classteacherlist(
        type: json["\$type"],
        values:
            List<Value>.from(json["\$values"].map((x) => Value.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": List<dynamic>.from(values!.map((x) => x.toJson())),
      };
}

class Value {
  Value({
    this.ivrmrTId,
    this.ivrmrTRole,
    this.ivrmRId,
    this.ivrmrTRoleFlag,
    this.flag,
    this.createdDate,
    this.updatedDate,
    this.type,
    this.istintAttachment,
    this.istintId,
    this.ismintId,
    this.ismintGroupOrIndFlg,
    this.istintToFlg,
    this.istintComposedById,
    this.istintInteraction,
    this.istintDateTime,
    this.istintComposedByFlg,
    this.istintInteractionOrder,
    this.sender,
    this.receiver,
  });

  int? ivrmrTId;
  String? ivrmrTRole;
  int? ivrmRId;
  String? ivrmrTRoleFlag;
  String? flag;
  DateTime? createdDate;
  DateTime? updatedDate;
  String? type;
  String? istintAttachment;
  int? istintId;
  int? ismintId;
  String? ismintGroupOrIndFlg;
  String? istintToFlg;
  int? istintComposedById;
  String? istintInteraction;
  DateTime? istintDateTime;
  String? istintComposedByFlg;
  int? istintInteractionOrder;
  String? sender;
  String? receiver;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        ivrmrTId: json["ivrmrT_Id"] == null ? null : json["ivrmrT_Id"],
        ivrmrTRole: json["ivrmrT_Role"] == null ? null : json["ivrmrT_Role"],
        ivrmRId: json["ivrmR_Id"] == null ? null : json["ivrmR_Id"],
        ivrmrTRoleFlag:
            json["ivrmrT_RoleFlag"] == null ? null : json["ivrmrT_RoleFlag"],
        flag: json["flag"] == null ? null : json["flag"],
        createdDate: json["createdDate"] == null
            ? null
            : DateTime.parse(json["createdDate"]),
        updatedDate: json["updatedDate"] == null
            ? null
            : DateTime.parse(json["updatedDate"]),
        type: json["\$type"] == null ? null : json["\$type"],
        istintAttachment: json["ISTINT_Attachment"] == null
            ? null
            : json["ISTINT_Attachment"],
        istintId: json["ISTINT_Id"] == null ? null : json["ISTINT_Id"],
        ismintId: json["ISMINT_Id"] == null ? null : json["ISMINT_Id"],
        ismintGroupOrIndFlg: json["ISMINT_GroupOrIndFlg"] == null
            ? null
            : json["ISMINT_GroupOrIndFlg"],
        istintToFlg: json["ISTINT_ToFlg"] == null ? null : json["ISTINT_ToFlg"],
        istintComposedById: json["ISTINT_ComposedById"] == null
            ? null
            : json["ISTINT_ComposedById"],
        istintInteraction: json["ISTINT_Interaction"] == null
            ? null
            : json["ISTINT_Interaction"],
        istintDateTime: json["ISTINT_DateTime"] == null
            ? null
            : DateTime.parse(json["ISTINT_DateTime"]),
        istintComposedByFlg: json["ISTINT_ComposedByFlg"] == null
            ? null
            : json["ISTINT_ComposedByFlg"],
        istintInteractionOrder: json["ISTINT_InteractionOrder"] == null
            ? null
            : json["ISTINT_InteractionOrder"],
        sender: json["Sender"] == null ? null : json["Sender"],
        receiver: json["Receiver"] == null ? null : json["Receiver"],
      );

  Map<String, dynamic> toJson() => {
        "ivrmrT_Id": ivrmrTId == null ? null : ivrmrTId,
        "ivrmrT_Role": ivrmrTRole == null ? null : ivrmrTRole,
        "ivrmR_Id": ivrmRId == null ? null : ivrmRId,
        "ivrmrT_RoleFlag": ivrmrTRoleFlag == null ? null : ivrmrTRoleFlag,
        "flag": flag == null ? null : flag,
        "createdDate":
            createdDate == null ? null : createdDate!.toIso8601String(),
        "updatedDate":
            updatedDate == null ? null : updatedDate!.toIso8601String(),
        "\$type": type == null ? null : type,
        "ISTINT_Attachment": istintAttachment == null ? null : istintAttachment,
        "ISTINT_Id": istintId == null ? null : istintId,
        "ISMINT_Id": ismintId == null ? null : ismintId,
        "ISMINT_GroupOrIndFlg":
            ismintGroupOrIndFlg == null ? null : ismintGroupOrIndFlg,
        "ISTINT_ToFlg": istintToFlg == null ? null : istintToFlg,
        "ISTINT_ComposedById":
            istintComposedById == null ? null : istintComposedById,
        "ISTINT_Interaction":
            istintInteraction == null ? null : istintInteraction,
        "ISTINT_DateTime":
            istintDateTime == null ? null : istintDateTime!.toIso8601String(),
        "ISTINT_ComposedByFlg":
            istintComposedByFlg == null ? null : istintComposedByFlg,
        "ISTINT_InteractionOrder":
            istintInteractionOrder == null ? null : istintInteractionOrder,
        "Sender": sender == null ? null : sender,
        "Receiver": receiver == null ? null : receiver,
      };
}

class ViewMessage {
  ViewMessage({
    this.type,
    this.values,
  });

  String? type;
  List<Value>? values;

  factory ViewMessage.fromJson(Map<String, dynamic> json) => ViewMessage(
        type: json["\$type"],
        values:
            List<Value>.from(json["\$values"].map((x) => Value.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": List<dynamic>.from(values!.map((x) => x.toJson())),
      };
}

class ViewMessageValue {
  ViewMessageValue({
    this.ivrmrTId,
    this.ivrmrTRole,
    this.ivrmRId,
    this.ivrmrTRoleFlag,
    this.flag,
    this.createdDate,
    this.updatedDate,
    this.type,
    this.istintAttachment,
    this.istintId,
    this.ismintId,
    this.ismintGroupOrIndFlg,
    this.istintToFlg,
    this.istintComposedById,
    this.istintInteraction,
    this.istintDateTime,
    this.istintComposedByFlg,
    this.istintInteractionOrder,
    this.sender,
    this.receiver,
  });

  int? ivrmrTId;
  String? ivrmrTRole;
  int? ivrmRId;
  String? ivrmrTRoleFlag;
  String? flag;
  DateTime? createdDate;
  DateTime? updatedDate;
  String? type;
  String? istintAttachment;
  int? istintId;
  int? ismintId;
  String? ismintGroupOrIndFlg;
  String? istintToFlg;
  int? istintComposedById;
  String? istintInteraction;
  DateTime? istintDateTime;
  String? istintComposedByFlg;
  int? istintInteractionOrder;
  String? sender;
  String? receiver;

  factory ViewMessageValue.fromJson(Map<String, dynamic> json) =>
      ViewMessageValue(
        ivrmrTId: json["ivrmrT_Id"] == null ? null : json["ivrmrT_Id"],
        ivrmrTRole: json["ivrmrT_Role"] == null ? null : json["ivrmrT_Role"],
        ivrmRId: json["ivrmR_Id"] == null ? null : json["ivrmR_Id"],
        ivrmrTRoleFlag:
            json["ivrmrT_RoleFlag"] == null ? null : json["ivrmrT_RoleFlag"],
        flag: json["flag"] == null ? null : json["flag"],
        createdDate: json["createdDate"] == null
            ? null
            : DateTime.parse(json["createdDate"]),
        updatedDate: json["updatedDate"] == null
            ? null
            : DateTime.parse(json["updatedDate"]),
        type: json["\$type"] == null ? null : json["\$type"],
        istintAttachment: json["ISTINT_Attachment"] == null
            ? null
            : json["ISTINT_Attachment"],
        istintId: json["ISTINT_Id"] == null ? null : json["ISTINT_Id"],
        ismintId: json["ISMINT_Id"] == null ? null : json["ISMINT_Id"],
        ismintGroupOrIndFlg: json["ISMINT_GroupOrIndFlg"] == null
            ? null
            : json["ISMINT_GroupOrIndFlg"],
        istintToFlg: json["ISTINT_ToFlg"] == null ? null : json["ISTINT_ToFlg"],
        istintComposedById: json["ISTINT_ComposedById"] == null
            ? null
            : json["ISTINT_ComposedById"],
        istintInteraction: json["ISTINT_Interaction"] == null
            ? null
            : json["ISTINT_Interaction"],
        istintDateTime: json["ISTINT_DateTime"] == null
            ? null
            : DateTime.parse(json["ISTINT_DateTime"]),
        istintComposedByFlg: json["ISTINT_ComposedByFlg"] == null
            ? null
            : json["ISTINT_ComposedByFlg"],
        istintInteractionOrder: json["ISTINT_InteractionOrder"] == null
            ? null
            : json["ISTINT_InteractionOrder"],
        sender: json["Sender"] == null ? null : json["Sender"],
        receiver: json["Receiver"] == null ? null : json["Receiver"],
      );

  Map<String, dynamic> toJson() => {
        "ivrmrT_Id": ivrmrTId == null ? null : ivrmrTId,
        "ivrmrT_Role": ivrmrTRole == null ? null : ivrmrTRole,
        "ivrmR_Id": ivrmRId == null ? null : ivrmRId,
        "ivrmrT_RoleFlag": ivrmrTRoleFlag == null ? null : ivrmrTRoleFlag,
        "flag": flag == null ? null : flag,
        "createdDate":
            createdDate == null ? null : createdDate!.toIso8601String(),
        "updatedDate":
            updatedDate == null ? null : updatedDate!.toIso8601String(),
        "\$type": type == null ? null : type,
        "ISTINT_Attachment": istintAttachment == null ? null : istintAttachment,
        "ISTINT_Id": istintId == null ? null : istintId,
        "ISMINT_Id": ismintId == null ? null : ismintId,
        "ISMINT_GroupOrIndFlg":
            ismintGroupOrIndFlg == null ? null : ismintGroupOrIndFlg,
        "ISTINT_ToFlg": istintToFlg == null ? null : istintToFlg,
        "ISTINT_ComposedById":
            istintComposedById == null ? null : istintComposedById,
        "ISTINT_Interaction":
            istintInteraction == null ? null : istintInteraction,
        "ISTINT_DateTime":
            istintDateTime == null ? null : istintDateTime!.toIso8601String(),
        "ISTINT_ComposedByFlg":
            istintComposedByFlg == null ? null : istintComposedByFlg,
        "ISTINT_InteractionOrder":
            istintInteractionOrder == null ? null : istintInteractionOrder,
        "Sender": sender == null ? null : sender,
        "Receiver": receiver == null ? null : receiver,
      };
}
