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

- After the new hook is added, check fails on the ``fct_mrr.sql`` model because its current tag violates the rule. It's not clear to me why the error message was repeated six times.
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
(...)
models/marts/finance/fct_mrr.sql: has invalid tags:
- p0
```
- Modified the tag list to include the value in fct_mrr model (`p0`).
```
(course_advanced_dbt) gitpod /workspace/course_advanced_dbt (w2-project-iran-rodrigues) $ pre-commit run --hook-stage commit --all-files
(...)
Check the model has valid tags...........................................Passed
```


##### _(3)  Generalize a custom macro (``rolling_average_7_periods.sql``)_

- Created the macro ``rolling_aggregation_by_n_periods``.
- Applied the generalized macro to a new model: ``fct_mrr_3month_avg`` exposes the the *3-month moving average* of  total ``mrr_amount``.

##### _(4)  Write a custom macro to improve another part of the codebase_
- Created the macro ``trunc_to_period``.
- Applied the new macro to the first select in the ``fct_mrr`` model.
