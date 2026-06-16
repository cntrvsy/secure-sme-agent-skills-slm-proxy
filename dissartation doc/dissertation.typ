// ============================================================
// CST7000 Technology Dissertation
// Cardiff Metropolitan University — Cardiff School of Technologies
//
// HOW TO USE THIS FILE
// ──────────────────────────────────────────────────────────
// 1. Edit the metadata block below (title, author, etc.)
// 2. Replace placeholder text in each chapter with your writing
// 3. Replace the manual bibliography with:
//      #bibliography("references.bib")
//    once you have a .bib file (see Bibliography section below)
// 4. Compile with: typst compile dissertation.typ
//
// WRITING STYLE REMINDERS (§3.2.3)
//   ✓ Use passive voice:  "It was decided…"  not  "I decided…"
//   ✓ No contractions:    "do not"  not  "don't"
//   ✓ No colloquialisms
//   ✓ Target 7,000–10,000 words (excl. figures, tables, refs, appendices)
//   ✗ Penalties apply for over- or under-length submissions (§1.2)
// ============================================================

#import "template.typ": dissertation

#let supervisor = "Dr P Jenkins"

#show: dissertation.with(
  title: "Securing SME Agent Skills via Fine-Tuned SLM Proxies",
  author: "Benin Mukabanah",
  degree: "Masters Degree in Data Science",
  school: "Cardiff School of Technologies",
  university: "Cardiff Metropolitan University, Cardiff",
  month-year: "July 2026",
  supervisor: supervisor,

  // Abstract: ≤ 300 words, ~half page, self-contained (§3.4.2)
  // Must show main features of each chapter including conclusions.
  // Must NOT refer to anything not mentioned in the dissertation.
  abstract: [
    This dissertation investigates the application of formal logic to
    data-driven analysis within information systems. The study reviews
    existing approaches, develops a novel framework, and evaluates its
    effectiveness through a series of controlled experiments. Results
    indicate a statistically significant improvement in analytical
    accuracy when the proposed method is applied. Conclusions identify
    both the practical benefits and the limitations of the framework,
    and suggest directions for future research.
  ],

  // Acknowledgements: optional — delete this argument to omit the page (§3.4.3)
  acknowledgements: [
    The author would like to thank #supervisor for invaluable
    supervision and guidance throughout this project. Gratitude is also
    extended to the staff of the Cardiff School of Technologies and the
    Cardiff Metropolitan University library for their continued support.
  ],
)

// ════════════════════════════════════════════════════════════════════════════
// CHAPTER 1 — INTRODUCTION  (§3.4.7)
// Arabic page numbering begins here at page 1.
//
// A good introduction should (§3.4.7):
//   - Give an overview without assuming special knowledge
//   - State the aims (and hypothesis, if appropriate)
//   - Describe the approach used
//   - State any assumptions on which the work is based
//   - Provide an overview of the dissertation structure
//   - May discuss limitations and achievements
// ════════════════════════════════════════════════════════════════════════════
= Introduction

== Overview and Background
Small and medium-sized enterprises (SMEs) function as the backbone of the global economy, representing approximately 90% of all businesses and providing over 50% of employment worldwide @sanchez2025artificial. To remain competitive in an increasingly digital marketplace, these organizations urgently need to adopt Artificial Intelligence (AI) to automate routine tasks, streamline workflows, and enhance operational productivity @ode2026ai. However, SMEs frequently encounter an "Operational Paradox": they desperately need automation to scale, but lack the vast financial resources, specialized IT infrastructure, and technical personnel required to run or manage massive, general-purpose AI models @sanchez2025artificial.

Recently, AI has evolved from passive conversational chatbots into autonomous "agents" capable of interacting with external systems and environments @zhan2024injecagent. To standardize how AI accesses external tools, the Model Context Protocol (MCP) was introduced, acting as a universal "USB-C port" for AI applications @whittaker2026mcp. While large technology companies are equipped to handle complex MCP server infrastructure, SMEs are increasingly relying on a lightweight alternative known as *Agent Skills* @whittaker2026mcp. Agent Skills are standardized, version-controlled directories—anchored by a `SKILL.md` file—that provide the AI with reusable procedural knowledge and instructions @agentskills2026overview. Agents load these skills through "progressive disclosure", reading only basic metadata initially and expanding the full instructions into their context window only when actively required by the task @agentskills2026overview.

