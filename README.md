# 🚀 Projet VHDL – Microprocesseur / CPU simple

<p align="right">
  <a href="./LICENSE">
    <img src="https://img.shields.io/badge/License-MIT-blue.svg" alt="License: MIT">
  </a>
  <img src="https://img.shields.io/badge/HDL-VHDL-purple.svg" alt="VHDL">
  <img src="https://img.shields.io/badge/Status-Academic%20Project-success.svg" alt="Status: Academic Project">
</p>

Implémentation d’un microprocesseur simple en **VHDL**, réalisée dans le cadre d’un projet académique en architecture des systèmes numériques / systèmes embarqués.

L’objectif est de :
- modéliser une **architecture processeur à accumulateur (ACC)**,
- comprendre le rôle de chaque bloc (ALU, PC, mémoire, unité de contrôle, datapath),
- simuler et valider le comportement du CPU via un **testbench VHDL**.

---

## 📌 Aperçu du projet

- **Type d’architecture** : processeur simple à accumulateur (ACC)
C’est un microprocesseur avec un bus de données sur 16 bits et un bus d’adresses sur 12 bits.
Le chemin de données doit comprendre au minimum :
- un registre compteur programme (PC) : un registre stockant l’adresse de la prochaine
instruction à exécuter.
- un registre accumulateur (ACC) : un registre stockant la donnée sur laquelle on travaille.
- une UAL qui permet d’exécuter des opérations arithmétiques et logiques de base (addition,
soustraction, ET/OU/OUX logique)…

Ce projet peut servir :
- de **base pédagogique** pour comprendre les processeurs,
- de **point de départ** pour des architectures plus avancées (pile, interruptions, pipeline, etc.).

---

## 🧠 Architecture du processeur

### Vue globale

Le CPU est composé de plusieurs blocs principaux :

- **ALU** : effectue les opérations arithmétiques et logiques
- **ACC (Accumulateur)** : registre principal pour les opérations, renvoie les flags `accZ` et `acc15`
- **PC (Program Counter)** : contient l’adresse de l’instruction courante
- **IR (Instruction Register)** : contient l’instruction en cours (opcode + adresse)
- **Mémoire** : stocke instructions et données
- **Unité de contrôle (machine d’état)** : génère les signaux de contrôle à partir de l’instruction et des flags
- **Datapath** : relie tous les blocs via les bus, multiplexeurs et tri-state

### 📷 **Diagramme d’architecture globale**
 <img width="1090" height="523" alt="image" src="https://github.com/user-attachments/assets/b015d52b-db6b-4529-80da-7e94c04d9648" />


## Format des instructions

Chaque instruction est codée sur 16 bits et comprend :

- **4 bits** : code opération (opcode)
- **12 bits** : adresse opérande en mémoire

L’ACC joue le rôle d’opérande implicite, ce qui en fait une **machine une adresse**.

<img width="928" height="253" alt="image" src="https://github.com/user-attachments/assets/37e74f0a-c8a6-4206-a0ad-e05c358909d2" />

## Jeu d’instructions

<img width="1279" height="661" alt="image" src="https://github.com/user-attachments/assets/0a2e7527-31d6-43b5-9ac3-b99f61166d0f" />

## Unité Arithmétique et Logique (UAL)

L’UAL prend en entrée deux opérandes A et B (issus du datapath via MUXA/MUXB) et un code fonction alufs.
<img width="470" height="376" alt="image" src="https://github.com/user-attachments/assets/810fe9f2-3a61-4a13-b4dc-212d47f02612" />

---
## 💾 Exemple de programme en mémoire

```markdown
0  => x"0100", -- LDA @100h : charger mem16[100h] dans ACC
1  => x"3101", -- SUB @101h : ACC ← ACC - mem16[101h]
2  => x"5004", -- JGE @004h : si ACC ≥ 0, saut à l'adresse 004h
3  => x"7000", -- STP       : arrêt du processeur
4  => x"1100", -- (exemple supplémentaire)
others => x"0000";
```

Ce programme illustre :
- l’utilisation de l’accumulateur comme opérande implicite ;
- la mise à jour des flags et l’utilisation de JGE ;
- le mécanisme de branchement via PC.
