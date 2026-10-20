# Saito Hub

Menu « Saito » commun aux plugins WordPress Saito (Navi, FAQ, Calendar Event, Store Locator, et les suivants).

- **Saito > Tableau de bord** : les plugins Saito, installés ou non.
- **Un sous-menu par plugin actif**, ajouté par le plugin lui-même.
- **Saito > Outils** : CSS et JavaScript additionnels du site.
- **Saito > Documentation** : code source, documentation, Notion, WordPress.org.

## Fonctionnement

Ce n'est pas un plugin : `hub/` est embarqué dans chaque plugin Saito (`includes/saito-hub/`). Chaque copie déclare sa version (`hub/load.php`) ; sur `plugins_loaded`, seule la plus récente est chargée. Le menu existe dès qu'un plugin Saito est actif.

## Mettre à jour

1. Modifier `hub/` ici, et augmenter la version dans `hub/load.php` (`saito_hub_register_version( 'x.y.z', … )`).
2. `bin/sync.sh` recopie `hub/` dans chaque plugin, avec son text domain.
3. Publier une version de **chaque** plugin : le hub le plus récent l'emporte sur un site où plusieurs plugins Saito sont installés.

## Ajouter un plugin Saito

1. L'ajouter au catalogue (`saito_hub_catalog()` dans `hub/hub.php`) et à la liste de `bin/sync.sh`.
2. Dans le plugin : `require_once …/includes/saito-hub/load.php;`, déclarer le plugin via le filtre `saito_hub_plugins` (`version`, `settings_url`, `menu_slugs`), ajouter ses pages avec `add_submenu_page( saito_hub_menu_slug(), … )`, et `require __DIR__ . '/includes/saito-hub/uninstall.php';` dans son `uninstall.php`.
