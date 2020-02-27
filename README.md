# Drupal project template for Platform.sh

This project provides a starter kit for Drupal 8 projects hosted on [Platform.sh](http://platform.sh). It
is very closely based on the [Drupal Composer project](https://github.com/drupal-composer/drupal-project).

## Starting a new project

To start a new Drupal 8 project on Platform.sh, you have 2 options:

1. Create a new project through the Platform.sh user interface and select "start
   new project from a template".  Then select Drupal 8 as the template. That will
   create a new project using this repository as a starting point.

2. Take an existing project, add the necessary Platform.sh files, and push it
   to a Platform.sh Git repository. This template includes examples of how to
   set up a Drupal 8 site.  (See the "differences" section below.)

## Using as a reference

You can also use this repository as a reference for your own Drupal projects, and borrow whatever code is needed.  The most important parts are the [`.platform.app.yaml`](/.platform.app.yaml) file and the [`.platform`](/.platform) directory.

Also see:

* [`settings.php`](/web/sites/default/settings.php) - The customized `settings.php` file works for both Platform.sh and local development, setting only those values that are needed in both.  You can add additional values as documented in `default.settings.php` as desired.
* [`settings.platformsh.php`](/web/sites/default/settings.platformsh.php) - This file contains Platform.sh-specific code to map environment variables into Drupal configuration.  You can add to it as needed.  See [the documentation](https://docs.platform.sh/frameworks/drupal8.html) for more examples of common snippets to include here.
* [`scripts/platformsh`](/scripts/platformsh) - This directory contains our update script to keep this repository in sync with the Drupal Composer project.  It may be safely ignored or removed.

## Managing a Drupal site built with Composer

Nothing is easier than managing a Composer-based Drupal site on Platform.sh. See [Drupal 8 and Composer](https://docs.platform.sh/frameworks/drupal8.html) for details. For example adding a single module to your Drupal installation is as simple as:

```sh
composer require drupal/devel
git commit -am 'Add the Devel module'
git push
```

## How does this starter kit differ from vanilla Drupal from Drupal.org?

1. The `vendor` directory (where non-Drupal code lives) and the `config` directory
   (used for syncing configuration from development to production) are outside
   the web root. This is a bit more secure as those files are now not web-accessible.

2. The `settings.php` and `settings.platformsh.php` files are provided by
   default. The `settings.platformsh.php` file automatically sets up the database connection on Platform.sh, and allows controlling Drupal configuration from environment variables.


# git-test
Proyecto de prueba con git, aqui se puede probar todos los comandos y modificaciones (Área de prueba)
Este es un proyecto de prueba con git, para probar comandos y codigo.


Working directory --(git add)--> Staging area --(git commit)--> Repository*

# GIT COMMANS
1. git init   -> Se le dice a git que se va a iniciar un proyecto nuevo
2. git add (nombre archivo) -> Pasar archivos del working a staging area (listo a subir)
3. git status -> Para ver como estan los archivos (Si estan listos para subir a no)
4. git commit ->  Pasar al repositorio, como una primera foto del codigo en git
5. git commit -m "Mensaje de version" -> Esta es una forma mas rapido de guardar un commit
6. git push -u origin master   -> Subir al servidor para los demas desarrolladores
7. git pull   -> Bajar lo que hicieron otros
8. git clone  -> Clonar un proyecto
9. git checkout -- index.html -> deshace los cambios guardados en el sublime. siempre que no tenga commit.

10. git checkout (nombre de la rama que deseamos) -> este es para cambiar entre ramas
11. git log -> Muestra todas las versiones o commits
12. git remote rm destination -> Elimina repositorio remoto del proyecto local.
13. git remote -v destination -> Muestra los repositorios remotos actuales en este proyecto.
12. git remote add origin <ssh direction> -> Agrega repsositorio remoto al proyecto local.

* Si creo el archivo (.gitignore) y en el escribo los archivos y carpetas que quiero que git ignore. Nota: Solo basta con escribir el nombre del archivo o la carpeta
# HASTA AQUI GIT CODIGO Y PASAMOS A GITHUB
Es necesario sincronizar el codigo de proyecto con github. En la seccion repository se crea un repositorio nuevo.
1) Despues en la consola local se escribe:

# git remote add origin <codigo ssh del proyecto>
--->Ejem: git remote add origin git@github.com:movix86/git-test.git

2) Despues se sincrinoza la rama master local con la remota:
# git push -u origin master


