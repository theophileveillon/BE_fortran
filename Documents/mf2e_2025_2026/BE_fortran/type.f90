module m_type
    implicit none
    
    type phys
        real :: L, tf, C0, U0
        integer :: N, Nt
    end type phys
end module m_type