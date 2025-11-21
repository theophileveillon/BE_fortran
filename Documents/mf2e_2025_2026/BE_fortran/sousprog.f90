subroutine lecture_data(nom_fichier)

use m_type

implicit none

    type(phys) :: p

    open(10, nom_fichier)
    read(10,*) :: p%L
    read(10,*) :: p%tf
    read(10,*) :: p%C0
    read(10,*) :: p%U0
    read(10,*) :: p%N
    read(10,*) :: p%Nt

    close(10)

end subroutine lecture_data

function H(x)

    implicit none

    integer, intent(out) :: val
    real, intent(in) :: x 

    if (x<0) then
        val = 1
    else 
        val = 0

    end function 



