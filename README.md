# ulid_fast - Fast ULID Generator

`ulid_fast` wraps the [ulid-c](https://github.com/skeeto/ulid-c/) library to provide fast ULID generation.

### Example Usage

```ruby
require 'ulid_fast'

ULID::Generator.new.generate
=> "01E0T6ZE28TSXRQTJC9AR9P362"

```

For long-lived Ruby applications (e.g. Rails), I recommend a different pattern to improve performance:
```ruby
require 'ulid_fast'

# Put this in config/initializers/ulid.rb, for example
ULID_GENERATOR = ULID::Generator.new

# Wherever you need a ULID, do this:
ULID_GENERATOR.generate
```

You don't need to create a generator instance for each ULID. When the instance is allocated, we call
`ulid_generator_init` which bootstraps the randomness feature of each generated ULID.


### Performance

Comparing to the pure-Ruby [ULID](https://github.com/rafaelsales/ulid) it's a lot faster provided
you are not re-initializing the generator for every ULID (see usage notes above).

```
Comparison:
ULID::Generator#generate:  2650174.9 i/s
           ULID.generate:    41236.1 i/s - 64.27x  slower
```

### Todo 
- Integrate `Enumerator` so we can generate batches of ULIDs
