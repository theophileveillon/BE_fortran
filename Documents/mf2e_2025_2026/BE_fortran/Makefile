FC = gfortran
OPT = -g -O0 -fbounds-check

OBJ = type.o main.o sousprog.o

main.exe :	$(OBJ)
	$(FC) $(OPT) $(OBJ) -o main.exe

type.o :	type.f90
	$(FC) $(OPT) type.f90 -c

main.o :	main.f90
	$(FC) $(OPT) main.f90 -c

sousprog.o :	sousprog.f90
	$(FC) $(OPT) sousprog.f90 -c

clean :
	/bin/rm -f $(OBJ) *.mod *.exe *.mod
