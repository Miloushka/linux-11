# Dossier d'installation par défault 
INSTALL_DIR ?= ./.install

# Nom du binaire
TARGET = esme-gpio-toggle

# Liste des fichiers objets
OBJS = esme-gpio-toggle.o

# Options de compilation générales (on ajoute, on ne remplace pas)
CFLAGS += $(shell pkg-config --cflags libgpiod )
LDLIBS += $(shell pkg-config --libs libgpiod )

# Compilation du programme
$(TARGET): $(OBJS)

# Cible d'installation
install: esme-gpio-toggle
	mkdir -p $(INSTALL_DIR)/etc/init.d
	mkdir -p $(INSTALL_DIR)/usr/bin

	# Installer le binaire
	cp esme-gpio-toggle $(INSTALL_DIR)/usr/bin/
	chmod 0755 $(INSTALL_DIR)/usr/bin/esme-gpio-toggle

	# Installer le script d'init
	cp esme-gpio26-toggle $(INSTALL_DIR)/etc/init.d/esme-gpio26-toggle
	chmod 0755 $(INSTALL_DIR)/etc/init.d/esme-gpio26-toggle


# Nettoyage des fichiers générés
clean:
	$(RM) $(OBJS)
