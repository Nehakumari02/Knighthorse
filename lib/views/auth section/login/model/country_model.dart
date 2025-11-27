

import '../../../../base/widgets/custom_drop_down.dart';

class Country implements DropdownModel{
  final String name;
  final String flagUrl;
  final String link;

  Country({
    required this.name,
    required this.flagUrl,
    required this.link,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'],
      flagUrl: json['flag'],
      link: json['link'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'flag': flagUrl,
      'link': link,
    };
  }

    @override
  String get title => name;
  
  @override
  String get leading => flagUrl;

}