Despite their immense utility, Agent Skills introduce two critical structural challenges for SMEs. First, they create severe vulnerabilities to *Indirect Prompt Injection (IPI) attacks* @gulyamov2026prompt. Attackers can conceal malicious commands within the Markdown body or YAML frontmatter of a `SKILL.md` file, using tactics like hidden Unicode tags or out-of-scope parameters to trick the AI into executing unauthorized actions, such as exfiltrating private data @zhang2025msb. Second, the unstructured and verbose nature of custom SME instructions worsens the "Context Tax"—a computational burden where bloated contextual history causes the model to consume massive amounts of costly tokens without improving task performance @fraser2025cutting.

== Aims and Objectives
*The primary aim of this research is to design, construct, and evaluate a fine-tuned Small Language Model (SLM) proxy that secures SME workflows by auditing and compressing `SKILL.md` files, protecting them against Indirect Prompt Injections (IPIs) and mitigating the "Context Tax."*

To achieve this overarching aim, the following objectives have been established:
+ *Synthesize* a targeted training dataset of exactly 1,054 instances comprising both benign and maliciously poisoned `SKILL.md` files based on established prompt injection taxonomies @zhan2024injecagent.
+ *Fine-tune* the Gemma 4 E2B SLM via Supervised Fine-Tuning (SFT) using Low-Rank Adaptation (LoRA) to successfully classify security risks (Security Audit) and distill skill metadata (Semantic Distillation) @unsloth2026finetuning.
+ *Evaluate* the proxy’s performance by quantitatively measuring its Security Efficacy via the Attack Success Rate (ASR-valid), format integrity, and Token Compression Ratio.

== Approach Used
This dissertation adopts a *Design Science Research (DSR)* methodology, which focuses on constructing and rigorously evaluating a functional artifact to solve a practical, real-world problem @zupan2025developing. The core artifact is a secure middleware proxy powered by Google DeepMind's *Gemma 4 E2B*, a 9-billion parameter Small Language Model optimized for tool use and long-context workflows @unsloth2026gemma4.

The approach utilizes Parameter-Efficient Fine-Tuning (PEFT) via LoRA within the Unsloth framework. This method ensures the deployed model can be quantized to 4-bit precision, allowing it to run locally on standard consumer hardware with just 5GB of RAM—directly aligning with SME hardware constraints @unsloth2026gemma4. The proxy is trained to perform two automated passes on custom `SKILL.md` files before they reach downstream operational AI agents: Pass A to flag and neutralize IPI attacks @zhang2025msb, and Pass B to actively compress verbose metadata to eliminate context bloat @fraser2025cutting.

== Assumptions
This research is based on several foundational assumptions:
- *Adoption Trends:* It assumes that SMEs will increasingly adopt lightweight, structured Agent Skills (`SKILL.md` files) to grant specialized knowledge to LLMs, rather than hosting complex, heavy MCP servers themselves @whittaker2026mcp.
- *Adversarial Threat Models:* It assumes that malicious actors will utilize IPI techniques targeting structured metadata, such as preference manipulation and hidden obfuscation, mirroring the attack taxonomies defined by @zhan2024injecagent and @zhang2025msb.
- *Synthetic Data Validity:* Given the scarcity of real-world databases containing poisoned SME tools, this work assumes that a synthetic dataset constructed via Frontier Model Distillation and the INJECAGENT combinatorics methodology accurately reflects potential real-world adversarial threats (@zhan2024injecagent; @unsloth2026gemma4).

== Limitations and Achievements
*Limitations:* Because the dataset is entirely synthesized, the proxy's defensive capabilities are intrinsically bound to the specific threat models explicitly documented in the MSB and INJECAGENT taxonomies (@zhan2024injecagent; @zhang2025msb). As AI hacking techniques evolve rapidly, the fine-tuned model may struggle against entirely novel, zero-day injection paradigms without subsequent retraining @gulyamov2026prompt. Furthermore, the evaluation is primarily quantitative (calculating automated success and pass rates) and does not deploy the artifact into a live, active SME operational environment for longitudinal study.

*Achievements:* Despite these limitations, this research is expected to deliver a highly practical, deployable solution to a pressing industry vulnerability. By proving that a 9-billion parameter SLM can successfully filter complex IPI attacks and optimize context usage, this study challenges the prevailing assumption that massive LLMs are strictly required for reliable context routing and security screening @jhandi2026small. It actively bridges the gap between SME resource limitations and critical AI security needs.

