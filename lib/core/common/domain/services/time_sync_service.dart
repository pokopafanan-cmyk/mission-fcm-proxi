import 'package:ntp/ntp.dart';

/// Service chargé de fournir une heure fiable et cohérente
/// dans toute l'application.
///
/// Principe :
/// - Synchronisation initiale via NTP
/// - Mise en cache de l'heure NTP
/// - Avancement du temps via Stopwatch (évite les appels réseau fréquents)
/// - Fallback automatique sur l'heure système si NTP échoue
class TimeSyncService {

  TimeSyncService();

  /// Intervalle maximal avant une re-synchronisation NTP, (évite la dérive sur les longues sessions)
  static const Duration _resyncInterval = Duration(hours: 1);

  /// Dernière heure NTP connue
  DateTime? _cachedNtpTime;

  /// Stopwatch utilisé pour calculer le temps écoulé depuis la dernière synchronisation
  final Stopwatch _stopwatch = Stopwatch();

  /// État actuel de la synchronisation
  SyncStatus _status = SyncStatus.notSynced;

  /// Dernière date de synchronisation réussie
  DateTime? _lastSyncTime;

  /// Synchronise l'heure locale avec un serveur NTP.
  ///
  /// À appeler :
  /// - au démarrage de l'application
  /// - lors d'un retour en ligne
  ///
  /// Retourne `true` si la synchronisation réussit.
  Future<bool> synchronize() async {
    try {
      _status = SyncStatus.syncing;

      // Récupération de l'heure NTP (UTC)
      final ntpTime = await NTP.now();

      // Mise en cache
      _cachedNtpTime = ntpTime.toUtc();
      _lastSyncTime = _cachedNtpTime;

      // Redémarrage du stopwatch
      _stopwatch
        ..reset()
        ..start();

      _status = SyncStatus.synced;
      return true;
    } catch (_) {
      // En cas d'échec NTP :
      // on fallback sur l'heure système (UTC)
      _cachedNtpTime = DateTime.now().toUtc();
      _lastSyncTime = _cachedNtpTime;

      _stopwatch
        ..reset()
        ..start();

      _status = SyncStatus.failed;
      return false;
    }
  }


  /// Retourne l'heure actuelle fiable.
  ///
  /// - Si NTP est synchronisé → heure NTP + elapsed
  /// - Sinon → heure système UTC
  ///
  /// Cette méthode NE bloque PAS et NE fait PAS de réseau.
  DateTime now() {
    if (_cachedNtpTime == null || !_stopwatch.isRunning) {
      return DateTime.now().toUtc();
    }

    // Si le temps écoulé depuis la dernière sync est trop long, on recommande une re-synchronisation (non bloquante)
    if (_shouldResync()) {
      _triggerResync();
    }

    // Heure calculée = heure NTP + temps écoulé
    return _cachedNtpTime!.add(_stopwatch.elapsed).toUtc();
  }

  /// Retourne un timestamp compact au format : YYYYMMDDHHmmss
  String timestamp() {
    return _formatTimestamp(now());
  }

  /// Timestamp local (sans NTP), Utile uniquement pour le logging
  String get localTimestamp {
    return _formatTimestamp(DateTime.now().toUtc());
  }

  /// Retourne l'état actuel de la synchronisation du temps.
  SyncStatus get status => _status;

  /// Indique si l'heure est actuellement synchronisée avec NTP. Retourne `true` uniquement si la dernière synchronisation NTP a réussi.
  bool get isSynced => _status == SyncStatus.synced;

  /// Date et heure de la dernière synchronisation réussie. Retourne `null` si aucune synchronisation n'a encore été effectuée.
  DateTime? get lastSyncTime => _lastSyncTime;


  /// Indique si une nouvelle synchronisation est recommandée
  bool _shouldResync() {
    return _stopwatch.elapsed > _resyncInterval;
  }

  /// Déclenche une re-synchronisation sans bloquer l'appelant.
  void _triggerResync() {
    synchronize();
  }

  /// Formatte un DateTime en timestamp compact
  String _formatTimestamp(DateTime dateTime) {
    final y = dateTime.year.toString().padLeft(4, '0');
    final m = dateTime.month.toString().padLeft(2, '0');
    final d = dateTime.day.toString().padLeft(2, '0');
    final h = dateTime.hour.toString().padLeft(2, '0');
    final min = dateTime.minute.toString().padLeft(2, '0');
    final s = dateTime.second.toString().padLeft(2, '0');

    return '$y$m$d$h$min$s';
  }


  // Future<String> getTimestamp() async {
  //
  //   const timeSources = [
  //     'https://sycelim.net/gmt_date.php',
  //     'https://timezone.abstractapi.com/v1/current_time/?api_key=0916541e54d74a68a2a2f6a604ded468&location=Africa/Abidjan',
  //   ];
  //
  //   for (final url in timeSources) {
  //     try {
  //       final response = await http.get(Uri.parse(url));
  //       if (response.statusCode == 200) {
  //         final data = json.decode(response.body);
  //         final timestamp = data['datetime'] as String;
  //         return timestamp.replaceAll(' ', '').replaceAll('-', '').replaceAll(':', '');
  //       }
  //     } catch (e) {
  //       continue; // Essayer la source suivante
  //     }
  //   }
  //
  //   // Fallback: utiliser l'heure locale
  //   return _formatTimestamp(DateTime.now().toUtc());
  // }

}

/// État de la synchronisation temporelle
enum SyncStatus {
  notSynced,
  syncing,
  synced,
  failed,
}





