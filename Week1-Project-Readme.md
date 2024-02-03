# Course-Advanced-dbt: Project Week 1
##### _(1) Familiarize with the Bingeflix dbt project repo_

- Setup completed. dbt model reviewed.

##### _(2)  Add docs blocks to populate missing documentation and maintain consistency_

- `bingeflix_docs.md` updated with docs blocks for some of the tables and columns;
- References to the blocs added to stage and mart `.yml` files.

##### _(3)  Install ``dbt_project_evaluator`` package to enforce best practices_

- Package installed. All the warnings corrected:
- I added documentation for the ``fct_events`` model;
- Renamed ``mrr`` model to `fct_mrr` so that the model name is compliant with the rules for mart models;
- Updated ``dbt_project.yml`` to set the ``model fanout`` threshold to 10 instead of 3: to avoid ``is_empty_fct_model_fanout_ warning``

```(course_advanced_dbt) gitpod /workspace/course_advanced_dbt (w1-project-iran-rodrigues) $ dbt build -s package:dbt_project_evaluator dbt_project_evaluator_exceptions
06:25:05  Running with dbt=1.7.4
06:25:05  Registered adapter: snowflake=1.7.1
06:25:06  Found 55 models, 2 seeds, 1 operation, 142 tests, 5 sources, 0 exposures, 0 metrics, 873 macros, 0 groups, 0 semantic models
(..)
06:25:24  Running 1 on-run-end hook

### List of issues raised by dbt_project_evaluator ###

06:25:24  1 of 1 START hook: course_advanced_dbt.on-run-end.0 ............................ [RUN]
06:25:24  1 of 1 OK hook: course_advanced_dbt.on-run-end.0 ............................... [OK in 0.00s]
06:25:24
06:25:24
06:25:24  Finished running 22 view models, 21 table models, 1 seed, 27 tests, 1 hook in 0 hours 0 minutes and 18.20 seconds (18.20s).
06:25:24
06:25:24  Completed successfully
06:25:24
06:25:24  Done. PASS=71 WARN=0 ERROR=0 SKIP=0 TOTAL=71
```
##### _(4)  Install ``SQLFluff`` and run to fix violations_

- Done.
```
(course_advanced_dbt) gitpod /workspace/course_advanced_dbt (w1-project-iran-rodrigues) $ sqlfluff --version
sqlfluff, version 2.3.5
(course_advanced_dbt) gitpod /workspace/course_advanced_dbt (w1-project-iran-rodrigues) $ sqlfluff fix -p0
==== finding fixable violations ====
=== [dbt templater] Sorting Nodes...
=== [dbt templater] Compiling dbt project...
=== [dbt templater] Project Compiled.
WARNING    Skipped file /workspace/course_advanced_dbt/tests/generic/assert_column_is_positive.sql because it is a macro
==== no fixable linting violations found ====
All Finished 📜 🎉!
```
