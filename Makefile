# Dossier d'installation par défault 
INSTALL_DIR ?= ./.install

# Options de compilation générales (on ajoute, on ne remplace pas)
CFLAGS += -Wall -Wextra -O2
CFLAGS += $(shell pkg-config --cflags libgpiod )
LDLIBS += $(shell pkg-config --libs libgpiod )

# Construit le programme esme-gpio-toggle
esme-gpio-toggle: esme-gpio-toggle.o

# Cible d'installation
install: esme-gpio-toggle
	mkdir -p $(INSTALL_DIR)/usr/bin
	cp esme-gpio-toggle $(INSTALL_DIR)/usr/bin/

# Nettoyage des fichiers générés
clean:
	$(RM) esme-gpio-toggle *.o
