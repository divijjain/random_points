# RandomPoints

* The app starts a genserver when launched.
 * This genserver updates the points of users periodically at an interval of 60 seconds asynchronously and a `min_number`.
 * This genserver returns the users having points > `min_number`.

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

## use API
### To get the max 2 users with more than the `min_number`

### Request: 
* GET `/` 

### Sample Response

```
{
    "timestamp": "2023-02-13T07:55:57.817350Z",
    "users": [
        {
            "id": 204022,
            "points": 94
        },
        {
            "id": 204058,
            "points": 84
        }
    ]
}
```

### To run the test cases:
 
 * cd fantasy_points
 * mix test
