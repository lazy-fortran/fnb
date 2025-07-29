# fortbook

Jupyter notebook interface for Fortran - interactive computing and visualization.

## Overview

fortbook provides Jupyter notebook support for Fortran, enabling interactive computing, data visualization, and literate programming in Fortran. It integrates with the lazy-fortran ecosystem for compilation and execution.

## Features

- Jupyter notebook parsing and execution
- Interactive Fortran code cells
- Figure capture and visualization
- HTML rendering of notebooks
- Integration with fortrun for code execution
- Support for notebook conversion and format handling

## Building

```bash
fpm build
```

## Usage

Execute a notebook:
```bash
fortbook run notebook.ipynb
```

Render notebook to HTML:
```bash
fortbook render notebook.ipynb -o output.html
```

Convert notebook format:
```bash
fortbook convert notebook.ipynb -o converted.ipynb
```

## Notebook Format

fortbook supports Jupyter notebook format (.ipynb) with Fortran code cells:

```json
{
  "cells": [
    {
      "cell_type": "code",
      "source": [
        "program hello\n",
        "    print *, 'Hello from Fortran!'\n",
        "end program"
      ],
      "outputs": []
    }
  ]
}
```

## Dependencies

- [fortfront](https://github.com/lazy-fortran/fortfront) - Frontend analysis
- json-fortran - JSON parsing
- fortrun (runtime) - Code execution and caching

## Architecture

- `notebook_types` - Notebook data structures
- `notebook_parser` - Notebook parsing from JSON
- `notebook_executor` - Cell execution engine
- `notebook_renderer` - HTML/output rendering
- `figure_capture` - Plot and figure handling

## License

MIT License - see LICENSE file for details.