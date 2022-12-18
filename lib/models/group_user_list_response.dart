import 'package:demo/models/group_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group_user_list_response.g.dart';

@JsonSerializable()
class GroupUserListResponse {
  @JsonKey(defaultValue: 0)
  int? count;

  String? next;

  String? previous;

  @JsonKey(name: 'results')
  List<GroupUser>? results;

  GroupUserListResponse({
    this.count,
    this.next,
    this.previous,
    this.results = const [],
  });

  factory GroupUserListResponse.fromJson(Map<String, dynamic> json) =>
      _$GroupUserListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GroupUserListResponseToJson(this);
}
