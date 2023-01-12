import 'package:elearning/core/data/share_preference/spref_base_model.dart';

class SPrefSettingFlashCard extends SPrefBaseModel {
  static SPrefSettingFlashCard? _instance;

  static const String shuffleKey = "SHUFFLE_KEY";

  static const String soundKey = "SOUND_KEY";

  static const String settingCardKey = "CARD_KEY";

  static const String alphabetKey = "ALPHABET_KEY";

  SPrefSettingFlashCard._();

  factory SPrefSettingFlashCard() => _instance ??= SPrefSettingFlashCard._();

  Future<bool> setShuffle(bool value) async {
    return await setBool(key: shuffleKey, value: value);
  }

  bool getShuffle() {
    return getBool(key: shuffleKey, defaultValue: false);
  }

  Future<bool> setSound(bool value) async {
    return await setBool(key: soundKey, value: value);
  }

  bool getSound() {
    return getBool(key: soundKey, defaultValue: false);
  }

  Future<bool> setSettingCard(bool value) async {
    return await setBool(key: settingCardKey, value: value);
  }

  bool getSettingCard() {
    return getBool(key: settingCardKey, defaultValue: false);
  }

  Future<bool> setAlphabet(bool value) async {
    return await setBool(key: alphabetKey, value: value);
  }

  bool getAlphabet() {
    return getBool(key: alphabetKey, defaultValue: false);
  }
}
