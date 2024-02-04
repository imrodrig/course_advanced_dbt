# Course-Advanced-dbt: Project Week 2
##### _(1) Add SQLFluff to pre-commit hook_

- SQLFluff added. Pre-commit setup is working as expected.

```
(course_advanced_dbt) gitpod /workspace/course_advanced_dbt (w2-project-iran-rodrigues) $ pre-commit run --hook-stage commit sqlfluff-lint --all-files
[INFO] Installing environment for https://github.com/sqlfluff/sqlfluff.
[INFO] Once installed this environment will be reused.
[INFO] This may take a few minutes...
sqlfluff-lint............................................................Passed
(course_advanced_dbt) gitpod /workspace/course_advanced_dbt (w2-project-iran-rodrigues) $
````

##### _(2)  Add more pre-commit hooks to enforce project conventions (dbt-checkpoint)_

- `dbt-checkpoint` pre-commit hook added and configured.
```
(course_advanced_dbt) gitpod /workspace/course_advanced_dbt (w2-project-iran-rodrigues) $ pre-commit run --hook-stage commit --all-files
[INFO] Installing environment for https://github.com/pre-commit/pre-commit-hooks.
[INFO] Once installed this environment will be reused.
[INFO] This may take a few minutes...
[INFO] Installing environment for https://github.com/dbt-checkpoint/dbt-checkpoint.
[INFO] Once installed this environment will be reused.
[INFO] This may take a few minutes...
check yaml...............................................................Passed
fix end of files.........................................................Passed
trim trailing whitespace.................................................Passed
sqlfluff-lint............................................................Passed
dbt compile..............................................................Passed
dbt docs generate........................................................Passed
Check the source table has description...................................Passed
Check that model has tests...............................................Passed
Check the script does not contain a semicolon............................Passed
Check the script has not table name......................................Passed
Check the model has all columns in properties file.......................Passed
(course_advanced_dbt) gitpod /workspace/course_advanced_dbt (w2-project-iran-rodrigues) $
```
##### _(2.1)  Configure ``check-model-tags`` check to the ``dbt-checkpoint`` tests performed_

- Added ``check-model-tags`` hook.
```
(course_advanced_dbt) gitpod /workspace/course_advanced_dbt (w2-project-iran-rodrigues) $ cat .pre-commit-config.yaml
repos:
(...)
- repo: https://github.com/dbt-checkpoint/dbt-checkpoint
  rev: v1.2.0
  hooks:
(...))
  - id: check-model-tags # Ensures any models in the core folder only have tags of "hourly", "daily", "weekly", or "monthly"
    args: ["--tags", "hourly", "daily", "weekly", "monthly", "--"]
```

- After the new hook is added, check fails on the ``fct_mrr.sql`` model because its current tag violates the rule. It's not clear why the error message was repeated six times.
```
(course_advanced_dbt) gitpod /workspace/course_advanced_dbt (w2-project-iran-rodrigues) $ cat models/marts/finance/fct_mrr.sql | more
{{ config(tags="p0") }}
(...)

(course_advanced_dbt) gitpod /workspace/course_advanced_dbt (w2-project-iran-rodrigues) $ pre-commit run --hook-stage commit --all-files
check yaml...............................................................Passed
(...)
Check the model has valid tags...........................................Failed
- hook id: check-model-tags
- exit code: 1

models/marts/finance/fct_mrr.sql: has invalid tags:
- p0
models/marts/finance/fct_mrr.sql: has invalid tags:
- p0
models/marts/finance/fct_mrr.sql: has invalid tags:
- p0
models/marts/finance/fct_mrr.sql: has invalid tags:
- p0
models/marts/finance/fct_mrr.sql: has invalid tags:
- p0
models/marts/finance/fct_mrr.sql: has invalid tags:
- p0
```
- I modified the tag list to include the value in fct_mrr model (`p0`).
```
(course_advanced_dbt) gitpod /workspace/course_advanced_dbt (w2-project-iran-rodrigues) $ pre-commit run --hook-stage commit --all-files
check yaml...............................................................Passed
(...)
Check the model has valid tags...........................................Passed
```


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
