# what is this?

this is a helper cmake package that can be used to make a simple [relocatable](https://cmake.org/cmake/help/latest/manual/cmake-packages.7.html) cmake library.

functions included:

`make_cmake_package`

## a tutorial of usage

in your `CMakeLists.txt` simply:


find the `cmake_macros` cmake package created and then include the macro exposed through the cmake modules path.


```cmake
find_package(cmake_macros)
include(create_package)
```

next, for the library you