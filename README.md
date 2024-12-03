# Patricia-tree

The project implements a simulator to write out the Patricia Tree, represented in this paper [*Fast Mergeable Integer Maps**][paper]

## Build with opam
Install opam 2.0+ and then off you go:

```console
$ eval $(opam env) # Navigate to the environment variables set
$ opam install . --deps-only # Install libraries in patricia_tree.opam
$ eval $(opam env) # Apply the installed libraries
$ dune build . # Build the Ocaml project
```

## Test with dune

```console
$ dune test
```

## License

The source code is distributed under the [MIT Open Source
License](https://opensource.org/licenses/MIT).



[paper]: https://ittc.ku.edu/~andygill/papers/IntMap98.pdf
