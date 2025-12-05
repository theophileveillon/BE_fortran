Nom du programme : lecture_fichier_n_images

Date de création : 20/20/20

Auteur : Thomas Bonometti

Objectif : Programme (en python) de generation d'une série d'images "10001.png", "10002.png", etc, stockées dans un dossier "/img" a partir d'un fichier "res.csv" contenant deux colonnes de donnees

Fichier d'entrée: "res.csv"

Fichiers résultats : "/img/10001.png", "/img/10002.png", etc,

Pour exécuter le programme : 

1. modifier la ligne 9 du fichier "lecture_fichier_n_images", pour indiquer le nombre d'elements des tableaux individuels (ex.:"nb_elements = 30")
2. dans un terminal, à l'endroit où se trouve les fichiers "lecture_fichier_n_images" et "res.csv", taper:
python3 lecture_fichier_n_images.py

Pour créer une vidéo à partir de la série d'image:

Option 1:
# pour creer la video sous linux a partir des images avec ffmpeg
# Dans un terminal, à l'endroit où se trouve les images "/img/10001.png", "/img/10002.png", etc, taper:
ffmpeg -r 6 -f image2 -s 800x600 -i 1%04d.png -vcodec libx264 -crf 25 -pix_fmt yuv420p output_ffmpeg.mp4

Option 2:
# pour creer la video sous linux a partir des images avec mencoder
# Dans un terminal, à l'endroit où se trouve les images "/img/10001.png", "/img/10002.png", etc, taper:
mencoder mf://\*.png -mf w=800:h=600:fps=6:type=png -ovc lavc -lavcopts vcodec=mpeg4 -oac copy -o output.avi

