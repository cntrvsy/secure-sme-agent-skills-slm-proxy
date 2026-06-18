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
    Insert Here........
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
Approximately 90% of all businesses and more than 50% of all jobs globally are small and medium-sized firms (SMEs), which serve as the foundation of the global economy @sanchez2025artificial. These businesses urgently need to implement Artificial Intelligence (AI) to automate repetitive operations, optimise workflows, and boost operational productivity in order to stay competitive in an increasingly digital economy @ode2026ai. However, SMEs often face a "Operational Paradox": they lack the substantial financial resources, specialised IT infrastructure, and technical staff needed to run or administer big, general-purpose AI models @sanchez2025artificial, despite their dire need for automation to grow.

AI has recently progressed beyond passive conversational chatbots to self-governing "agents" that can communicate with external surroundings and systems @zhan2024injecagent. The Model Context Protocol (MCP), which serves as a global "USB-C port" for AI applications, was developed to standardise how AI accesses external tools @whittaker2026mcp. SMEs are increasingly depending on a lightweight substitute called *Agent Skills* @whittaker2026mcp, whereas big IT firms are capable of managing complicated MCP server infrastructure. The AI receives reusable procedural knowledge and commands via Agent Skills, which are standardised, version-controlled directories anchored by a `SKILL.md` file @agentskills2026overview. Agents load these skills using "progressive disclosure," reading only the most basic metadata at first and only expanding the entire instructions into their context window when the task @agentskills2026overview specifically requests it.

Agent skills present two significant structural hurdles for SMEs, notwithstanding their enormous utility. Initially, they make it extremely vulnerable to *Indirect Prompt Injection (IPI) attacks* @gulyamov2026prompt. In order to deceive the AI into carrying out unauthorised operations, such as exfiltrating private data @zhang2025msb, attackers can include malicious commands within the Markdown body or YAML frontmatter of a `SKILL.md` file using strategies like hidden Unicode tags or out-of-scope parameters. Second, the "Context Tax": a computational penalty where inflated contextual history causes the model to consume enormous amounts of expensive tokens without enhancing task performance @fraser2025cutting. This is exacerbated by the unstructured and verbose nature of custom SME instructions.

== Aims and Objectives
*The primary aim of this research is to design, construct, and evaluate a fine-tuned Small Language Model (SLM) proxy that secures SME workflows by auditing and compressing `SKILL.md` files, protecting them against Indirect Prompt Injections (IPIs) and mitigating the "Context Tax."*

To achieve this overarching aim, the following objectives have been established:
+ *Synthesize* a targeted training dataset of exactly 1,054 instances comprising both benign and maliciously poisoned `SKILL.md` files based on established prompt injection taxonomies @zhan2024injecagent.
+ *Fine-tune* the Gemma 4 E2B SLM via Supervised Fine-Tuning (SFT) using Low-Rank Adaptation (LoRA) to successfully classify security risks (Security Audit) and distill skill metadata (Semantic Distillation) @unsloth2026finetuning.
+ *Evaluate* the proxy’s performance by quantitatively measuring its Security Efficacy via the Attack Success Rate (ASR-valid), format integrity, and Token Compression Ratio.

== Approach Used
This dissertation adopts a *Design Science Research (DSR)* methodology, which focuses on constructing and rigorously evaluating a functional artifact to solve a practical, real-world problem @zupan2025developing. The core artifact is a secure middleware proxy powered by Google DeepMind's *Gemma 4 E2B*, a 9-billion parameter Small Language Model optimized for tool use and long-context workflows @unsloth2026gemma4.

