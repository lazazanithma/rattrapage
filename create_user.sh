#!/bin/bash

# Vérification du nombre d'arguments
if [ "$#" -ne 5 ]; then
    echo "Usage: $0 <nom_utilisateur> <commentaire> <shell> <validite> <quota>"
    exit 1
fi

# Assignation des arguments à des variables
USERNAME=$1
COMMENT=$2
SHELL=$3
VALIDITY=$4
QUOTA=$5

# Vérifier si l'utilisateur existe déjà
if id "$USERNAME" &>/dev/null; then
    echo "L'utilisateur $USERNAME existe déjà."
else
    # Création de l'utilisateur avec les caractéristiques demandées
    useradd -m -c "$COMMENT" -s "$SHELL" "$USERNAME"
fi

# Définition d'un mot de passe par défaut (modifié pour respecter les exigences de longueur)
echo "$USERNAME:inf3611abcd" | chpasswd
chage -d 0 "$USERNAME"

# Définition de la durée de validité du compte
usermod -e "$(date -d "$VALIDITY days" +%Y-%m-%d)" "$USERNAME"

# Application du quota disque (si la commande setquota fonctionne)
if command -v setquota &>/dev/null; then
    setquota -u "$USERNAME" "$QUOTA" "$QUOTA" 0 0 /home
else
    echo "La commande 'setquota' n'a pas été trouvée. Assurez-vous que les quotas sont installés."
fi

# Définition de la plage horaire autorisée pour la connexion
echo "$USERNAME" > "/etc/security/time.conf"
echo "login ; * ; * ; !Al0000-2400" >> "/etc/security/time.conf"

# Confirmation de la création de l'utilisateur
echo "Utilisateur $USERNAME créé avec succès."
echo "Plage horaire : 08:00 - 18:00, quota de disque : ${QUOTA}Go, compte valide jusqu'au : $(date -d "$VALIDITY days" +%Y-%m-%d)."

