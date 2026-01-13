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

subroutine calc_C_dt(CNt, CNt_dt, n, p, x)
    use m_type
    implicit none

    type(phys), intent(in):: p
    type(num), intent(in)::n
    real, dimension(n%N), intent(in):: CNt
    real, dimension(n%N), intent (in) :: x
    real, dimension(n%N),intent(out):: CNt_dt
    integer :: i
    real:: delta_t

    delta_t=p%tf/n%Nt

    CNt_dt(1)=CNt_dt(n%N)
    do i=2,n%N
        CNt_dt(i) = CNt(i) - p%U0 * (delta_t/(x(i)-x(i-1))) * (CNt(i)-CNt(i-1))
    end do

end subroutine calc_C_dt

subroutine create_irr_mesh(n,p, x_reg, x_irreg, Gamma)
    use m_type
    implicit none

    type(phys), intent (in) :: p
    type(num), intent(in)::n
    real, dimension(n%N), intent(in) :: x_reg
    real, dimension(n%N), intent (out) :: x_irreg
    integer :: i
    integer :: Gamma
    
    do i=1, n%N
        x_irreg(i) = x_reg(i) - (Gamma * (p%L / 3 / acos(-1.)) * sin((2*acos(-1.)*x_reg(i))/p%L))
    end do

end subroutine create_irr_mesh

subroutine C_verif(n,p,x,C,t)
    use m_type
    implicit none

    type(phys), intent(in):: p
    type(num), intent(in)::n
    real , intent(in) :: t
    real, dimension(n%N), intent(in):: x
    real, dimension(n%N), intent(out) :: C
    integer :: i
    real :: f

    do i =1,n%N
        C(i)=p%C0 * f(x(i)- p%U0 * t,p)
    end do

end subroutine C_verif

subroutine ecriture_resultats(N,C,x)
    use m_type
    implicit none

    type(num),  intent(in) :: n
    real, dimension(n%N), intent(in) :: C
    real, dimension(n%N), intent(in) :: x
    integer :: i
    real :: x_tmp, max_r

    max_r = huge(x_tmp)

    open(10, file="res.csv", status="unknown", position="append")

    do i = 1, n%N
        if (c(i)< max_r) then 
            write(10, '(F16.8, 1X, F16.8)') x(i), C(i)
        else
            write(10, '(F16.8, 1X, F16.8)') x(i), max_r
        end if
    end do

    close(10)

end subroutine ecriture_resultats

subroutine ecriture_resultats_theo(N,C,x,C_verif)
    use m_type
    implicit none

    type(num),  intent(in) :: n
    real, dimension(n%N), intent(in) :: C, x, C_verif
    integer :: i
    real :: r_tmp, max_r

    max_r = huge(r_tmp)

    open(10, file="res.csv", status="unknown", position="append")

    do i = 1, n%N
        if ((c(i)>= max_r) .and. (C_verif(i) >= max_r)) then 
            write(10, '(F16.8, 1X, F16.8, 1X, F16.8)') x(i), max_r, max_r
        else if (c(i)>= max_r) then
            write(10, '(F16.8, 1X, F16.8, 1X, F16.8)') x(i), max_r, C_verif(i)
        else if (C_verif(i) >= max_r) then 
            write(10, '(F16.8, 1X, F16.8, 1X, F16.8)') x(i), C(i), max_r
        else
            write(10, '(F16.8, 1X, F16.8, 1X, F16.8)') x(i), C(i), C_verif(i)
        end if
    end do

    close(10)

end subroutine ecriture_resultats_theo






