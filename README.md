# fortnb

**Fortran Notebook** - jupytext-style interactive computing with markdown/PDF output.

## Overview

fnb provides jupytext-style notebook support for Fortran, enabling interactive computing, data visualization, and literate programming. It integrates with the lazy-fortran ecosystem for compilation and execution, generating markdown and PDF output rather than traditional Jupyter notebooks.

## Features

- Jupytext-style notebook parsing and execution
- Interactive Fortran code cells (.f files)
- Figure capture and visualization
- Markdown and PDF output rendering
- Integration with fortrun for code execution
- Support for notebook conversion and format handling

## Building

```bash
fpm build
```

## Usage

Execute a notebook:
```bash
fnb run analysis.f
```

Render to markdown:
```bash
fnb render analysis.f -o output.md
```

Render to PDF:
```bash
fnb render analysis.f -o output.pdf
```

## Notebook Format

fnb uses jupytext-style .f files with special comments for cells and markdown:

```fortran
! ## Hello World Example
! This is a markdown cell explaining the code below

x = 5.0
y = 3.0
result = sqrt(x**2 + y**2)
print *, "Distance:", result

! ## Visualization
! Generate a simple plot

! (figure capture and output will be included in rendered output)
```

## Dependencies

- [fortfront](https://github.com/lazy-fortran/fortfront) - Frontend analysis
- json-fortran - JSON parsing
- fortrun (runtime) - Code execution and caching

## Architecture

- `notebook_types` - Notebook data structures
- `notebook_parser` - Notebook parsing from JSON
- `notebook_executor` - Cell execution engine
- `notebook_renderer` - Markdown/PDF output rendering
- `figure_capture` - Plot and figure handling

## License

MIT License - see LICENSE file for details.
