program polluant
    use m_type
    implicit none

    type(phys)::p
    type(num)::n
    real, dimension(:,:), allocatable:: C
    real, dimension(:), allocatable:: x_reg 

    call lecture_data('donnees.dat')
    allocate(C(n%N,n%Nt))
    allocate(x_reg(n%N))

    call create_mesh(p,x_reg)
    call C_init(x_reg,p,C)

    print*, C

    deallocate(C,x_reg)



end program polluant