The approach utilizes Parameter-Efficient Fine-Tuning (PEFT) via LoRA within the Unsloth framework. This method ensures the deployed model can be quantized to 4-bit precision, allowing it to run locally on standard consumer hardware with just 5GB of RAM: directly aligning with SME hardware constraints @unsloth2026gemma4. The proxy is trained to perform two automated passes on custom `SKILL.md` files before they reach downstream operational AI agents: Pass A to flag and neutralize IPI attacks @zhang2025msb, and Pass B to actively compress verbose metadata to eliminate context bloat @fraser2025cutting.

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
This chapter critically examines the current literature surrounding the operationalisation, security, and optimisation of artificial intelligence within Small and Medium-sized Enterprises (SMEs). Before delving into the architectural transition from monolithic Large Language Models (LLMs) to tool-integrated Agentic AI via the Model background Protocol (MCP) and Agent Skills, the broader background of the SME "Operational Paradox" is established. The article then assesses the growing body of research on the use of optimised Small Language Models (SLMs) as effective, secure middleware solutions and critically examines the serious security flaws brought about by these architectures, including Indirect Prompt Injections (IPIs).

== The SME Operational Paradox and Digital Adoption
Approximately 90% of all businesses and more than 50% of all jobs globally are small and medium-sized firms (SMEs), which form the foundation of the global economy @sanchez2025artificial. SMEs are realising that artificial intelligence (AI) is a strategic necessity to boost automation, improve operational efficiency, and spur growth in order to stay competitive in an increasingly digital environment. This quick adoption is supported by recent empirical data; according to a 2026 report on UK businesses, 35% of SMEs are currently actively adopting AI technology—a significant increase from the previous year—mainly to expedite daily operations, carry out research, and manage administrative duties @lewis2026uk. Similarly, regional research shows that 65% of SMEs use AI for data analysis and content production @ode2026ai.

Nevertheless, significant systemic weaknesses are hidden by these surface-level adoption measurements. SMEs are aggressively experimenting with AI, but they are unable to operationalise the technology to produce revolutionary outcomes due to significant structural constraints. According to empirical data, substantial knowledge gaps, which were mentioned by 77% of SME respondents, as well as severe time, resource, and financial constraints, are the main barriers to deep AI integration @ode2026ai. Additionally, SMEs often have dispersed data silos, disjointed legacy systems, and lax security and identity restrictions, all of which make it extremely difficult to deploy autonomous AI in a safe and dependable manner @lewis2026uk.

The "Operational Paradox" @sanchez2025artificial is the result of these compounding limitations. On the one hand, in order to overcome resource constraints, scale operations, and endure in a market that is changing quickly, SMEs desperately need AI-driven automation. However, they inherently lack the funding, sophisticated technology infrastructure, and skilled workers needed to securely host, deploy, or secure large AI models @sanchez2025artificial. Because SMEs have smaller profit margins and less absorptive capacity than major multinational corporations, the high upfront costs and intricate upkeep of reliable AI systems are both technically and financially prohibitive @sanchez2025artificial.

As a result, SMEs and larger tech-enabled businesses are seeing a growing digital divide @lewis2026uk. Many SMEs are left depending on disjointed, superficial tools that are unable to connect with one another, whereas highly resourced corporations are completely redesigning their operational models with secure, integrated AI architectures that save entire weeks of manual effort @lewis2026uk. SMEs are at a serious, compounding competitive disadvantage in the digital economy because of this operational imbalance, which frequently results in their just cutting minutes off peripheral activities @lewis2026uk.

// CITATION GUIDE (§3.3.2) — Harvard system used exclusively:
//   Both names not in sentence:   (Surname Year)       e.g. (Knuth 1969)
//   Names in sentence:             Surname (Year)       e.g. Knuth (1969)
//   Three or more authors:         (Smith et al. Year)  e.g. (Smith et al. 2010)
//   Same applies to editors.

== The Evolution of Agentic AI: MCP vs. Agent Skills
The methods by which these agents interact with the outside world have emerged as a key area of industry development as AI progresses from passive conversational models to autonomous systems. The Model Context Protocol (MCP) was developed to standardise how AI agents find and engage with external data sources which include traditional relational databases, APIs, and other tools. MCP functions as a universal integration layer that standardises how models retrieve real-time data from external APIs; it is commonly referred to as the "USB-C for AI" @raghunathan2025agents, @clyburn2026mcp. MCP essentially gives the agent the "what", meaning the external interfaces and raw data required to complete a task @raghunathan2025agents. However, this architecture is too complicated and resource-intensive for typical SMEs because it requires specialised technical infrastructure and IT staff to configure, securely authenticate, and maintain operational MCP servers.

