# Database Optimizations

## Description

Given an existing application which generates a report from a large data set, improve the efficiency of the report using database optimization methods.

### Estimates

I anticipate spending about 8 hours on this assignment. Part 1 (Analysis) sounds like it can be accomplished in 3 hours and part 2 (Search Bar) in 5 hours.

### Analysis

-Initial database seed time: 1464.04 s
-Total time to load in chrome: ~3578 s (timeline shutdown before I could record any other times)
-Time to run migrations (not seeds) after adding indices: ~.001 s
** At this point, after wiping out half the db schema, I had to restart the assignment. Reseeding the db took another 45 minutes or so and
-DB size: 570 MB
-Dev log: 1.06 GB

### Reflection

After restarting the assignment with another round of db seeding, part 1 took about 6 hours and part 2 took approximately 4 hours, including a refactoring of the search bar set-up.
