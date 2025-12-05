module m_type
    implicit none
    
    type phys
        real :: L, tf, C0, U0 
    end type phys
    
    type num
        integer :: N, Nt
    end type num
end module m_type