As a result, SMEs are embracing Agent Skills, a lighter and more accessible option. Agent Skills give the "HOW" if MCP specifies the "WHAT" by encoding reusable procedural knowledge, formatting standards, and domain expertise @raghunathan2025agents. The core SKILL.md file @agentskills2026overview serves as the foundation for an Agent Skill, which is a portable, version-controlled directory. These files use a Markdown body to give the LLM clear, detailed processes and operational limitations @agentskills2026overview, @whittaker2026mcp, combined with organised YAML frontmatter to define crucial metadata (such the skill's name and a brief description).
Giving LLMs access to outside resources greatly improves their capabilities, but it also causes considerable computing inefficiencies. This problem is critically examined by @fraser2025cutting, who show that feeding models bloated, unstructured tool descriptions causes context windows to rapidly widen. In addition to increasing costly API token use, this phenomenon—known as the "Context Tax", decreases downstream model performance since the AI finds it difficult to separate essential instructions from the noise @fraser2025cutting.

Agent Skills uses "progressive disclosure" @agentskills2026overview, an active context management technique, to address the Context Tax. Progressive disclosure guarantees that the agent loads only the minimal YAML metadata (roughly 20 to 50 tokens) during the discovery phase, as opposed to loading massive, monolithic tool definitions upfront, which can easily consume tens of thousands of tokens and instantly exhaust a model's memory @whittaker2026mcp. Only when a particular task actively activates the skill @agentskills2026overview, @whittaker2026mcp will the complete, verbose Markdown instructions be dynamically brought into the agent's context window. Agent Skills is computationally and fiscally feasible for SMEs thanks to its simplified architecture, but when those dynamically loaded files are altered, it immediately creates special security risks.

// FIGURE/TABLE RULES (§3.3.5 / §3.5.7):
//   - Label format: Figure C.N  /  Table C.N  (C = chapter, N = index)
//   - Caption/title at the TOP of the figure or table
//   - Source note at the BOTTOM where data are taken from another work
//   - Every figure and table MUST be referred to in the text by full name
//   - Use @label in text: "as shown in @fig-overview" → "Figure 2.1"
//   - Figures and tables use INDEPENDENT numbering sequences (§3.5.7)

#figure(
  table(
    columns: (1.2fr, 2fr, 2fr),
    stroke: 0.5pt,
    align: left,
    [*Feature / Dimension*], [*Model Context Protocol (MCP)*], [*Agent Skills (`SKILL.md`)*],
    [Core Function],
    [Supplies the AI with the "WHAT"—access to raw data and external interfaces @raghunathan2025agents.],
    [Supplies the AI with the "HOW"—domain expertise and reusable procedural knowledge @raghunathan2025agents.],

    [Architecture],
    [Highly structured, deterministic tool integration utilizing standardized schemas and SDKs @whittaker2026mcp.],
    [Lightweight, semi-unstructured Markdown directories acting as "ephemeral information clouds" @whittaker2026mcp.],

    [Primary Use Cases],
    [Real-time data retrieval, secure API execution, and enterprise system integration @clyburn2026mcp.],
    [Consistent output formatting, enforcing organizational standards, and step-by-step guidance @clyburn2026mcp.],

    [Infrastructure],
    [Requires actively maintained, dedicated server infrastructure and complex authentication @clyburn2026mcp.],
    [Serverless, portable, version-controlled directories that can be stored locally @agentskills2026overview.],

    [Integration Nature],
    [Fixed, rigid connection endpoints designed for stable, predictable workflows @whittaker2026mcp.],
    [Highly adaptive and exploratory, loaded dynamically based on conversational context @whittaker2026mcp.],
  ),
  caption: [Architectural and Functional Contrasts Between MCP and Agent Skills],
) <tbl-mcp-vs-skills>


// To add a source note beneath a table or figure, place it immediately
// after the #figure block like this:
// #text(size: 10pt)[_Source:_ Adapted from Knuth (1969, p. 42).]

