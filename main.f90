program polluant
    use m_type
    implicit none

    type(phys)::p
    type(num)::n
    real, dimension(:), allocatable:: CNt, CNt_dt, C_th
    real, dimension(:), allocatable:: x_reg , x_irreg
    integer :: i, Gamma, theo
    real :: dt

    print*, "Choisir la valeur de gamma entre -1,0 et 1" !com
    read*, Gamma
    print*, "avec la courbe theorique ? 0=oui 1=non" !com
    read*, theo
    call lecture_data('donnees.dat',n,p)

    allocate(CNt(n%N),CNt_dt(n%N),C_th(n%N))
    allocate(x_reg(n%N),x_irreg(n%N))

    call create_mesh(n,p,x_reg)
    call create_irr_mesh(n,p,x_reg,x_irreg,Gamma)

    
    call C_init(x_irreg,n,p,CNt)

    if(theo==1)then
        !
        call ecriture_resultats(n,CNt,x_irreg)
        
        do i=1,n%Nt
            
            call calc_C_dt(CNt,CNt_dt,n,p)
            CNt=CNt_dt
            call ecriture_resultats(n,CNt,x_irreg)

        end do
    else
        call test(n,p,x_reg,C_th, 0.)
        call ecriture_resultats_theo(n,CNt,x_irreg,test)
        

        do i=1,n%Nt 
            
            call calc_C_dt(CNt,CNt_dt,n,p)
            dt = i*p%tf/n%Nt
            call test(n,p,x_reg,C_th,dt)
            CNt=CNt_dt
            call ecriture_resultats_theo(n,CNt,x_irreg,test)

        end do
    end if

    deallocate(CNt,CNt_dt,x_reg, x_irreg)



end program polluant