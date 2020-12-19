# URL Shortener

This is an example URL shortener written in elixir.

## Tech Stack

* Elixir 1.11.2
* Erlang 23
* Postgres 13
* Tailwind CSS

## Running locally

I'm using docker and Make for development:

```
# Set up environment
make setup

# Run server locally on port 4000
make server

# Run tests
make test
```

Once you're running the server locally you can navigate to http://localhost:4000
in your browser to view the running site.

## Design Notes

This is a basic elixir application. I'm not using any of the advanced features
of the runtime since this is supposed to be a quick example application. The idea
is to accept a URL, hash the URL using a deterministic hashing scheme, and then
use the hash as the short code for lookups. We store the short code plus the original
url in Postgres.

The hashing scheme is straightforward. I opted to use a deterministic scheme because
it means that each node in the cluster will arrive at the same short code without
coordination. This makes caching operations much easier in the future.

The hashing scheme algorithm is straightforward. We generate the sha256 of the original url.
This provides us a hex value. We then convert that hex value into an integer.
Once we have the integer we can pack that as a binary and base64 encode the binary (stripping off 
the trailing `==`). This gives us a short set of characters to use as a key.

Postgres is an interesting choice as a primary datastore. Its not the highest
performance option for these operations, at least compared to something like
Redis. But the benefit over something like Redis is additional durability.
In a vacuum, I prefer a boring and reliable solution. Postgres checks both of
those boxes. A slightly more optimized solution would be to cache urls in a fast
datastore such as Redis with a limited TTL. The TTL and general caching scheme
would need to be determined by access patterns (how soon do users access short
links after they are created, how long does a short link tend to live, etc.).

If we wanted to further optimize for performance than utilize in-memory caching
with ETS tables. These tables could be populated by distributing links across
the cluster. The exact distribution scheme would again depend on access patterns.
There are several options that I've used in the past. If the total number of short
links was relatively low it might be possible to fully replicate all links across
the cluster, allowing each node to perform a lookup without needing to make any
trips across the network. If the number of links was larger than available memory,
we could distribute the links across the cluster using consistent hashing. These
solutions are complex and would need to be driven by data and more refined requirements.

