class MeaningModel {
  String? wordType;
  List<WordMeaning> wordMeaning;
  List<ExampleMeaning> exampleMeaning;

  MeaningModel({
    this.wordType,
    this.wordMeaning = const [],
    this.exampleMeaning = const [],
  });

  factory MeaningModel.fromJson(Map<String, dynamic> json) {
    return MeaningModel(
      wordType: json['wordType'] as String?,
      wordMeaning: (json['wordMeaning'] as List<dynamic>?)
              ?.map((dynamic e) =>
                  WordMeaning.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      exampleMeaning: (json['exampleMeaning'] as List<dynamic>?)
              ?.map((dynamic e) =>
                  ExampleMeaning.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }
}

class WordMeaning {
  int? number;
  String? word;

  WordMeaning({this.number, this.word});

  factory WordMeaning.fromJson(Map<String, dynamic> json) {
    return WordMeaning(
      number: json['number'] as int?,
      word: json['word'] as String?,
    );
  }
}

class ExampleMeaning {
  int? number;
  String? example;

  ExampleMeaning({this.number, this.example});

  factory ExampleMeaning.fromJson(Map<String, dynamic> json) {
    return ExampleMeaning(
      number: json['number'] as int?,
      example: json['example'] as String?,
    );
  }
}
