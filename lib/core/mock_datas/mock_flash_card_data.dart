import 'package:elearning/core/data/models/flash_card_model.dart';

class MockDataFlashCard {
  static DataResponseFlashCardModel responseFlashCardModel =
      DataResponseFlashCardModel(
    status: true,
    message: "Get flash card successfully",
    // data: [MockDataFlashCard.flashCardModel],
    total: 1,
  );

  static List<TermModel> terms = [
    TermModel(id: 1, term: "Cat", definition: "Mèo"),
    TermModel(id: 2, term: "Chicken", definition: "Gà"),
    TermModel(id: 3, term: "Horse", definition: "Ngựa"),
    TermModel(id: 4, term: "Pig", definition: "Lợn"),
    TermModel(id: 5, term: "Duck", definition: "Vịt"),
    TermModel(id: 6, term: "Lion", definition: "Sử tử"),
    TermModel(id: 7, term: "Wolf", definition: "Sói"),
  ];

  static List<TermModel> termsBig = List.generate(
    10000,
    (index) => TermModel(id: index, term: "font $index", definition: "back $index"),
  );

  static FlashCardModel flashCardModel = FlashCardModel(
    id: 0,
    uuid: "abc",
    seriesName: "",
    name: "",
    description: "",
    items: terms,
    total: 0,
    used: 0,
    status: "",
    type: "",
    licensed: "",
    featuredImage: "",
    metaTitle: "",
    canonicalLink: "",
    slug: "",
    metaKeywords: "",
    metaDescription: "",
    version: "",
    setting: SettingModel(),
    createdBy: "",
    updatedBy: "",
    createdAt: DateTime.parse("2022-12-09T07:53:38.897Z"),
    updatedAt: DateTime.parse("2022-12-09T07:53:38.897Z"),
    deletedAt: DateTime.parse("2022-12-09T07:53:38.897Z"),
    tableName: "flashcards",
  );
}
