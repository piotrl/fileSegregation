# Segregacja plików
Prosty skrypt segregujący pliki po dacie utworzenia. Sensowne zastosowanie ma w przypadku dużej ilości plików o losowych nazwach, np. zdjęć na karcie pamięci lub logów serwera;

Domyślnie, segreguje katalogi wewnątrz wybranego katalogu, nie uwzględniając podkatalogów.
Domyślna segregacja kopiuje pliki do nowych katalogów, nie naruszając oryginałów.

## TODO
1. Dokumentacja funkcji (w komentarzach)

### Before
	> tree
	.
	└── photos
		├── DSM_0110.jpg
		├── DSM_0221.jpg
		├── DSM_0032.jpg
		├── DSM_0403.jpg
		├── DSM_0004.jpg
		├── DSM_0125.jpg
		├── DSM_3346.jpg
	1 directory, 8 files

### After

	> tree
	.
	└── photos
		├── 2011
		│   ├── 11
		│   │  ├── DSM_1245.jpg
		│   ├── DSM_0032.jpg
		├── 2012
		│   ├── DSM_0403.jpg
		│   ├── DSM_0004.jpg
		│   ├── DSM_0125.jpg
		├── 2013
		│   ├── DSM_3346.jpg
	5 directories, 8 files

## Uruchamianie
	bash fseg.sh [OPCJA] [KATALOG_DO_SEGREGACJI] [NAZWA_KATALOGU_WYJSCIOWEGO]

## Dodatkowe opcje
	-b : tworzy backup posegregowanych plików
	-d : segreguje również po dniu ostatniej modyfikacji
	-m : przenosi segregowane pliki (zamiast tylko kopiować)
	-r : segreguje pliki w podkatalogach
