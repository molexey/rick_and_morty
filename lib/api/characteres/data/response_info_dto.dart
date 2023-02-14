import 'package:json_annotation/json_annotation.dart';

part 'response_info_dto.g.dart';

@JsonSerializable()
class ResponseInfoDto {
  final int count;
  final int pages;

  const ResponseInfoDto({
    required this.count,
    required this.pages,
  });
  factory ResponseInfoDto.fromJson(Map<String, dynamic> json) =>
      _$ResponseInfoDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseInfoDtoToJson(this);
}
