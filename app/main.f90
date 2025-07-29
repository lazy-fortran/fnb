program fortbook_main
    use notebook_types, only: notebook_t
    use notebook_parser, only: parse_notebook
    use notebook_executor, only: execute_notebook
    use notebook_renderer, only: render_notebook
    implicit none

    character(len=256) :: input_file, output_file, command, error_msg
    type(notebook_t) :: notebook
    integer :: num_args
    logical :: execute_mode, render_mode

    ! Get command line arguments
    num_args = command_argument_count()
    if (num_args < 1) then
        print *, "Usage: fortbook <command> [options]"
        print *, ""
        print *, "Commands:"
        print *, "  run <notebook.ipynb>        Execute notebook"
        print *, "  render <notebook.ipynb>     Render notebook to HTML"
        print *, "  convert <notebook.ipynb>    Convert notebook format"
        print *, ""
        print *, "Options:"
        print *, "  -o <file>    Output file"
        stop 1
    end if

    call get_command_argument(1, command)
    
    execute_mode = .false.
    render_mode = .false.
    output_file = ""
    
    select case (trim(command))
    case ("run")
        execute_mode = .true.
        if (num_args < 2) then
            print *, "Error: run command requires notebook file"
            stop 1
        end if
        call get_command_argument(2, input_file)
        
    case ("render")
        render_mode = .true.
        if (num_args < 2) then
            print *, "Error: render command requires notebook file"
            stop 1
        end if
        call get_command_argument(2, input_file)
        
    case ("convert")
        if (num_args < 2) then
            print *, "Error: convert command requires notebook file"
            stop 1
        end if
        call get_command_argument(2, input_file)
        
    case default
        print *, "Error: unknown command '", trim(command), "'"
        stop 1
    end select

    ! Parse additional options
    call parse_options(output_file)

    ! Parse notebook
    call parse_notebook(input_file, notebook, error_msg)
    if (len_trim(error_msg) > 0) then
        print *, "Error parsing notebook: ", trim(error_msg)
        stop 1
    end if

    ! Execute operations
    if (execute_mode) then
        call execute_notebook(notebook, error_msg)
        if (len_trim(error_msg) > 0) then
            print *, "Error executing notebook: ", trim(error_msg)
            stop 1
        end if
        print *, "Notebook executed successfully"
        
        ! Save executed notebook
        if (len_trim(output_file) > 0) then
            call save_notebook(output_file, notebook)
        else
            call save_notebook(input_file, notebook)  ! Overwrite original
        end if
        
    else if (render_mode) then
        if (len_trim(output_file) == 0) then
            ! Default HTML output
            output_file = replace_extension(input_file, '.html')
        end if
        
        call render_notebook(notebook, output_file, error_msg)
        if (len_trim(error_msg) > 0) then
            print *, "Error rendering notebook: ", trim(error_msg)
            stop 1
        end if
        print *, "Notebook rendered to: ", trim(output_file)
        
    else
        ! Convert mode - just parse and save
        if (len_trim(output_file) == 0) then
            output_file = input_file  ! Overwrite original
        end if
        
        call save_notebook(output_file, notebook)
        print *, "Notebook converted to: ", trim(output_file)
    end if

contains

    subroutine parse_options(out_file)
        character(len=*), intent(out) :: out_file
        integer :: i
        character(len=256) :: arg
        
        out_file = ""
        i = 3  ! Start after command and input file
        
        do while (i <= command_argument_count())
            call get_command_argument(i, arg)
            
            if (trim(arg) == "-o") then
                i = i + 1
                if (i <= command_argument_count()) then
                    call get_command_argument(i, out_file)
                end if
            end if
            
            i = i + 1
        end do
    end subroutine parse_options

    subroutine save_notebook(filename, nb)
        character(len=*), intent(in) :: filename
        type(notebook_t), intent(in) :: nb
        
        ! Stub for saving notebook
        print *, "Saving notebook to: ", trim(filename)
    end subroutine save_notebook

    function replace_extension(filename, new_ext) result(new_filename)
        character(len=*), intent(in) :: filename, new_ext
        character(len=:), allocatable :: new_filename
        integer :: dot_pos
        
        dot_pos = index(filename, '.', back=.true.)
        if (dot_pos > 0) then
            new_filename = filename(1:dot_pos-1) // new_ext
        else
            new_filename = filename // new_ext
        end if
    end function replace_extension

end program fortbook_main