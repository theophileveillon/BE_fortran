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

    end function H


function f(x,p)
    use m_type
    implicit none

    type(phys) , intent(in):: p
    real, intent(in):: x
    integer :: H
    real :: f 

    f= H(x-p%L/10)-H(x-p%L/5)

end function f 

function create_maillage(p)
    use m_type
    implicit none

    type(phys), intent (in) :: p
    real, dimension(:), allocatable :: x_reg
    integer :: i
    real :: delta_x
    allocate(x_reg(p%N))
    delta_x = p%L / p%N
    do i=0 to p%N -1
        x_reg(i) = i*delta_x
    end do
end function create_maillage x_reg