class TranslationModel {
  int? originalWordId;
  String? originalWordText;
  String? translateLanguageCode;
  String? wordSpelling;
  List<SubTranslation> meanings;
  List<SubTranslation> synonyms;
  List<SubTranslation> antonyms;

  TranslationModel({
    this.originalWordId,
    this.originalWordText,
    this.translateLanguageCode,
    this.wordSpelling,
    this.meanings = const [],
    this.synonyms = const [],
    this.antonyms = const [],
  });

  factory TranslationModel.fromJson(Map<String, dynamic> json) {
    return TranslationModel(
      originalWordId: json['originalWordId'] as int?,
      originalWordText: json['originalWordText'] as String?,
      translateLanguageCode: json['translateLanguageCode'] as String?,
      wordSpelling: json['wordSpelling'] as String?,
      meanings: (json['meanings'] as List<dynamic>?)
              ?.map((dynamic e) =>
                  SubTranslation.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      synonyms: (json['synonyms'] as List<dynamic>?)
              ?.map((dynamic e) =>
                  SubTranslation.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      antonyms: (json['antonyms'] as List<dynamic>?)
              ?.map((dynamic e) =>
                  SubTranslation.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }
}

class SubTranslation {
  String? wordType;
  List<Words> words;

  SubTranslation({this.wordType, this.words = const []});

  factory SubTranslation.fromJson(Map<String, dynamic> json) {
    return SubTranslation(
      wordType: json['wordType'] as String?,
      words: (json['words'] as List<dynamic>?)
              ?.map((dynamic e) => Words.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }
}

class Words {
  int? wordId;
  String? wordText;
  String? example;
  int? rate;

  Words({this.wordId, this.wordText, this.example, this.rate});

  factory Words.fromJson(Map<String, dynamic> json) {
    return Words(
      wordId: json['wordId'] as int?,
      wordText: json['wordText'] as String?,
      example: json['example'] as String?,
      rate: json['rate'] as int?,
    );
  }
}