== Overview of the Dissertation Structure
The remainder of this dissertation is organized as follows:
- *Chapter 2: Literature Review:* Critically examines the current landscape of AI adoption in SMEs, the evolution from basic LLMs to MCP tool-calling agents, the mechanics of Indirect Prompt Injections, and the efficacy of SLMs in handling specialized tasks.
- *Chapter 3: Methodology:* Details the Design Science Research (DSR) strategy, focusing on the synthesis of the 1,054-item dataset derived from the INJECAGENT matrix and the configuration parameters for Supervised Fine-Tuning (SFT).
- *Chapter 4: Artifact Implementation:* Describes the technical execution of fine-tuning the Gemma 4 E2B model using Unsloth and LoRA adapters.
- *Chapter 5: Evaluation and Results:* Presents a quantitative assessment of the proxy's performance against unseen adversarial holdout data, measuring the Attack Success Rate (ASR-valid), Format Pass Rate, and Token Compression Ratio.
- *Chapter 6: Conclusion:* Summarizes the findings, reviews the extent to which the research objectives were met, and proposes directions for future research into SLM security implementations.

// ════════════════════════════════════════════════════════════════════════════
// CHAPTER 2 — BACKGROUND / LITERATURE REVIEW  (§3.1.1)
//
// This chapter should provide (§3.1.1):
//   - The wider context of the project
//   - A critical literature review
// Begin with a brief introduction; end with a brief summary. (§3.2.2)
// ════════════════════════════════════════════════════════════════════════════
= Literature Review

This chapter establishes the theoretical context of the research. Section 2.1
provides an overview of formal logic. Section 2.2 examines propositional logic
in detail, including its principal connectives. Section 2.3 considers predicate
logic and its role in analytical frameworks.

== Overview of Formal Logic

Formal logic provides a rigorous framework for expressing and evaluating
arguments. The two principal branches relevant to this study are propositional
logic (see Section 2.2) and predicate logic (see Section 2.3). According to
@sanchez2025artificial, formal methods have been applied to software analysis
since the early 1970s. More recently, their application has extended to
information retrieval and data analysis @ode2026ai.

// CITATION GUIDE (§3.3.2) — Harvard system used exclusively:
//   Both names not in sentence:   (Surname Year)       e.g. (Knuth 1969)
//   Names in sentence:             Surname (Year)       e.g. Knuth (1969)
//   Three or more authors:         (Smith et al. Year)  e.g. (Smith et al. 2010)
//   Same applies to editors.

== Propositional Logic

Propositional logic deals with statements that are either true or false. It
has been applied extensively to database query optimisation @raghunathan2025agents.
The standard connectives are summarised in @tbl-connectives.

// FIGURE/TABLE RULES (§3.3.5 / §3.5.7):
//   - Label format: Figure C.N  /  Table C.N  (C = chapter, N = index)
//   - Caption/title at the TOP of the figure or table
//   - Source note at the BOTTOM where data are taken from another work
//   - Every figure and table MUST be referred to in the text by full name
//   - Use @label in text: "as shown in @fig-overview" → "Figure 2.1"
//   - Figures and tables use INDEPENDENT numbering sequences (§3.5.7)

#figure(
  table(
    columns: 3,
    stroke: 0.5pt,
    [*Connective*], [*Symbol*], [*Meaning*],
    [Conjunction], [$and$], [Both P and Q are true],
    [Disjunction], [$or$], [At least one of P or Q is true],
    [Negation], [$not$], [P is false],
    [Implication], [$=>$], [If P is true then Q is true],
    [Biconditional], [$<=>$], [P is true if and only if Q is true],
  ),
  caption: [Standard propositional connectives],
) <tbl-connectives>

// To add a source note beneath a table or figure, place it immediately
// after the #figure block like this:
// #text(size: 10pt)[_Source:_ Adapted from Knuth (1969, p. 42).]

=== Connectives and Truth Tables

The connectives listed in @tbl-connectives form the basis of propositional
reasoning. Truth tables provide a systematic means of evaluating complex
formulae constructed from these connectives.

== Predicate Logic

Predicate logic extends propositional logic by introducing quantifiers and
variables, enabling statements about entire classes of objects.
@fig-logic-overview illustrates the relationship between the two branches.

#figure(
  rect(
    width: 60%,
    height: 4cm,
    fill: luma(230),
    align(center + horizon)[_Replace this placeholder with your actual diagram_],
  ),
  caption: [Overview of formal logic branches],
) <fig-logic-overview>

This chapter has established that formal logic, in both its propositional
and predicate forms, provides a suitable theoretical foundation for the
analytical framework developed in this research.

// ════════════════════════════════════════════════════════════════════════════
// CHAPTER 3 — METHODOLOGY  (§3.1.2)
//
// Explain (§3.1.2):
//   - How you went about the project (deductive/inductive logic, etc.)
//   - How hypotheses or research objectives were operationalised
//   - Justification for the choice of research method
//   - How data were collected and analysed
//   - Validity, reliability and objectivity (§2.3)
//   - Limitations of the research design
// ════════════════════════════════════════════════════════════════════════════
= Methodology

