import '../model/DataUser.dart';
import '../model/DataSupport.dart';

class SingleUser {
  Data? data;
  Support? support;

  SingleUser({this.data, this.support});

  SingleUser.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    support =
        json['support'] != null ? new Support.fromJson(json['support']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.support != null) {
      data['support'] = this.support!.toJson();
    }
    return data;
  }
}

class UninitializedUser extends SingleUser {}
