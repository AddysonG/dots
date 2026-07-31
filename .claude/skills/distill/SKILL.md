---
name: distill
description: >-
  Session-scoped answer-style toggle. Once invoked, keep answering exactly as you
  normally would, then close each turn with a horizontal rule and a single
  no-fluff, quickly-readable summary — placed once, at the very end, covering
  everything since the user's last message. The addition is the line + the
  straight-talk section below it; your default response above it stays unchanged.
  Invoke when the user asks for this layered style for all following responses
  (until the session ends or they say stop).
hooks:
  # Attention poke, injected silently before each user prompt. Carries no
  # policy: the criteria live in the body below and stay the single source of
  # truth. Duplicating them here would let the two drift and would bias the
  # reading by framing the check as a checklist.
  UserPromptSubmit:
    - hooks:
        - type: command
          command: >-
            echo '{"hookSpecificOutput": {"hookEventName": "UserPromptSubmit",
            "additionalContext": "Distill is active — apply it when composing
            this response."}}'
---

# Distill — a straight-answer summary below your normal response

When invoked, apply this to **every response for the remainder of the session**
(all prompts, not just the next one) until the user says stop or the session ends.

The skill adds exactly ONE thing to your turn: a horizontal rule at the very end,
then a crisp "here's what you need to know" section. One per turn, no matter how
many phases the work took. It does **not** change how you answer above that line.

## Above the line — your normal answer, unchanged

Answer exactly as you would by default. **Do not alter your reasoning or response
style to fit this skill.** The default style already shows your thought process
well, and that is what belongs here — this is not a mandated "brain-dump"
section, it is simply your normal response. Don't pad it, trim it, or reshape it
for the skill's sake. The skill contributes nothing to this part; leave it alone.

## The line

Then a horizontal rule on its own line: `---`

## Placement — exactly once, at the very end of the turn

The rule and the section below it are the **last thing you write before handing
the prompt back to the user** — not after each stage of the work.

One summary covers **everything since the user's last message** — not since your
last response. A subagent completing, a background-task notification, or a
hook-triggered continuation does **not** open a new scope: those are your own
turn boundaries, invisible to the user, who sees one exchange. When you respond
again after one, the summary is cumulative from their last message and
**supersedes** the previous one rather than continuing from it — the most recent
summary must stand alone.

If the turn ran multiple phases — research then implementation, or several
implement/review cycles — do **not** emit a summary after each phase. Let the
phases run in your normal style, then close with a single section covering all of
it. The user should never have to scroll through your process hunting for summary
fragments; there is one place to look, at the bottom.

## The invoking turn — reach back one prompt

When the skill is invoked **mid-session**, while it was not already active, the
summary on that first turn covers **everything since the user's previous
prompt** — the one before the invocation — not just the invocation itself.

The reason: invoking mid-session usually means work has just landed that the
user wants distilled. Scoping the first summary to the invoking message alone
would leave exactly that work uncovered, and the summary would have nothing to
say. So the scope is the previous user prompt, your full response to it, and
anything done in the invoking turn — one section, still at the very end.

This is a one-time widening. From the next prompt onward the normal scope
applies: everything since the user's last message.

It does not suspend the omission conditions below — apply them to the widened
scope. If the previous exchange was itself short or self-summarizing and the
invoking turn added nothing, omit the summary as usual. Nor does it override the
skill being off before invocation: do not go back and retro-fit summaries onto
responses that already shipped, and reach back exactly one prompt, not further.

If the invocation is the first message of the session, there is no previous
prompt and nothing to reach back to — normal scoping applies.

## When to omit the summary entirely

Skip the rule and the section when there is nothing left to distill. These are
an **OR, not an AND** — either one alone is enough, and they often co-occur but
do not need to:

- **The turn is already short.** The whole response is a small paragraph or a
  few short bullets.
- **The summary would just be a rephrase.** It would come out almost as long as
  the turn itself, or the same length, at the same level of technicality.

In either case the answer *is* the summary; appending a second copy of it under
a rule adds length without adding readability, which is the opposite of the
point.

Note this is about the **written response**, not the work behind it. A turn with
a long research or implementation phase that lands on a two-line answer is still
short by this test — as long as those two lines are genuinely self-contained and
the process holds nothing load-bearing the user still needs. When in doubt, write
the summary; the failure mode of omitting one that was needed is worse than a
slightly redundant one.

## Below the line — tell me straight, fast to read

This section is the point of the skill. Below the rule, give the exact details
the user needs, in a form they can read at a glance:

- **Straight talk.** Say what matters plainly. No ceremony, no hedging that
  carries no information, no restating the prompt.
- **Quickly readable.** Short. Headers / bullets / bold where they aid scanning.
  Front-load the answer or decision; supporting detail after.
- **Self-contained.** Assume the section above it was **not** read — the summary
  existing is the reason it may be skipped. Every load-bearing detail must be
  present here; never make the reader climb back up.
- **No bare references.** Do not point at anything the summary hasn't itself
  named. "Problem A", "decision #2", "item 3", "the second option", "as noted
  above", "the file I mentioned" carry zero meaning to someone who only read this
  section. Name the thing every time: *the null check in `parse_args`*, not
  *issue 2*. If you number things here, number things you also define here.
- **Assume it's read first.** If the user does go through your process, they read
  it *after* this section — so this section can't lean on it as prior context,
  and forward references like "explained below" are backwards.
- **Faithful.** It distills what's above; it adds no new claim and drops no
  load-bearing caveat.

## Notes

- Tools work normally; the two tiers describe the final written answer only.
- Persist across turns. If a later summary or a context compaction drops this,
  the user can re-invoke the skill.
- Off when the session ends or the user says so ("drop the format", "back to
  normal answers").
