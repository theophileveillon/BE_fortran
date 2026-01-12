FC = gfortran
OPT = -g -O0 -fbounds-check

OBJ = type.o main.o sousprog.o

run: main.exe
	./main.exe
	python3 lecture_fichier_n_images_theo.py

main.exe:	$(OBJ)
	$(FC) $(OPT) $(OBJ) -o main.exe

type.o:	type.f90
	$(FC) $(OPT) type.f90 -c

main.o:	main.f90
	$(FC) $(OPT) main.f90 -c

sousprog.o:	sousprog.f90
	$(FC) $(OPT) sousprog.f90 -c

clean:
	rm -f *.mod *.exe *.o res.csv *.png


