program polluant
    use m_type
    implicit none

    type(phys)::p
    type(num)::n
    real, dimension(:), allocatable:: CNt, CNt_dt, C_th
    real, dimension(:), allocatable:: x_reg , x_irreg
    integer :: i, Gamma

    print*, "Choisir la valeur de gamma entre -1,0 et 1"
    read*, Gamma

    call lecture_data('donnees.dat',n,p)
    allocate(CNt(n%N),CNt_dt(n%N),C_th(n%N))
    allocate(x_reg(n%N),x_irreg(n%N))

    call create_mesh(n,p,x_reg)
    call create_irr_mesh(n,p,x_reg,x_irreg,Gamma)

    
    call C_init(x_irreg,n,p,CNt)

    call ecriture_vecteur(n,p,x_irreg)
    

    do i=1,n%Nt 
        
        
        call calc_C_dt(CNt,CNt_dt,n,p)
        CNt=CNt_dt
        call ecriture_vecteur(n,p,CNt)

    end do

    call test(n,p,x_reg,C_th)
    deallocate(CNt,CNt_dt,x_reg, x_irreg)



end program polluant