#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import matplotlib.pyplot as plt
import numpy as np
import os

# NOMBRE D'ELEMENTS PAR TABLEAU
nb_elements = 1000

# Création du dossier pour les images
os.makedirs("dossier_2", exist_ok=True)

# Initialisation des tableaux
x = np.zeros(nb_elements)
y = np.zeros(nb_elements)
z = np.zeros(nb_elements)
line_count = 0
j = 0

with open("res.csv", "r") as my_file:
    for line in my_file:
        values = line.strip().split()
        if len(values) < 2:
            continue  # ignore les lignes vides ou mal formées

        x[line_count] = float(values[0])
        y[line_count] = float(values[1])
        z[line_count] = float(values[2])  # ou z[line_count] = valeur théorique

        line_count += 1

        # Quand un tableau complet est lu, on trace
        if line_count == nb_elements:
            line_count = 0
            j += 1
            plt.figure()
            plt.title("Evolution")
            plt.xlim(0., 10000.)
            plt.ylim(0., 1.)
            plt.xlabel('x (m)', fontsize=16)
            plt.ylabel('concentration', fontsize=16)
            plt.plot(x, y, 'b--o', linewidth=1.0, label='concentration_numerique')
            plt.plot(x, z, 'r--o', linewidth=1.0, label='concentration_verifie')
            plt.legend()
            # Sauvegarde de l'image
            plt.savefig(f"dossier_2/{10000+j}.png")
            plt.close()

print("Génération des images terminée.")
