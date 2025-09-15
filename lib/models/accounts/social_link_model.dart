class SocialModel{
  final String? facebookUrl;
  final String? twitterUrl;
  final String? instagramUrl;
  final String? linkedinUrl;
  final String? youtubeUrl;
  final String? websiteUrl;
  final String? whatsappNumber;
  final String? telegramUrl;

  SocialModel({
    this.facebookUrl,
    this.twitterUrl,
    this.instagramUrl,
    this.linkedinUrl,
    this.youtubeUrl,
    this.websiteUrl,
    this.whatsappNumber,
    this.telegramUrl
});

  factory SocialModel.fromJson(Map<String, dynamic> json) => SocialModel(
    facebookUrl: json['facebook_url'],
    twitterUrl: json['twitter_url'],
    instagramUrl: json['instagram_url'],
    linkedinUrl: json['linkedin_url'],
    youtubeUrl: json['youtube_url'],
    websiteUrl: json['website'],
    whatsappNumber: json['whatsapp']?.toString(),
    telegramUrl: json['telegram_username'],
  );

  Map<String, dynamic> toJson() => {
    "facebook_url" : facebookUrl,
    "twitter_url" : twitterUrl,
    "instagram_url" : instagramUrl,
    "linkedin_url" : linkedinUrl,
    "youtube_url" : youtubeUrl,
    "website" : websiteUrl,
    "whatsapp" : whatsappNumber,
    "telegram_username" : telegramUrl,
  };

  @override
  String toString() {

    return '''
    facebook_url : $facebookUrl,
    twitter_url : $twitterUrl,
    instagram_url : $instagramUrl,
    linkedin_url : $linkedinUrl,
    youtube_url : $youtubeUrl,
    website : $websiteUrl,
    whatsapp : $whatsappNumber,
    telegram_username : $telegramUrl,
    ''';
  }

}