# Contributing

This guide still needs to be written. TL;DR is copy [data/.sample.yml](data/.sample.yml) to the relevant folder (or create it) in `data/v1/schools/:continent/:country/:state_or_city/:school_name.yml`. Create a PR and ensure it follows our standards.

See some examples:
- [Rutgers University](data/v1/schools/north-america/united-states/new-jersey/rutgers-university.yml)
- [University of Manchester](data/v1/schools/europe/united-kingdom/england/university-of-manchester.yml)
- [Manchester Metropolitan University](data/v1/schools/europe/united-kingdom/england/manchester-metropolitan-university.yml)

A few things on the to-do:

- Add some tests to `ruby/spec/` for the Ruby parser.
- Write this guide.
- Give it a license.
- Create a process around adding schools and managing the repository.