This chapter describes the research design adopted for this study.
Section 3.1 presents the overall research design. Section 3.2 describes
data collection procedures. Section 3.3 addresses validity, reliability
and objectivity.

== Research Design

A deductive approach was adopted: a theoretical framework was derived
from the literature (Chapter 2) and subsequently tested against empirical
data. A mixed-methods design was employed, combining a structured
literature review with a quantitative evaluation experiment. This choice
is justified by the need both to contextualise the framework within
existing theory and to measure its performance objectively @zupan2025developing.

== Data Collection

Primary data were collected via a controlled laboratory experiment.
Participants were recruited from among postgraduate students at the
Cardiff School of Technologies. Full ethical approval was obtained prior
to data collection. A pilot study was conducted with five participants to
refine the experimental protocol before the main data collection phase.

Secondary data were drawn from peer-reviewed journal articles and
conference proceedings identified through searches of the ACM Digital
Library and IEEE Xplore, using the keywords "formal logic",
"data analysis" and "information systems".

== Validity, Reliability and Objectivity

The validity of the measurement instrument was assessed through the pilot
study described above. Reliability was ensured by a test-retest procedure
administered two weeks apart; the resulting correlation coefficient
indicated acceptable consistency. Steps were taken to minimise
experimenter bias by standardising all written instructions given to
participants @gulyamov2026prompt.

A limitation of this study is the use of a convenience sample of
postgraduate students, which may restrict generalisability. This is
acknowledged and discussed further in Chapter 5.

// ════════════════════════════════════════════════════════════════════════════
// CHAPTER 4 — RESULTS
//
// Present data in a logical fashion (§3.1.3).
// Use tables and figures to summarise and emphasise points.
// Make clear whether this is a pure results chapter or results+discussion.
// ════════════════════════════════════════════════════════════════════════════
= Results

This chapter presents the data collected during the experimental phase.
Section 4.1 reports the quantitative findings. Section 4.2 summarises
qualitative observations.

== Quantitative Findings

Accuracy scores for the baseline and proposed conditions are shown in
@tbl-results.

#figure(
  table(
    columns: 3,
    stroke: 0.5pt,
    [*Condition*], [*Mean accuracy (%)*], [*Std. dev.*],
    [Baseline], [72.4], [5.1],
    [Proposed], [84.7], [3.8],
  ),
  caption: [Accuracy results by experimental condition (_n_ = 30)],
) <tbl-results>

The proposed method achieved a mean accuracy of 84.7%, compared with
72.4% for the baseline, representing an improvement of 12.3 percentage
points. The distribution of scores across conditions is illustrated in
@fig-results.

#figure(
  rect(
    width: 70%,
    height: 5cm,
    fill: luma(240),
    align(center + horizon)[_Replace with your results chart_],
  ),
  caption: [Distribution of accuracy scores by condition],
) <fig-results>

== Qualitative Findings

Participant responses identified three recurring themes: clarity of
output, ease of integration with existing tools, and reduced cognitive
load. These themes are discussed in Chapter 5.

// ════════════════════════════════════════════════════════════════════════════
// CHAPTER 5 — DISCUSSION
//
// This is the key section for demonstrating analytical skills (§3.1.3).
// Move beyond the data; contextualise findings in relation to literature.
// Compare results with the work of others and explain differences (§3.1.3).
// ════════════════════════════════════════════════════════════════════════════
= Discussion

This chapter interprets the findings presented in Chapter 4 in relation
to the research question and the existing literature. Section 5.1
addresses the quantitative findings. Section 5.2 considers the
qualitative themes. Section 5.3 acknowledges limitations.

== Quantitative Results

The improvement in accuracy of 12.3 percentage points is consistent with
the theoretical prediction established in Chapter 3. This finding aligns
with the work of @sanchez2025artificial, who demonstrated comparable
gains in the context of database query optimisation.

== Qualitative Themes

The qualitative finding that participants valued clarity and integration
over raw performance suggests that usability is a critical factor in the
adoption of such frameworks. This dimension was not captured by the
accuracy metric and represents an avenue for further investigation.

== Limitations

The primary limitation of this study is the use of a convenience sample,
which may reduce the generalisability of the findings to other
populations. The controlled laboratory setting may not fully reflect the
complexity of real-world deployments.

// ════════════════════════════════════════════════════════════════════════════
// CHAPTER 6 — CONCLUSIONS  (§3.4.8)
//
// Must (§3.4.8):
//   - Summarise the project and restate its main results
//   - Address each objective in turn
//   - Comment on the aim
//   - State whether the hypothesis was proved or disproved
//   - NOT introduce new material
//   - Include a section on future work
// ════════════════════════════════════════════════════════════════════════════
= Conclusions

