# Segregacja plików
Prosty skrypt segregujący pliki po dacie utworzenia. Sensowne zastosowanie ma w przypadku dużej ilości plików o losowych nazwach, np. zdjęć na karcie pamięci lub logów serwera;

## TODO
1. Generowanie katalogów
2. Zmiana nazw plików na daty.
3. 

## Input
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

## Output

    > tree
    .
    └── photos
        ├── 2011
        │   ├── DSM_0221.jpg
        │   ├── DSM_0032.jpg
        ├── 2012
        │   ├── DSM_0403.jpg
        │   ├── DSM_0004.jpg
        │   ├── DSM_0125.jpg
        ├── 2013
        │   ├── DSM_3346.jpg
    4 directories, 8 files

## Uruchamianie

## Dodatkowe opcje
