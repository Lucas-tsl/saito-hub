#!/usr/bin/env bash
# Recopie hub/ dans includes/saito-hub/ de chaque plugin Saito, avec le text
# domain du plugin (Plugin Check exige le text domain du plugin dans chaque
# fichier embarqué).
#
#   bin/sync.sh            tous les plugins de la liste ci-dessous
#   bin/sync.sh saito-faq  un seul (slug = text domain)
set -euo pipefail
HUB="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/hub"

# slug (= text domain)  dossier du dépôt
PLUGINS="
saito-navi            $HOME/navi-wordpress
saito-faq             $HOME/navi-faq
saito-calendar-event  $HOME/saito-calendar-event
saito-store-locator   $HOME/saito-store-locator
saito-mini-cart       $HOME/saito-mini-cart
"

echo "$PLUGINS" | while read -r slug repo; do
	[ -n "$slug" ] || continue
	if [ $# -gt 0 ] && [[ " $* " != *" $slug "* ]]; then continue; fi
	dest="$repo/includes/saito-hub"
	mkdir -p "$dest"
	rsync -a --delete "$HUB/" "$dest/"
	find "$dest" -name '*.php' -exec sed -i "s/'saito-hub' )/'$slug' )/g" {} +
	echo "==> $slug : $(find "$dest" -type f | wc -l) fichiers dans ${dest#$HOME/}"
done
