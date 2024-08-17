import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watchdice/layers/data/character_repository_impl.dart';
import 'package:watchdice/layers/data/source/local/local_storage.dart';
import 'package:watchdice/layers/data/source/network/api.dart';
import 'package:watchdice/layers/domain/repository/character_repository.dart';
import 'package:watchdice/layers/domain/usecase/get_all_characters.dart';
import 'package:watchdice/main.dart';

// -----------------------------------------------------------------------------
// Presentation
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// Domain
// -----------------------------------------------------------------------------
final characterRepositoryProvider = Provider<CharacterRepository>(
  (ref) => CharacterRepositoryImpl(
    api: ref.read(apiProvider),
    localStorage: ref.read(localStorageProvider),
  ),
);

final getAllCharactersProvider = Provider(
  (ref) => GetAllCharacters(
    repository: ref.read(characterRepositoryProvider),
  ),
);

// -----------------------------------------------------------------------------
// Data
// -----------------------------------------------------------------------------
final apiProvider = Provider<Api>((ref) => ApiImpl());

final localStorageProvider = Provider<LocalStorage>(
  (ref) => LocalStorageImpl(sharedPreferences: sharedPref_Temp),
);