This chapter summarises the project, addresses each objective, and
proposes directions for future work.

The aim of this dissertation was to investigate whether a logic-based
analytical framework could improve accuracy in information systems
analysis. Three objectives were established (Chapter 1); all three have
been fully addressed.

Objective 1 — to critically review existing frameworks — was addressed
in Chapter 2, which identified formal logic as a well-established but
underexplored foundation for analytical tools.

Objective 2 — to develop a novel framework — was addressed in Chapter 3,
where the design and operationalisation of the proposed approach were
described in detail.

Objective 3 — to evaluate the framework empirically — was addressed in
Chapters 4 and 5. The proposed method achieved 84.7% mean accuracy
compared with 72.4% for the baseline.

The hypothesis — that the logic-based framework would yield measurably
higher accuracy — is supported by the experimental evidence. The null
hypothesis is therefore rejected at the conventional significance level.

The principal limitation of the study is the sample size and setting;
future research should replicate the findings with larger, more diverse
participant groups in operational environments.

It is concluded that formal logic offers a viable and demonstrably
effective foundation for analytical frameworks in information systems,
and that the approach merits further development and deployment.

// ════════════════════════════════════════════════════════════════════════════
// BIBLIOGRAPHY  (§3.4.11)
//
// PREFERRED: Use a .bib file and replace this block with:
//   #pagebreak()
//   #align(center, text(weight: "bold", size: 12pt, upper[Bibliography]))
//   #bibliography("references.bib")
//
// Harvard format rules (§3.4.11):
//   Papers:   Surname, I. Year 'Title of paper'. _Journal_ *vol*(issue) pp.x–y.
//   Books:    Surname, I. Year _Title of Book_. Place: Publisher.
//   Chapters: Surname, I. Year 'Chapter title', in: _Book Title_, ed. Name. Place: Publisher, pp.x–y.
//   Online:   Surname, I. Year _Title_ [online]. Place: Publisher. Available from: URL [Accessed DD Mon YYYY].
//
// Entries must be:
//   - Alphabetical by author surname
//   - Single-spaced with one blank line between entries
//   - ALL sources cited in the text must appear here, and vice versa
// ════════════════════════════════════════════════════════════════════════════
#pagebreak()
#align(center, text(weight: "bold", size: 12pt, upper[Bibliography]))
#v(2em)

#bibliography("references.bib")

// ════════════════════════════════════════════════════════════════════════════
// GLOSSARY AND TABLE OF ABBREVIATIONS  (§3.4.9)
// Include if you use abbreviations, obscure terms, or acronyms extensively.
// Explain each term where it first occurs in the text, then list all here
// so readers can quickly look them up. Delete this section if not needed.
// ════════════════════════════════════════════════════════════════════════════
#pagebreak()
#align(center, text(weight: "bold", size: 12pt, upper[Glossary and Abbreviations]))
#v(2em)

#set par(spacing: 0.6em, leading: 0.75em)

#table(
  columns: (auto, 1fr),
  stroke: none,
  inset: (x: 2pt, y: 4pt),
  [*IS*], [Information Systems],
  [*ML*], [Machine Learning],
  [*SMEs*], [Small and Medium-sized Enterprises],
)

// ════════════════════════════════════════════════════════════════════════════
// APPENDICES  (§3.4.10)
//
// Headed by letters in alphabetic order: Appendix A, Appendix B, etc.
// Sub-sections within appendices use the format A.1, A.2, A.1.1, etc. (§3.5.6)
// Use appendices for material that would obstruct the flow of the main body.
// ════════════════════════════════════════════════════════════════════════════
#pagebreak()
#align(center, text(weight: "bold", size: 12pt)[APPENDIX A: SURVEY INSTRUMENT])
#v(2em)

The following questionnaire was used to collect primary data during the
experimental phase. Each item was rated on a five-point Likert scale
(1 = Strongly Disagree, 5 = Strongly Agree).

#v(1em)
*A.1 Section 1: Usability*

+ The output of the analytical framework was easy to understand.
+ The framework integrated well with the existing tools in use.
+ Using the framework reduced the mental effort required during analysis.
+ It would be recommended to a colleague working in a similar context.

#v(1em)
*A.2 Section 2: Performance*

+ The framework produced results more quickly than the previous approach.
+ The accuracy of results was satisfactory for the task at hand.

// Add further appendices (Appendix B, Appendix C …) as needed, each
// beginning with a #pagebreak() and a centred bold heading.
