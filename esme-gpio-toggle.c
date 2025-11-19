#include <gpiod.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>     
#include <string.h> 

// GPIO par défaut si aucun argument n'est donné
#define DEFAULT_GPIO 26

// Le chip GPIO utilisé sur Raspberry Pi (toujours gpiochip0)
#define GPIO_CHIP "/dev/gpiochip0"

int main(int argc, char *argv[])
{
    int gpio_number = DEFAULT_GPIO;
    int value = 0;   // Valeur envoyée à la LED (0 ou 1)

    // Lire les arguments 
    if (argc == 3 && strcmp(argv[1], "--gpio") == 0) {
        gpio_number = atoi(argv[2]);   // Convertir en entier
    }

    printf("GPIO utilisée : %d\n", gpio_number);

    // Ouvrir le chip GPIO
    struct gpiod_chip *chip = gpiod_chip_open(GPIO_CHIP);
    if (!chip) {
        printf("Erreur : impossible d'ouvrir %s\n", GPIO_CHIP);
        return 1;
    }


    // Récupérer la ligne passé dans le terminal
    struct gpiod_line *line = gpiod_chip_get_line(chip, gpio_number);
    if (!line) {
        printf("Erreur : impossible d'accéder à la GPIO %d\n", gpio_number);
        gpiod_chip_close(chip);
        return 1;
    }

    // Demander la GPIO en sortie
    if (gpiod_line_request_output(line, "esme-gpio-toggle", 0) < 0) {
        printf("Erreur : impossible de configurer la GPIO en sortie.\n");
        gpiod_line_release(line);
        gpiod_chip_close(chip);
        return 1;
    }

    // Faire clignoter la led toutes les secondes
    while (1) {
        value = !value;  // Inverser la valeur 
        gpiod_line_set_value(line, value);
        printf("GPIO %d = %d\n", gpio_number, value);
        sleep(1); // Attendre une seconde
    }
    
    return 0;
}
