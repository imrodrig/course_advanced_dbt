# Course-Advanced-dbt: Project Week 3

#### Objectives
- types of dbt tests and testing strategies
-- built-in generic tests: not null, unique, relatonships, accepted values
- which type of test to use for each scenario
- write custom specific and generic tests
- other data quality tools and methodologies (unit tests)

##### _(1) Identify a few redundant tests that can be removed_

###### Identify and remove at least 3 redundant tests from the project. Provide a short explanation in your project submission for how/why you identified which tests to remove
- I found the same tests defined in sources and staging models that did not performed data transformation. These tests likely don't need to be repeated.
-- Same `accepted_values` test is defined on source `subscription_plans` and stage model `stg_bingeflix__subscription_plans`. Removed tests from stg model.
-- Same `accepted_values` test is defined on source `users` and stage model `stg_bingeflix__users`. Removed tests from stg model.
-- Removed most of the `not null` tests from `dim_users` model because it builds on the `stg_bingeflix__users` model without any filtering. Preserved the PK tests on the dimensional model.
-- Removed most of the `not null` tests from `stg_bingeflix__users` model because it builds on the `users` source without any filtering.

- Updated the testing conventions listed in the `README.md` file to document.


##### _(2)  Write a custom generic test to replace a redundant singular test_

- Promoted the `custom singular` test `assert_valid_event_name` to a `generic` one.
- Applied it to the `stg_bingeflix__events` model.

```
(course_advanced_dbt) gitpod /workspace/course_advanced_dbt (w3-project-iran-rodrigues) $ dbt test --select stg_bingeflix__events
03:19:07  Running with dbt=1.7.4
(..)
03:19:09  Concurrency: 8 threads (target='dev')
03:19:09
03:19:09  1 of 7 START test assert_valid_event_name_stg_bingeflix__events_event_name___test_  [RUN]
03:19:09  2 of 7 START test not_null_stg_bingeflix__events_created_at .................... [RUN]
03:19:09  3 of 7 START test not_null_stg_bingeflix__events_event_id ...................... [RUN]
03:19:09  4 of 7 START test not_null_stg_bingeflix__events_event_name .................... [RUN]
03:19:09  5 of 7 START test not_null_stg_bingeflix__events_session_id .................... [RUN]
03:19:09  6 of 7 START test not_null_stg_bingeflix__events_user_id ....................... [RUN]
03:19:09  7 of 7 START test unique_stg_bingeflix__events_event_id ........................ [RUN]
03:19:10  3 of 7 PASS not_null_stg_bingeflix__events_event_id ............................ [PASS in 0.66s]
03:19:10  7 of 7 PASS unique_stg_bingeflix__events_event_id .............................. [PASS in 0.66s]
03:19:10  4 of 7 PASS not_null_stg_bingeflix__events_event_name .......................... [PASS in 0.67s]
03:19:10  2 of 7 PASS not_null_stg_bingeflix__events_created_at .......................... [PASS in 0.68s]
03:19:10  6 of 7 PASS not_null_stg_bingeflix__events_user_id ............................. [PASS in 0.72s]
03:19:10  5 of 7 PASS not_null_stg_bingeflix__events_session_id .......................... [PASS in 0.72s]
03:19:11  1 of 7 PASS assert_valid_event_name_stg_bingeflix__events_event_name___test_ ... [PASS in 1.41s]
03:19:11
03:19:11  Running 1 on-run-end hook

### List of issues raised by dbt_project_evaluator ###

03:19:11  1 of 1 START hook: course_advanced_dbt.on-run-end.0 ............................ [RUN]
03:19:11  1 of 1 OK hook: course_advanced_dbt.on-run-end.0 ............................... [OK in 0.00s]
03:19:11
03:19:11
03:19:11  Finished running 7 tests, 1 hook in 0 hours 0 minutes and 2.49 seconds (2.49s).
03:19:11
03:19:11  Completed successfully
03:19:11
03:19:11  Done. PASS=7 WARN=0 ERROR=0 SKIP=0 TOTAL=7
```

- Added the `custom singular` test `test_positive_user_logins` to check that `login_count` is greated than zero.
- Promoted it to the `generic test` `assert_column_is_greater_than`
- Applied the generic test to the models `fct_active_users` and `stg_bingeflix__subscription_plans`, where a column value must be greater than zero.
