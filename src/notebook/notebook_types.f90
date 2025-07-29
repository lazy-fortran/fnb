module notebook_types
    implicit none
    private

    ! Cell execution result
    type, public :: cell_result_t
        logical :: success = .true.
        character(len=:), allocatable :: output
        character(len=:), allocatable :: error
        character(len=:), allocatable :: figure_data  ! Base64 encoded PNG
    end type cell_result_t

    ! Execution results for entire notebook
    type, public :: execution_result_t
        type(cell_result_t), allocatable :: cells(:)
        logical :: success = .true.
        character(len=:), allocatable :: error_message
    end type execution_result_t

end module notebook_types
