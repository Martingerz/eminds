#Instrucciones para la compilación de volúmenes de e-Minds

##Introducción 

Este documento presenta una guía la preparación y compilación de los volúmenes de [e-Minds](http://www.eminds.hci-rg.com/index.php?journal=eminds). El sistema presenta las siguientes características:

* Se disponen de scripts para la automatización de la construcción del volumen.
* Los fuentes y los artefactos generados durante la construcción están totalmente separados.



##Entorno necesario

Para compilar el volumen de e-minds es necesario tener instalado:

* Una distribución de LaTeX actual.
* Tener disponible una instalación de Ruby que disponga de [Rake](http://rake.rubyforge.org/). Aquí hay [instrucciones sobre como instalar ruby en diferentes sitemas operativos](http://www.ruby-lang.org/es/downloads/).

## Código fuente

El código fuente de [e-Minds se encuentra disponible en google code](http://code.google.com/p/eminds/source/checkout). Para acceder a él se necesita un cliente de Subversion.

## Estructura de carpetas y archivos

A continuación se explica la estructura de carpetas y archivos esenciales del sistema

	/sources
		/instructions
			/core
				/images
			/files
		/volume
			/core
			/specific
	/lib
	/build
	/output
	
### Carpeta `sources/instructions`

Esta carpeta contiene el código fuente del sistema. Se divide en las carpetas:

* La carpeta `core`: contiene las fuentes de la revista. Las instructions en sí mismas están contenidas en el archivo `paper.tex`. También contiene una subcarpeta `images` con imágenes utilizadas para la preparación de las instructions.
* La carpeta `files`: contiene archivos que serán incluidos junto con las instructions, en el paquete entregable final.

Nótese que aunque las instrucciones para el autor hacen uso de la clase LaTeX del paper de e-Minds, el fuente original de la clase se encuentra en la carpeta `volume/core/emindspaper.cls`. Este archivo será copiado junto con los fuentes de las instrucciones automáticamente por los scripts.

### Carpeta `sources/volume/core`

Esta carpeta contiene las fuentes del sistema LaTeX del volumen. No contiene los archivos específicos de los papers que se incluyen en una compilación concreta, ni la publicidad, que irán en la carpeta `sources/volume/specific`.

Esta carpeta contiene las dos clases LaTeX esenciales del sistema de e-Minds.

* La clase `emindspaper.cls`. Define el formato de un artículo de e-Minds, así como los comandos disponiles por los autores de los mismos.
* La clase `emindsvolume.cls`. Extiende la clase `emindspaper.cls` con comandos específicos para la preparación del volumen.

La estructura de archivos se encuentra dividida en múltiples de forma modular, con el objetivo de facilitar el mantenimiento de los mismos. Estos archivos se van incluyendo unos a otros comenzando por el archivo `volume-master.tex`, que es archivo LaTeX maestro del volumen. A continuación se describen brevemente estos archivos:

* `volume-packages.tex`. Paquetes LaTeX específicos para el volumen.

* `paper-packages.tex`. Paquetes LaTeX de los papers. 

* `volume-data.tex`. Definición de variables a utilizar en el volumen. Aspectos tales como el ISBN de la revista, o los miembros que componen el equipo de e-Minds se definen aquí.

* `volume-primer.tex`. Este archivo contiene la definición del preámbulo del volumen. Contiene referencias a diferentes archivos que contienen los contenidos de dicho preámbulo.

	* `volume-firspage.tex`. La portada del volumen que aparece como primera página del mismo.
	
	* `volume-cover.tex`. La portada del volumen.

	* `volume-datapage.tex`. La página que incluye información oficial de la compilación, tal como el número de volumen o el ISSN. 
	
		* `volume-copyrigth.tex`. La declaración de copyright.
		
	* `volume-editorial.tex`. El editorial del número.
		
	* `volume-editor-board.tex`. La página con el comité de revisores de e-Minds. Este archivo incluye el contenido efectivo de dicho comité en el archivo `volume-scientific-panel` generado automáticamente por el sistema Web de e-Minds.
	
* `volume-papers.tex`. Este archivo incluye referencias a los papers específicos a un número concreto de e-Minds. Los contenidos a incluir se obtendrán típicamente de la carpeta `sources/volume/specific`.

### Carpeta `sources/volume/specific`

Contiene los archivos que son específicos a la compilación de un número concreto de e-Minds. Se divide a su vez en tres subcarpetas:

* `Adverts`: contiene los archivos relativos a la publicidad de la revista.

* `Logos`: contiene los logos de e-Minds y del HCI-RG, así como el logo de la portada del número concreto.

* `Papers`: contiene los artículos del número. Cada artículo va contenido en una carpeta. Se recomienza nombrar estas carpetas con el número asignado a los papers por el sistema de Journal Manager utilizado por e-Minds.

### Carpeta `build`

Esta carpeta es generada automáticamente por los scripts de e-Minds para preparar los archivos necesarios para la creación de los artefactos a partir de los procesos de compilación correspondientes.

### Carpeta `output`

Esta carpeta contendrá los entregables generados por los scripts:

* La carpeta `instructions` contendrá el archivo ZIP que contiene las instructions.
* La carpeta `volume` contendrá el PDF generado con el número del volumen, así como un ZIP con los archivos fuentes necesarios.

La nomenclatura de los artefactos generados hace uso de los datos relativos al volumen que son extraídos automáticamente del archivo `volume-data.tex` por los scripts de compilación.

### Carpeta `lib`

Librerías de apoyo a los scripts. Actualmente contiene el código necesario para analizar el archivo `volume-data.tex` y extraer la información necesaria para el nombrado adecuado de entregables.

## Preparación de entregables

Para la generación de los artefactos de e-Minds se recomienda hacer uso de los scripts Rake de los que se dispone. Utilizando estos scripts:

* Se puede tener totalmente separadas las fuentes de los entregables.
* No será necesario duplicar archivos cuándo éstos sean necesarios por varios entregables.
* Se evitarán errores derivados de la realización manual de tareas repetitivas.

El sistema rake incluye un sistema de ayuda para saber de qué tareas se dispone y una breve descripción de las mismas. Si se invoca en línea de comandos `rake -t` en la raíz del volumen:

	> rake -T
	
	rake clean                  # Remove any temporary products.
	rake clobber                # Remove any generated file.
	rake instructions:build     # Invoke latex compilation commands in order to...
	rake instructions:generate  # Generate the directory containing the instruc...
	rake instructions:prepare   # Prepare the instructions build directory
	rake volume:build           # Invoke latex compilation commands in order to...
	rake volume:generate        # Generate the volume final PDF file
	rake volume:prepare         # Prepare the volume build directory

Las fuentes del sistema de scripts Rake comprenden un fichero `Rakefile` que se encuentra en la raíz del volumen y un conjunto de archivos `Rakefile.rb` distribuidos en las respectivas fuentes de las instructions y del volumen.

Los comandos `clean` y `clobber` son genéricos de Rake. El primero elimina los archivos temporales generados durante la construcción (carpeta `build`) y el segundo borra tanto los archivos temporales como los entregables (carpetas `build` y `output`).

Los siguientes comandos son los relativos a la compilación de las instrucciones y del volumen. Los espacios de nombres `instructions` y `volume` definen para qué artefacto se realizan las siguientes acciones:

* `prepare`. Copia los fuentes necesarios en la carpeta `build` (el destino será la subcarpeta `build/instructions` o `build/volume` dependiendo del caso).
* `build`. Ejecuta los comandos de construcción LaTeX.
* `generate`. Genera los entregables correspondientes.

Unas tareas dependen de otras de tal forma que si se invoca una tarea se invocan las dependientes. En concreto: `generate => build => prepare`.

### Preparación de las *Instructions for authors*

Para modificar el contenido de las instrucciones se modificará el archivo `sources/instructions/core/paper.tex`.

Para generar las instrucciones se invocará el comando:

	> rake instructions:generate
	
Una vez generado el archivo ZIP correspondiente se encontrará en la carpeta `output/instructions`.

### Preparación del volumen

Para la preparación del volumen conviene tener clara la estructura de archivos descrita en la sección anterior.

En primer lugar, habrá que modificar los archivos que contienen aspectos específicos del volumen, dentro de la carpeta `sources/volume/core`. Los archivos más relevantes para cada número son:

* Los datos del volumen en `volume-datapage.tex`.
* El panel editorial en `volume-scientific-panel.tex`.
* El editorial del número en `volume-editorial.tex`.
* Así mismo, hay que actualizar el logo de la portada del número que se encuentra en el archivo `sources/volume/secific/Logos`.

En segundo lugar, hay que preparar la página que contiene la estructura esencial de contenidos del volumen. Esta labor se realiza modificando el archivo `volume-papers.tex`.

Para incluir papers en el volumen se utilizará el comando `\inputpaper{carpeta del paper}`. Por ejemplo:

	\inputPaper{Papers/58}

Este comando incluye el paper contenido del artículo en el directorio `58` de la carpeta `sources/volume/specific/Papers/`.

Para la publicidad, se hará uso del parámetro opcional del comando `\inputpaper[ruta al archivo de publicidad]{carpeta del paper}`. Por ejemplo:

	\inputPaper[Adverts/PCTI.pdf]{Papers/58}
	
Al igual que el anterior, este comando incluye el paper 58 y, además, inserta **antes** el archivo de publicidad `PCTI.pdf` que se encuentra en la carpeta `sources/volume/specific/Averts/`.

Para la preparación del volumen se recomienda ir incluyendo y compilando los papers uno a uno, para ir detectando posibles problemas de forma incremental. Durante esta compilación incremental, se puede ir haciendo uso del comando:

	> rake volume:build
	
Para la generación de los entregables del volumen (PDF final y ZIP con los fuentes) se hará uso del comando:

	> rake volume:generate
	

