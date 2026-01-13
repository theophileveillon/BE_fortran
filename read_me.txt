toutes les experiences suvantes sont avec 
U0 = C0 = 1 imposé
Tf = 6000 -> on a prit le Tf max pour eviter tout probleme lié au effet de bord en x = L
L = 10000 imposé

dossier_1
Nt = 600 -> delta_t = 10
Nx = 100 -> delta_x = 100
Nx trop faible donc diffusion numerique

dossier 2
Nt = 600 -> delta_t = 10
Nx = 1000 -> delta_x = 10
solution parfaite,les solution se superpose exactement

dossier 3
Nt = 600 -> delta_t = 10
Nx = 1500 -> delta_x = 15
delta_x > delta_t on a des probleme de discretisation trop faible

dossier 4
gamma de 1 aberation au bord car delta_x_irreg << delta_t 
Nt = 600
Nx =1000
on remarque que l'erreur ne se propage pas au centre (etrange)

dossier 5
gamma de -1 aberation au milieu car delta_x_irreg << delta_t 
Nt = 600
Nx =1000
l'aberation se propage jusqu'a faire planter le programe
