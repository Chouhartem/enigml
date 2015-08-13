Enigml
======

Introduction
------------

Enigml est un simulateur d'enigma écrit en ocaml. Il va essayer d'être le plus
fonctionnel possible.

Build
-----

Pour construire le projet, il vous suffit de taper :

```
make
```

Configuration
-------------

La configuration se fait dans le fichier setup.ml où on indique la description
des rotors (Walze) dont on dispose, du réflecteur (Umkehrwalze) et de la table
de permutation (Steckerbrett).

Usage
-----

On appelle le simulateur à l’aide de:

```
./main.native
```

Et il ne vous reste plus qu’à taper votre texte.

Exemple:

```
$ ./main.native 
This is enigml, an enigma simulator written in ocaml.
Type your plaintext (avoid spaces even if they are supported)
> hallo 
Ciphertext: PBFXN
Decryption: HALLO
```
