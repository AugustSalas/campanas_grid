import 'dart:convert';

class ModelActiveCampaigns {
  final bool response;
  final List<String> activeCampaigns;

  ModelActiveCampaigns({
    required this.response,
    required this.activeCampaigns,
  });

  factory ModelActiveCampaigns.fromJson(String str) =>
      ModelActiveCampaigns.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ModelActiveCampaigns.fromMap(Map<String, dynamic> json) =>
      ModelActiveCampaigns(
        response: json["response"],
        activeCampaigns:
            List<String>.from(json["activeCampaigns"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "response": response,
        "activeCampaigns": List<dynamic>.from(activeCampaigns.map((x) => x)),
      };
}
