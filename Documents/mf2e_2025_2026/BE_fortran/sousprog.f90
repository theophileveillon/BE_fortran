subroutine lecture_data(nom_fichier)

use m_type

implicit none

    type(phys) :: p
    character (len = 100) :: nom_fichier

    open(10, file=nom_fichier)
    read(10,*) p%L
    read(10,*) p%tf
    read(10,*) p%C0
    read(10,*) p%U0
    read(10,*) p%N
    read(10,*) p%Nt

    close(10)

end subroutine lecture_data

function H(x)

    implicit none

    integer :: H
    real, intent(in) :: x 

    if (x<0) then
        H = 1
    else 
        H = 0
    end if

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

subroutine create_mesh(p, x_reg)
    use m_type
    implicit none

    type(phys), intent (in) :: p
    real, dimension(:), intent (out) :: x_reg
    integer :: i
    real :: delta_x
    delta_x = p%L / p%N
    do i=1, p%N
        x_reg(i) = (i-1)*delta_x
    end do
end subroutine create_mesh