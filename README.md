# Script de création d'utilisateur avec paramètres personnalisés

Ce script Bash permet de créer un utilisateur avec des caractéristiques spécifiques, telles que le mot de passe par défaut, la durée de validité du compte, la gestion des quotas disque, et la restriction de la plage horaire de connexion.

## Prérequis

Le script doit être exécuté en tant qu'utilisateur root ou avec des privilèges sudo. Assurez-vous également que la gestion des quotas disque est activée sur votre système.

## Utilisation

Le script accepte les paramètres suivants, passés dans cet ordre :

```bash
./create_user.sh <nom_utilisateur> <commentaire> <shell> <validite> <quota>
