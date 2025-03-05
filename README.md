# 🗺️ FindMe – Localizzazione e Meteo in Tempo Reale 🌍

FindMe è un'app iOS che combina localizzazione avanzata con CoreLocation, API di meteo. 🎯

## 🚀 Tecnologie utilizzate:

-  <b>Alamofire</b> per le chiamate API efficienti
-  <b>CoreLocation</b> per la geolocalizzazione dell'utente
-  <b>MapKit</b> per la visualizzazione su mappa
-  <b>MVVM</b> (Model-View-ViewModel) per un'architettura pulita e scalabile
-  <b>Codable</b> & Decodable per la gestione dei dati JSON

## 🔑 Permessi Richiesti

Aggiungi queste chiavi nel `Info.plist` per permettere all'app di accedere alla localizzazione:

```
<key>NSLocationWhenInUseUsageDescription</key>
<string>FindMe usa la tua posizione per mostrarti il meteo e la tua posizione sulla mappa.</string>
```