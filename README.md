# what is this?

this is a helper cmake package that can be used to make a simple [relocatable](https://cmake.org/cmake/help/latest/manual/cmake-packages.7.html) cmake library. 

The goal of this is to make something that can be used to add the most value from cmake while leaving out the minute details that most people dont care about while handling the details that most people miss for you.

functions included:

`create_package`: actually handles the cmake BS for creating a sane cmake target that is usable outside of your cmake project. aka: you have a library repo and you have several application repos, how do you make your library installable or shareable between them? this helps you do that in the proper cmake way.

`easy_find_package`: wraps `find_package` to generate a `.cmake.in` file that gets used by the `Config.cmake` file generation macro to propagate `find_package` dependencies (yes, transitive dependencies are supposed to work and this is how you do them. why cmake doesnt do this in a sane way i have no idea.)



## a tutorial of usage

in your `CMakeLists.txt` simply:

find the `cmake_macros` cmake package created and then include the macros exposed through the cmake modules path.


```cmake
find_package(cmake_macros)
include(create_package)
include(easy_find_packages)
```

## `easy_find_package`
TODO

## `create_package`
TODO

## assumptions
for `easy_find_package`:
- you arent finding any packages that you dont need for building and you dont care about building different depending on what dependencies you find. (all packages are `REQUIRED`)
- you dont care about the versions of packages found (version cant be specified with this util)

## nix

uh, use it its very nice. there is a flake here that has an overlay you can use. I havent tried to use this with something like [CPM](https://github.com/cpm-cmake/CPM.cmake) yet but in theory it usable with it so you dont have to learn a language that while more sane than cmake is somehow harder to grok.