# Error-driven generation prompt

Used from the second iteration of the error loop ([model, mechanism 3](../docs/model.md#3-error-driven-generation-loop)). The operator pastes [template-generation.md](template-generation.md) first, then the block below with one error report.

Operator notes, not part of the prompt:

- The report comes from a **fresh** batch of evaluation templates the model has never seen, never from the real test set.
- Excerpts in the report are shown in template form, with tags, never as filled text: the session sees the context and the hook has nothing to mask.
- New templates go to training only. The template checker rejects any new template too close (MinHash) to an evaluation template, otherwise validation scores become optimistic.

---

## Error report

The model was evaluated on templates it never saw. Below are the clusters where it failed, grouped by cell, appearance mode and kind of error. Each cluster gives counts and a few excerpts, with the failing tag marked `⟬!…⟭`.

```
REPORT
iteration: <n>
clusters:
  - id: <cluster id>
    cell: <cell_id>
    appearance: <appearance mode>
    error: leak | partial_leak | false_alarm | wrong_category | doubt
    kind: <entity kind, or trap type for false alarms>
    count: <errors> / <occurrences>
    excerpts:
      - <3 to 10 lines of template text around the failing tag>
    templates_wanted: <number>
```

Error types:

- `leak`: an entity left entirely visible.
- `partial_leak`: an entity hidden only in part. The visible part is often a family name after a particle, the domain of an email, the end of an IBAN or the last segment of a token.
- `false_alarm`: a trap or ordinary text hidden for nothing.
- `wrong_category`: hidden but under the wrong category. This matters most when a secret is taken for a name, since the product would then pseudonymize it instead of deleting it.
- `doubt`: the model was right, but with low confidence, or its self-evaluation head flagged the decision as likely wrong.

## Your task in this iteration

For each cluster, write `templates_wanted` new templates that reproduce the **pattern** behind the errors, never the text of the excerpts.

1. First, name the pattern in one sentence per cluster: what in the context makes this case hard. For example: "names in a `Co-authored-by` trailer after a long diff, with no other person mentioned".
2. Vary everything around the pattern: domain, format, language, length, variable names, position in the file, neighbouring content.
3. For `leak` and `partial_leak` clusters, include harder variants: the same pattern with rarer names, compound or particle names, unusual formatting (upper case, no separators, line wraps), the value further from any announcing word.
4. For `false_alarm` clusters, write **contrastive pairs**: two templates that share the pattern, one where the value is the trap, one where a real entity sits in the same position. The model then learns the difference from context, not from position.
5. For `wrong_category` clusters, put the two confused categories side by side in the same template, in comparable positions.
6. Keep every rule, the output format and the per-template check of the base prompt. Write to `templates/raw/<cell_id>-it<n>/`.

Report, at the end, the pattern you named for each cluster and the number of templates written for it.
