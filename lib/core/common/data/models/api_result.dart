
/// Représente une réponse standardisée des API de SYCELIM TECHNOLOGIES.
///
/// Toutes les réponses API suivent le format :
/// ```json
/// {
///   "answer": "code",    // Code statut métier
///   "comment": "texte",  // Message humain
///   "result": data       // Données optionnelles (null/Map/List)
/// }
/// ```
///
/// Codes `answer` standards :
/// - "1"  : Succès
/// - "0"  : Erreur métier
/// - "-1" : Non autorisé (authentication invalide)
///
/// Utilisation typique :
/// ```dart
/// final response = ApiResult<User>.fromMap(
///   jsonResponse,
///   mapMapper: User.fromJson,
/// );
///
/// if (response.isSuccess) {
///   final user = response.data!;
///   // Traiter le succès
/// } else if (response.isUnauthorized) {
///   // Rediriger vers login
/// } else {
///   showError(response.comment);
/// }
/// ```
class ApiResult<T> {

  final String answer;
  final String comment;
  final T? data;

  const ApiResult({
    required this.answer,
    required this.comment,
    this.data,
  });


  /// Copie la réponse avec des données différentes ou sans données.
  ApiResult<T> copyWith({
    String? answer,
    String? comment,
    T? data,
  }) {
    return ApiResult<T>(
      answer: answer ?? this.answer,
      comment: comment ?? this.comment,
      data: data ?? this.data,
    );
  }

  /// Succès métier
  bool get isSuccess => answer == '1';

  /// Erreur métier classique
  bool get isError => answer == '0';

  /// Session invalide / utilisateur déconnecté
  bool get isUnauthorized => answer == '-1';
  
  /// Crée une instance de [ApiResult] à partir d'une Map JSON.
  ///
  /// La méthode gère automatiquement le parsing des données en fonction du type
  /// de la propriété `result` dans le JSON.
  ///
  /// Exemples d'utilisation :
  /// ```dart
  /// // Pour un résultat de type Map
  /// final response = ApiResult<User>.fromMap(
  ///   jsonData,
  ///   mapMapper: (map) => User.fromJson(map),
  /// );
  ///
  /// // Pour un résultat de type List
  /// final response = ApiResult<List<User>>.fromMap(
  ///   jsonData,
  ///   listMapper: (list) => list.map((e) => User.fromJson(e)).toList(),
  /// );
  /// ```
  ///
  /// [map] : La Map contenant les données JSON
  /// [mapMapper] : Fonction de transformation pour les résultats de type Map
  /// [listMapper] : Fonction de transformation pour les résultats de type List
  ///
  /// Retourne une instance de [ApiResult] avec les données parsées.
  /// Lance une [FormatException] si le format de `result` n'est pas supporté.
  ///
  /// Format JSON attendu :
  /// ```json
  /// {
  ///   "answer": "1",        // Code réponse ("1": succès, "0": erreur, "-1": non autorisé)
  ///   "comment": "Message", // Message descriptif
  ///   "result": { ... }     // Données optionnelles (Map, List ou null)
  /// }
  /// ```
  factory ApiResult.fromMap(
      Map<String, dynamic> map, {
        T Function(Map<String, dynamic>)? mapMapper,
        T Function(List<dynamic>)? listMapper,
      }) {

    if (!map.containsKey('answer') || !map.containsKey('comment')) {
      throw const FormatException('Champs answer ou comment manquants');
    }

    final rawResult = map['result']; // peut être null ou absent

    T? parsedData;

    if (rawResult == null) {
      parsedData = null;
    } else if (rawResult is Map<String, dynamic> && mapMapper != null) {
      parsedData = mapMapper(rawResult);
    } else if (rawResult is List && listMapper != null) {
      parsedData = listMapper(rawResult);
    } /*else {
      throw FormatException('Format de result non supporté');
    }*/

    return ApiResult<T>(
      answer: map['answer'] as String,
      comment: map['comment'] as String,
      data: parsedData,
    );
  }
}









