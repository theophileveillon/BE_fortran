program polluant
    use m_type
    implicit none

    type(phys)::p
    type(num)::n
    real, dimension(:), allocatable:: CNt, CNt_dt, C_th
    real, dimension(:), allocatable:: x_reg 
    integer :: i 

    call lecture_data('donnees.dat',n,p)
    allocate(CNt(n%N),CNt_dt(n%N),C_th(n%N))
    allocate(x_reg(n%N))

    call create_mesh(n,p,x_reg)
    call C_init(x_reg,n,p,CNt)
    call ecriture_vecteur(n,p,x_reg)
    
    print*, CNt

    do i=1,n%Nt 
        
        
        call calc_C_dt(CNt,CNt_dt,n,p)
        CNt=CNt_dt
        call ecriture_vecteur(n,p,CNt)

    end do

    call test(n,p,x_reg,C_th)
    print*, CNt
    print*, C_th 
    deallocate(CNt,CNt_dt,x_reg)



end program polluant