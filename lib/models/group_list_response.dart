import 'package:demo/models/group.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group_list_response.g.dart';

@JsonSerializable()
class GroupListResponse {
  @JsonKey(defaultValue: 0)
  int? count;

  String? next;

  String? previous;

  @JsonKey(name: 'results')
  List<Group>? results;

  GroupListResponse({
    this.count,
    this.next,
    this.previous,
    this.results = const [],
  });

  factory GroupListResponse.fromJson(Map<String, dynamic> json) =>
      _$GroupListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GroupListResponseToJson(this);
}
