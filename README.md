# matchcapture

`matchcapture` is a C library and command-line tool for matching input strings against template patterns and capturing segments. It supports advanced features like named captures, greedy and non-greedy matching, and integration with test functions for validation.

## Features

- **Template-based matching**: Define patterns with placeholders like `{}`, `{a}`, `{?}`, and `{0}`.
- **Named captures**: Ensure consistent matching for specific placeholders across the template.
- **Greedy and non-greedy matching**: Control how much of the input is captured.
- **Test integration**: Validate captured segments using custom shell commands or functions.

## Installation

### Requirements
- GCC or any modern C compiler
- Make

### Build
To build the repository, run:
```bash
make
```

### Install
Copy the binaries and manual files to their appropriate locations:
```bash
sudo cp matchcapture /usr/local/bin/
sudo cp matchcapture.1 /usr/share/man/man1/
sudo cp matchcapture.5 /usr/share/man/man5/
sudo cp matchcapture.3 /usr/share/man/man3/
```

## Using `matchcapture` in Your Project

If you want to use the `matchcapture` functionality in your own project, you can copy `matchcapture.c` and `matchcapture.h` directly into your source tree. These files provide the core matching logic and API. 

Include `matchcapture.h` in your code, and link `matchcapture.c` with your project during compilation. See the [Library Usage](#library-usage) section below for examples.

## Usage

### CLI
The `matchcapture` CLI tool matches an input string against a template and extracts captured segments.

```bash
matchcapture <template> <input> [test-commands...]
```

#### Example
```bash
matchcapture "/{}/{}/" "/path/to/resource"
```
Output:
```
0: path
1: to
2: resource
```

See the [`matchcapture.1`](./matchcapture.1) manual for detailed usage instructions.

### Library Usage
The `matchcapture` library provides a C API for integrating matching logic into your programs.

#### Example
```c
#include "matchcapture.h"

int main() {
    char* captures[3];
    const char* template = "/{}/{}/";
    char input[] = "/path/to/resource";
    int result = matchcapture(input, template, captures, 3, NULL, NULL);

    if (result >= 0) {
        for (int i = 0; i < result; i++) {
            printf("Capture %d: %s\n", i, captures[i]);
            free(captures[i]);
        }
    } else {
        printf("No match\n");
    }

    return 0;
}
```

See [`matchcapture.h`](./matchcapture.h) and [`matchcapture.3`](./matchcapture.3) for API details.

## Template Syntax

Templates use placeholders to define match patterns:

- `{}`: Regular capture
- `{a}`, `{b}`: Named capture
- `{?}`: Non-greedy capture
- `{0}`, `{0|a}`: Tested capture (validates with test functions)

See the [`matchcapture.5`](./matchcapture.5) manual for full syntax details.

## Testing

To build and run tests:
```bash
make test
```

This builds the `testcapture` binary and runs it.

## License

This project is licensed under the Zlib License. See the [LICENSE](./LICENSE) file for details.
