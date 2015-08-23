Enigml
======

Introduction
------------

Enigml est un simulateur d'enigma écrit en ocaml. Il va essayer d'être le plus
fonctionnel possible.

L’utilisation du module `Arg` rend cependant certaines partie du code
impératives (en dehors de l’interface dans `main.ml`)

Build
-----

Pour construire le projet, il vous suffit de taper :
```bash
make
```

Configuration
-------------

Pour ajouter des machines, cela se passe dans machinen.ml. Vous pouvez vous
inspirer des machines déjà présentes et vous référez à enigml.mli pour mieux
comprendre l’interface.

**protip**: pour générer de la documentation au format html pour le module
principal `Enigml`, il vous suffit de taper:
```bash
mkdir doc
cd doc
ocamldoc -html ../enigml.mli
```
La documentation se trouvera alors dans le dossier `doc/`

Usage
-----

On appelle le simulateur à l’aide de:
```bash
./main.native [-m machine] rotor1_index rotor1_position rotor2_index rotor2_position rotor3_index rotor3_position reflector_index permutation_table

```

Et il ne vous reste plus qu’à taper votre texte (possiblement multiligne).

Exemple:
```
$ ./main.native -m m3 1 K 0 V 2 P 1 AX QV NK DU BL
Hallo
GMIUN
Hallo
NZNJJ
$ ./main.native -m m3 1 K 0 V 2 P 1 AX QV NK DU BL
GMIUN
HALLO
NZNJJ
HALLO
```
