Enigml
======

Introduction
------------

Enigml est un simulateur d'enigma écrit en ocaml. Il va essayer d'être le plus
fonctionnel possible.

L’utilisation du module `Arg` rend cependant certaines partie du code
impératives (en dehors de l’interface dans `main.ml`)

**Mise en garde :** N’utilisez jamais ce logiciel ou une variante d’enigma pour
protéger des données sensibles.

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
./main.native [-m machine] 012 ABC 3 ZY XV [-p DEF]
```
Où 012 représente l’ordre des rotors (les indices débutent à 0).  
ABC représente l’état initial des rotors.  
3 représente l’indice du réflecteur.  
ZY, XV représentent la table de permutation.

Pour les options, vous pouvez spécifier une machine (`-m`) et un mot de passe de
session (`-p`).

L’entrée (possiblement multiligne) est lue à partire de `stdin`.

Exemple:
```
$ ./main.native -m m3 213 KVP 1 AX QV NK DU BL
Hallo
GMIUN
Hallo
NZNJJ
$ ./main.native -m m3 213 KVP 1 AX QV NK DU BL
GMIUN
HALLO
NZNJJ
HALLO
```
