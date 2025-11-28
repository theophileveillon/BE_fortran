subroutine lecture_data(nom_fichier,n,p)

use m_type

implicit none

    type(phys) , intent(out):: p
    type(num), intent(out):: n
    character(*) , intent(in):: nom_fichier

    open(10, file=nom_fichier)
    read(10,*) p%L
    read(10,*) p%tf
    read(10,*) p%C0
    read(10,*) p%U0
    read(10,*) n%N
    read(10,*) n%Nt

    close(10)

end subroutine lecture_data

function H(x)

    implicit none

    integer :: H
    real, intent(in) :: x 

    if (x<0) then
        H = 0
    else 
        H = 1
    end if

end function H


function f(x,p)
    use m_type
    implicit none

    type(phys) , intent(in):: p
    real, intent(in):: x
    integer :: H
    real :: f 

    f= H(x-(p%L/10))-H(x-(p%L/5))

end function f 

subroutine create_mesh(n,p, x_reg)
    use m_type
    implicit none

    type(phys), intent (in) :: p
    type(num), intent(in)::n
    real, dimension(n%N), intent (out) :: x_reg
    integer :: i
    real :: delta_x
    delta_x = p%L / n%N
    do i=1, n%N
        x_reg(i) = (i-1)*delta_x
    end do
end subroutine create_mesh


subroutine calc_C_dt(CNt,CNt_dt,n,p)
    use m_type
    implicit none 
    type(phys), intent(in):: p
    type(num), intent(in)::n

    real, dimension(n%N), intent(in):: CNt 
    real, dimension(n%N),intent(out):: CNt_dt

    integer :: i
    real:: delta_t,delta_x


    delta_x=p%L/n%N
    delta_t=p%tf/n%Nt
    
    do i=2,n%N
        CNt_dt(i)=CNt(i)- p%U0 * (delta_x/delta_t) * (CNt(i)-CNt(i-1))
    
    end do
    !print*, delta_x/delta_t 
    CNt_dt(1)=CNt_dt(n%N)


end subroutine calc_C_dt

subroutine C_init(x, n,p, C)
    use m_type
    implicit none
    type(phys) , intent(in) :: p
    type(num), intent(in)::n
    real, dimension(n%N), intent(in) :: x
    real, dimension(n%N), intent(inout) :: C
    real :: f
    integer :: i

    do i = 1, n%N 
        C(i) = p%C0 * f(x(i),p)
    end do
        
end subroutine C_init

subroutine ecriture_vecteur(n, p, C)
    use m_type
    implicit none

    type(phys), intent(in) :: p
    type(num),  intent(in) :: n
    real, dimension(n%N), intent(in) :: C
    integer :: i


    open(10, file="resultats.dat", status="unknown", position="append")

   
    do i = 1, n%N
        write(10, '(F10.5)', advance='no') C(i)
    end do


    write(10,*)

    close(10)
end subroutine ecriture_vecteur

subroutine test(n,p,x,C)

    use m_type
    implicit none

    type(phys), intent(in):: p
    type(num), intent(in)::n

    real, dimension(n%N), intent(in):: x
    real, dimension(n%N), intent(out) :: C

    integer :: i
    real :: f

    do i =1,n%N
        !print*,x(i)- p%U0 * p%tf, f(x(i)- p%U0 * p%tf,p)
        C(i)=p%C0 * f(x(i)- p%U0 * p%tf,p)
    end do

end subroutine test

subroutine create_irr_mesh(n,p, x_reg, x_irreg, Gamma)
    use m_type
    implicit none

    type(phys), intent (in) :: p
    type(num), intent(in)::n
    real, dimension(n%N), intent(in) :: x_reg
    real, dimension(n%N), intent (out) :: x_irreg
    integer :: i
    real :: delta_x
    integer :: Gamma
    delta_x = p%L / n%N
    do i=1, n%N
        x_irreg(i) = x_reg(i) + (Gamma * L * sin((2*acos(-1)*x_reg(i))/p%L))/(3*acos(-1))
    end do
end subroutine create_irr_mesh