=== Key Differences and Architectural Analysis
As illustrated in @tbl-mcp-vs-skills, the fundamental divergence between MCP and Agent Skills lies in their operational objectives and resource demands. MCP prioritizes deterministic execution and secure, real-time connectivity, making it ideal for robust enterprise infrastructures. Conversely, Agent Skills serve as localized, lightweight repositories of procedural knowledge that require zero active server footprints, making them highly suitable for resource-constrained SME environments.

== The Security Threat: Indirect Prompt Injections (IPI) in Tool-Calling
Giving LLMs access to external tools significantly increases their capabilities, but it also drastically changes their threat model. The Indirect Prompt Injection (IPI) attack is this paradigm's most serious flaw. It's important to differentiate IPI from conventional "jailbreaking." As @gulyamov2026prompt points out, prompt injection modifies the model's fundamental functional behaviour completely without the user's knowledge, whereas jailbreaking entails a user purposefully trying to get around a model's security measures to produce limited content. When an LLM analyses external, attacker-controlled information that contains concealed harmful instructions @gulyamov2026prompt, such as a retrieved file, website, or email, IPIs happen.

This vulnerability arises from a basic architectural limitation: LLMs interpret all inputs as undifferentiated, unstructured natural language @gulyamov2026prompt, in contrast to traditional software that strictly isolates executable code from data payloads through defined syntax. As a result, the model is unable to draw a clear semantic distinction between untrusted external data and trustworthy system commands. This leads to a risky "confused deputy" situation in which the agent uses its authorised access credentials and permissions to carry out the attacker's commands @gulyamov2026prompt.

The INJECAGENT benchmark, created by @zhan2024injecagent, systematically illustrates the severity of IPIs in tool-calling agents. By just reading poisoned external material, agents can be readily manipulated into compromising systems, as demonstrated by their empirical research. These attacks are divided into two main categories by @zhan2024injecagent:
- *Direct Harm Attacks*: The agent is duped into carrying out illegal, practical activities, including starting fraudulent financial transactions or tampering with the infrastructure of smart homes.
- *Data Stealing Attacks*: A two-step procedure in which the agent secretly obtains sensitive user information (such as saved payment methods) and then uses a messaging tool to exfiltrate that data to a server under the attacker's control. According to their research, even sophisticated, safety-aligned models show startlingly high Attack Success Rates (ASR) when exposed to these vectors @zhan2024injecagent.

