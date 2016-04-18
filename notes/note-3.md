# Hvordan finne extent?

- Spørre tjenesten ved hjelp av GetCapabilities-kall:
```http
http://openwms.statkart.no/skwms1/wms.topo2?request=GetCapabilities&Service=WMS
```

- Hente ut koordinater for BoundingBox:
```markup
<BoundingBox CRS="EPSG:32633" minx="-127998" miny="6.37792e+06" maxx="1.14551e+06" maxy="7.9768e+06"/>
```


- Skrevet som en javascript-variabel:
```javascript
var extentKartverketWMS32633 = [-127998, 6377920, 1145510, 7976800]
```

- Transformert til EUREF89 - UTM32 ved hjelp av funksjoner på http://norgeskart.no
```javascript
[234067.747, 6338450.05, 1351516.4, 8051673.295]
```

- Avrundet og skrevet som javascript-variabel:
```javascript
var extentKartverketWMS25832 = [234068, 6338450, 1351516, 8051673]
```

- Hvor stort blir dette?
```code
utstrekning øst-vest: 1351516 - 234068 = 1117448 (1117 km)
utstrekning nord-sør: 8051673 - 6338450 = 1713223 (1713 km)
```