The Model Context Protocol Security Bench (MSB) created by @zhang2025msb shows that the integration tools themselves can be weaponised, despite INJECAGENT's primary focus on contaminated external data. A thorough taxonomy of MCP-specific vulnerabilities is established by @zhang2025msb, with a particular emphasis on "Tool Signature Attacks." In order to trick the agent's routing and planning logic, these attacks alter tool metadata. "Name Collision" (making malicious tools with names that are nearly identical to innocent ones) and "Preference Manipulation" (inserting promotional words into a tool's description to force the LLM to prioritise it) are two examples of specific vectors @zhang2025msb. Additionally, attackers can fool the model into providing out-of-scope parameters in order to leak sensitive data, or they can incorporate hidden "Prompt Injections" directly into tool descriptions @zhang2025msb.

These results pose a serious threat to SME architectures that depend on Agent Skills. Attackers can readily weaponise skill metadata using these precise MSB attack vectors since SKILL.md directories contain Markdown bodies to specify capabilities and structured YAML frontmatter that expressly relies on name and description fields. An adversary can fully take over the SME's agentic workflow during the first progressive disclosure phase, even before the underlying task is carried out, by concealing obfuscated directives within the frontmatter of a custom skill @zhang2025msb.

== SLMs as Efficient and Secure Proxies
In the AI sector, it is widely believed that large, generalised Large Language Models (LLMs) like GPT-4 or Claude are necessary for extremely complex tasks like context routing, security filtering, and deterministic tool execution. Recent empirical research, however, shows that using such models is not only computationally superfluous for specialised operations but also financially prohibitive for SMEs. The "scaling law" paradigm is challenged by a seminal work by @jhandi2026small, which demonstrates that when subjected to targeted fine-tuning, Small Language Models (SLMs) can dramatically outperform their giant counterparts. An optimised 350-million parameter SLM obtained a 77.55% success rate in tool execution, significantly surpassing a 175-billion parameter GPT model (which scored only 26.00%), according to @jhandi2026small's examination of agentic tool-calling and structured data interpretation.By avoiding the overhead and overgeneralisation common to big models @jhandi2026small, this breakthrough in parameter efficiency demonstrates that targeted fine-tuning produces domain specialists in structured tool manipulation.

Researchers are increasingly using Supervised Fine-Tuning (SFT) enhanced by Parameter-Efficient Fine-Tuning (PEFT) techniques to operationalise these SLMs within the harsh hardware restrictions of SMEs. By freezing the underlying model and optimising only a small set of additional low-rank matrices, Low-Rank Adaptation (LoRA) greatly reduces computational memory requirements, as @zupan2025developing investigates in the development of specialised accounting assistants. Frameworks like as Unsloth, which enable QLoRA, a technique that combines LoRA with 4-bit precision quantisation @unsloth2026finetuning, further optimise this process.Researchers are increasingly using Supervised Fine-Tuning (SFT) enhanced by Parameter-Efficient Fine-Tuning (PEFT) techniques to operationalise these SLMs within the harsh hardware restrictions of SMEs. By freezing the underlying model and optimising only a small set of additional low-rank matrices, Low-Rank Adaptation (LoRA) greatly reduces computational memory requirements, as @zupan2025developing investigates in the development of specialised accounting assistants. Frameworks like as Unsloth, which enable QLoRA, a technique that combines LoRA with 4-bit precision quantisation @unsloth2026finetuning, further optimise this process.

Because of its unique architectural design, Gemma 4 E2B is especially well-suited to serve as a SME security proxy. According to @unsloth2026gemma4, Gemma 4 has a "hybrid-thinking" architecture, which means that the model is taught to provide an internal reasoning channel prior to providing a final solution. This allows the model to thrive in intricate agentic and tool-use workflows. Additionally, Gemma 4 natively supports huge context windows of up to 128K tokens @unsloth2026gemma4, in contrast to earlier SLMs that had trouble with context retention. Its high-speed 4-bit local execution and long-context capability offer the precise infrastructure needed to read verbose, unstructured SKILL.md folders. Because of its unique architectural design, Gemma 4 E2B is especially well-suited to serve as a SME security proxy. According to @unsloth2026gemma4, Gemma 4 has a "hybrid-thinking" architecture, which means that the model is taught to provide an internal reasoning channel prior to providing a final solution. This allows the model to thrive in intricate agentic and tool-use workflows. Additionally, Gemma 4 natively supports huge context windows of up to 128K tokens @unsloth2026gemma4, in contrast to earlier SLMs that had trouble with context retention. Its high-speed 4-bit local execution and long-context capability offer the precise infrastructure needed to read verbose, unstructured SKILL.md folders.

== Research Gaps
A critical synthesis exposes important gaps at the junction of SME operational restrictions and agentic security, even though the research offers a solid foundation for comprehending AI adoption issues and the mechanics of fast insertion.

First, dynamic, server-side integrations are the main focus of current vulnerability benchmarks. For instance, using the MSB taxonomy, @zhang2025msb offers a very thorough benchmark for MCP vulnerabilities. However, as noted by @whittaker2026mcp and @clyburn2026mcp, ordinary SMEs often use lightweight Agent Skills (SKILL.md) since they lack the resources to operate complicated MCP servers. The literature on the particular security flaws of SME-centric Agent Skills is noticeably lacking, despite the quick uptake of this static, file-based integration technique. The YAML frontmatter and Markdown structures present in these directories may be exploited by attackers during the progressive disclosure phase, however this is not empirically addressed by current benchmarks.

Second, enterprise-scale environments are the primary focus of the defence methods suggested in the existing research. Current defences against IPIs mostly rely on using sophisticated cryptographic protocols, deploying large LLMs as security judges, or executing agents in computationally demanding, simulated sandboxes @gulyamov2026prompt. The "Operational Paradox" that SMEs @sanchez2025artificial confront is essentially ignored by these resource-intensive defences, depriving them of a workable, affordable defence.

Lastly, context optimisation and security are treated as mutually exclusive research areas in the literature. Some researchers, like @fraser2025cutting, concentrate only on the financial impact of the "Context Tax," while others, like @zhan2024injecagent, strictly concentrate on neutralising IPIs. Empirical studies examining the dual-purpose use of SLMs are conspicuously lacking. The use of a highly specialised, optimised SLM (like Gemma 4 E2B) as an active, local middleware proxy that can concurrently filter IPI attacks and compress superfluous metadata prior to downstream execution has not been thoroughly studied.

== Summary
This chapter has demonstrated that although Agent Skills provide SMEs with an essential, lightweight route to AI automation @whittaker2026mcp, @agentskills2026overview, they also introduce computationally expensive context bloat @fraser2025cutting and serious IPI vulnerabilities @gulyamov2026prompt. A comprehensive assessment of the literature exposes a major gap: the static SKILL.md pipelines of SMEs are mostly vulnerable because existing security evaluations primarily concentrate on active MCP servers and big LLMs @zhang2025msb. However, recent developments in Supervised Fine-Tuning show that in extremely particular tasks, SLMs can successfully outperform generalised models @jhandi2026small, @zupan2025developing. In order to fill the identified vacuum in the literature, this study suggests building and testing a refined Gemma 4 E2B SLM @unsloth2026gemma4 to serve as a safe, token-efficient vetting proxy for SME operations.



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

The methodological methodology used to create and assess the secure Small Language Model (SLM) proxy is described in this chapter. It starts by defending the choice of a Design Science Research (DSR) approach, outlining how the combined emphasis on rigorous evaluation and artefact development is especially well-suited to resolving the SME "Operational Paradox." The chapter then offers a thorough analysis of the programmatic matrix synthesis that produced the 1,054-item SKILL.md dataset. Lastly, it describes the quantitative measures used to assess the security and compression effectiveness of the artefact and describes the Supervised Fine-Tuning (SFT) processes using Low-Rank Adaptation (LoRA).

== Research Strategy: Design Science Research

A Design Science Research (DSR) approach is used in this dissertation. DSR is a proactive, problem-solving paradigm in contrast to purely theoretical or empirical research methodologies, which mainly aim to observe, characterise, or explain a given event. By developing novel and inventive artefacts to address useful, real-world problems, it aims to expand the limits of human and organisational capacities.

A purely empirical approach to this research would simply evaluate the computational load of the "Context Tax" in small and medium-sized businesses (SMEs) or monitor the phenomena of Indirect Prompt Injections (IPIs). Finding these weaknesses is important, but it doesn't offer a workable answer to the "Operational Paradox" facing SMEs. Because the main goal of this research is to actively develop a functioning, deployable solution, more precisely, a secure middleware proxy driven by a refined Gemma 4 E2B SLM, DSR is the ideal methodology. The practically important business issues of protecting Agent Skills (SKILL.md) and maximising token efficiency prior to downstream execution are specifically addressed by this artefact.
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
  [*IPI*], [Indirect Prompt Injection],
  [*ML*], [Machine Learning],
  [*SMEs*], [Small and Medium-sized Enterprises],
  [*LoRA*], [Low-Rank Adaptation],
  [*MCP*], [Model Context Protocol],
  [*SLMs*], [Small Language Models],
  [*LLMs*], [Large Language Models],
  [*AI*], [Artificial Intelligence],
  [*SFT*], [Supervised Fine-Tuning],
  [*RAG*], [Retrieval-Augmented Generation],
  [*L1*], [Level 1],
  [*L2*], [Level 2],
  [*TOE*], [Technology-Organisation-Environment],
  [*DOI*], [Diffusion of Innovations],
  [* AI Agent*],
  [An autonomous system defined by stateful cognitive loops (perception, reasoning, action, and memory). It dynamically adapts its execution path based on real-time feedback from its environment rather than following a rigid, predefined script.@gutowska2024ai],
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
