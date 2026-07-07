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
  degree: "Masters Degree in Computing and Information Technology",
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
Approximately 90% of all businesses and more than 50% of all jobs globally are small and medium-sized firms (SMEs), which serve as the foundation of the global economy @sanchez2025artificial. These businesses urgently need to implement Artificial Intelligence (AI) to automate repetitive operations, optimise workflows, and boost operational productivity in order to stay competitive in an increasingly digital economy @ode2026ai. However, SMEs often face an "Operational Paradox": they lack the substantial financial resources, specialised IT infrastructure, and technical staff needed to run or administer big, general-purpose AI models @sanchez2025artificial, despite their dire need for automation to grow.

AI has recently progressed beyond passive conversational chatbots to self-governing "agents" that can communicate with external surroundings and systems @zhan2024injecagent. The Model Context Protocol (MCP), which serves as a global "USB-C port" for AI applications, was developed to standardise how AI accesses external tools @whittaker2026mcp. SMEs are increasingly depending on a lightweight substitute called *Agent Skills* @whittaker2026mcp, whereas big IT firms are capable of managing complicated MCP server infrastructure. The AI receives reusable procedural knowledge and commands via Agent Skills, which are standardised, version-controlled directories anchored by a `SKILL.md` file @agentskills2026overview. Agents load these skills using "progressive disclosure," reading only the most basic metadata at first and only expanding the entire instructions into their context window when the task @agentskills2026overview specifically requests it.

Agent skills present two significant structural hurdles for SMEs, notwithstanding their enormous utility. Initially, they make these integrations extremely vulnerable to *Indirect Prompt Injection (IPI) attacks* @gulyamov2026prompt. In order to deceive the AI into carrying out unauthorised operations, such as exfiltrating private data @zhang2025msb, attackers can include malicious commands within the Markdown body or YAML frontmatter of a `SKILL.md` file using strategies like hidden Unicode tags or out-of-scope parameters. Second, the "Context Tax": a computational penalty where inflated contextual history causes the model to consume enormous amounts of expensive tokens without enhancing task performance @fraser2025cutting. This is exacerbated by the unstructured and verbose nature of custom SME instructions.

== Aims and Objectives
*The primary aim of this research is to design, construct, and evaluate a fine-tuned Small Language Model (SLM) proxy that secures SME workflows by auditing and compressing `SKILL.md` files, protecting them against Indirect Prompt Injections (IPIs) and mitigating the "Context Tax."*

To achieve this overarching aim, the following objectives have been established:
+ *Synthesize* a targeted evaluation corpus yielding 3,276 test instances across two modes (comprising 1,054 unique standard and 414 unique domain-aligned attack scenarios, each evaluated across Base and Enhanced settings, alongside 170 benign hard negative controls), representing 2,278 unique virtual test cases in total, operating as an in-memory JSON pipeline based on established prompt injection taxonomies @zhan2024injecagent.
+ *Fine-tune* the Gemma 4 E2B SLM via Supervised Fine-Tuning (SFT) using Low-Rank Adaptation (LoRA) to successfully classify security risks (Security Audit) and distill skill metadata (Semantic Distillation) @unsloth2026finetuning.
+ *Evaluate* the proxy’s performance by quantitatively measuring its Security Efficacy via the Attack Success Rate (ASR-valid), format integrity, and Token Compression Ratio.

== Approach Used
This dissertation adopts a *Design Science Research (DSR)* methodology, which focuses on constructing and rigorously evaluating a functional artifact to solve a practical, real-world problem @zupan2025developing. The core artifact is a secure middleware proxy powered by Google DeepMind's *Gemma 4 E2B*, a 2-billion parameter Small Language Model optimized for tool use and long-context workflows @unsloth2026gemma4.

The approach utilizes Parameter-Efficient Fine-Tuning (PEFT) via LoRA within the Unsloth framework. This method ensures the deployed model can be quantized to 4-bit precision, allowing it to run locally on standard consumer hardware with just 5GB of RAM: directly aligning with SME hardware constraints @unsloth2026gemma4. The proxy is trained to perform two automated passes on custom `SKILL.md` files before they reach downstream operational AI agents: Pass A to flag and neutralize IPI attacks @zhang2025msb, and Pass B to actively compress verbose metadata to eliminate context bloat @fraser2025cutting.

== Assumptions
This research is based on several foundational assumptions:
- *Adoption Trends:* It assumes that SMEs will increasingly adopt lightweight, structured Agent Skills (`SKILL.md` files) to grant specialized knowledge to LLMs, rather than hosting complex, heavy MCP servers themselves @whittaker2026mcp.
- *Adversarial Threat Models:* It assumes that malicious actors will utilize IPI techniques targeting structured metadata, such as preference manipulation and hidden obfuscation, mirroring the attack taxonomies defined by @zhan2024injecagent and @zhang2025msb.
- *Synthetic Data Validity:* Given the scarcity of real-world databases containing poisoned SME tools, this work assumes that a synthetic dataset constructed via Frontier Model Distillation and the INJECAGENT combinatorics methodology accurately reflects potential real-world adversarial threats (@zhan2024injecagent; @unsloth2026gemma4).

== Limitations and Achievements
*Limitations:* Because the dataset is entirely synthesized, the proxy's defensive capabilities are intrinsically bound to the specific threat models explicitly documented in the MSB and INJECAGENT taxonomies (@zhan2024injecagent; @zhang2025msb). As AI hacking techniques evolve rapidly, the fine-tuned model may struggle against entirely novel, zero-day injection paradigms without subsequent retraining @gulyamov2026prompt. Furthermore, the evaluation is primarily quantitative (calculating automated success and pass rates) and does not deploy the artifact into a live, active SME operational environment for longitudinal study.

*Achievements:* Despite these limitations, this research is expected to deliver a highly practical, deployable solution to a pressing industry vulnerability. By proving that a 2-billion parameter SLM can successfully filter complex IPI attacks and optimize context usage, this study challenges the prevailing assumption that massive LLMs are strictly required for reliable context routing and security screening @jhandi2026small. It actively bridges the gap between SME resource limitations and critical AI security needs.

== Overview of the Dissertation Structure
The remainder of this dissertation is organized as follows:
- *Chapter 2: Literature Review:* Critically examines the current landscape of AI adoption in SMEs, the evolution from basic LLMs to MCP tool-calling agents, the mechanics of Indirect Prompt Injections, and the efficacy of SLMs in handling specialized tasks.
- *Chapter 3: Methodology:* Details the Design Science Research (DSR) strategy, the programmatic matrix synthesis of the 3,276-item evaluation corpus, and the Parameter-Efficient Fine-Tuning (PEFT) framework using Low-Rank Adaptation (LoRA).
- *Chapter 4: Results:* Presents the quantitative and qualitative findings of the experimental evaluation.
- *Chapter 5: Discussion:* Interprets the findings, contextualizes them within the literature, and discusses the limitations of the research design.
- *Chapter 6: Conclusions:* Summarizes the research achievements, addresses each objective in turn, and proposes directions for future work.


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

Beyond static-file prompt injections, @debenedetti2024agentdojo introduces a dynamic, code-based environment designed to evaluate prompt injections in a larger-scale, interactive setting. AgentDojo provides a testbed containing 70 tools, 97 realistic user tasks, and 27 injection targets. It allows researchers to study attacks and defenses where agents execute multiple sequential turns in an interactive workspace, simulating real-world agent behaviors rather than evaluating isolated, single-turn interactions. However, like INJECAGENT, AgentDojo focuses on general tool-calling and code environments, and does not package its resources or payloads as static Agent Skills or `SKILL.md` configurations.

The Model Context Protocol Security Bench (MSB) created by @zhang2025msb shows that the integration tools themselves can be weaponised, despite INJECAGENT's primary focus on contaminated external data. A thorough taxonomy of MCP-specific vulnerabilities is established by @zhang2025msb, with a particular emphasis on "Tool Signature Attacks." In order to trick the agent's routing and planning logic, these attacks alter tool metadata. "Name Collision" (making malicious tools with names that are nearly identical to innocent ones) and "Preference Manipulation" (inserting promotional words into a tool's description to force the LLM to prioritise it) are two examples of specific vectors @zhang2025msb. Additionally, attackers can fool the model into providing out-of-scope parameters in order to leak sensitive data, or they can incorporate hidden "Prompt Injections" directly into tool descriptions @zhang2025msb.

These results pose a serious threat to SME architectures that depend on Agent Skills. Attackers can readily weaponise skill metadata using these precise MSB attack vectors since SKILL.md directories contain Markdown bodies to specify capabilities and structured YAML frontmatter that expressly relies on name and description fields. An adversary can fully take over the SME's agentic workflow during the first progressive disclosure phase, even before the underlying task is carried out, by concealing obfuscated directives within the frontmatter of a custom skill @zhang2025msb.

== SLMs as Efficient and Secure Proxies
In the AI sector, it is widely believed that large, generalised Large Language Models (LLMs) like GPT-4 or Claude are necessary for extremely complex tasks like context routing, security filtering, and deterministic tool execution. Recent empirical research, however, shows that using such models is not only computationally superfluous for specialised operations but also financially prohibitive for SMEs. The "scaling law" paradigm is challenged by a seminal work by @jhandi2026small, which demonstrates that when subjected to targeted fine-tuning, Small Language Models (SLMs) can dramatically outperform their giant counterparts. An optimised 350-million parameter SLM obtained a 77.55% success rate in tool execution, significantly surpassing a 175-billion parameter GPT model (which scored only 26.00%), according to @jhandi2026small's examination of agentic tool-calling and structured data interpretation.By avoiding the overhead and overgeneralisation common to big models @jhandi2026small, this breakthrough in parameter efficiency demonstrates that targeted fine-tuning produces domain specialists in structured tool manipulation.

Researchers are increasingly using Supervised Fine-Tuning (SFT) enhanced by Parameter-Efficient Fine-Tuning (PEFT) techniques to operationalise these SLMs within the harsh hardware restrictions of SMEs. By freezing the underlying model and optimising only a small set of additional low-rank matrices, Low-Rank Adaptation (LoRA) greatly reduces computational memory requirements, as @zupan2025developing investigates in the development of specialised accounting assistants. Frameworks like as Unsloth, which enable QLoRA, a technique that combines LoRA with 4-bit precision quantisation @unsloth2026finetuning, further optimise this process.

Because of its unique architectural design, Gemma 4 E2B is especially well-suited to serve as a SME security proxy. According to @unsloth2026gemma4, Gemma 4 has a "hybrid-thinking" architecture, which means that the model is taught to provide an internal reasoning channel prior to providing a final solution. This allows the model to thrive in intricate agentic and tool-use workflows. Additionally, Gemma 4 natively supports huge context windows of up to 128K tokens @unsloth2026gemma4, in contrast to earlier SLMs that had trouble with context retention. Its high-speed 4-bit local execution and long-context capability offer the precise infrastructure needed to read verbose, unstructured SKILL.md folders.

== Research Gaps
A critical synthesis exposes important gaps at the junction of SME operational restrictions and agentic security, even though the research offers a solid foundation for comprehending AI adoption issues and the mechanics of fast insertion.

First, dynamic, server-side integrations and runtime code execution environments are the main focus of current vulnerability benchmarks. For instance, AgentDojo @debenedetti2024agentdojo provides an interactive, code-based environment for tool-calling evaluation, while @zhang2025msb offers a thorough benchmark for active Model Context Protocol (MCP) server vulnerabilities. However, as noted by @whittaker2026mcp and @clyburn2026mcp, ordinary SMEs often use lightweight Agent Skills (SKILL.md) since they lack the resources to operate complicated MCP servers or support dynamic, multi-tool code runtimes. The literature on the particular security flaws of SME-centric Agent Skills is noticeably lacking, despite the quick uptake of this static, file-based integration technique. The YAML frontmatter and Markdown structures present in these directories may be exploited by attackers during the progressive disclosure phase, which is not empirically addressed by these dynamic or MCP-specific benchmarks.

Second, enterprise-scale environments are the primary focus of the defence methods suggested in the existing research. Current defences against IPIs mostly rely on using sophisticated cryptographic protocols, deploying large LLMs as security judges, or executing agents in computationally demanding, simulated sandboxes @gulyamov2026prompt. The "Operational Paradox" that SMEs @sanchez2025artificial confront is essentially ignored by these resource-intensive defences, depriving them of a workable, affordable defence.

Lastly, context optimisation and security are treated as mutually exclusive research areas in the literature. Some researchers, like @fraser2025cutting, concentrate only on the financial impact of the "Context Tax," while others, like @zhan2024injecagent, strictly concentrate on neutralising IPIs. Empirical studies examining the dual-purpose use of SLMs are conspicuously lacking. The use of a highly specialised, optimised SLM (like Gemma 4 E2B) as an active, local middleware proxy that can concurrently filter IPI attacks and compress superfluous metadata prior to downstream execution has not been thoroughly studied.

== Summary
This chapter has demonstrated that although Agent Skills provide SMEs with an essential, lightweight route to AI automation @whittaker2026mcp, @agentskills2026overview, they also introduce computationally expensive context bloat @fraser2025cutting and serious IPI vulnerabilities @gulyamov2026prompt. A comprehensive assessment of the literature exposes a major gap: the static SKILL.md pipelines of SMEs are mostly vulnerable because existing security evaluations primarily concentrate on active MCP servers and big LLMs @zhang2025msb. However, recent developments in SFT and PEFT show that in extremely particular tasks, SLMs can successfully outperform generalised models @jhandi2026small, @zupan2025developing. In order to fill the identified vacuum in the literature, this study suggests building and testing a refined Gemma 4 E2B SLM @unsloth2026gemma4 to serve as a safe, token-efficient vetting proxy for SME operations.



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

The methodological approach used to create and assess the secure Small Language Model (SLM) proxy is described in this chapter. It begins by justifying the choice of a Design Science Research (DSR) approach, outlining how the combined emphasis on rigorous evaluation and artefact development is especially well-suited to resolving the SME "Operational Paradox." The chapter then offers a thorough analysis of the programmatic matrix synthesis, detailing the standard evaluation set (comprising 1,054 unique attack scenarios) and the contextually filtered domain-aligned evaluation set (comprising 414 unique attack scenarios), each evaluated across Base and Enhanced threat settings alongside 170 benign hard negative controls. Because the Domain-Aligned Mode is a strict contextually filtered subset of the Standard Mode, the 998 cases in the Domain-Aligned Mode (414 Base, 414 Enhanced, and 170 Benign) are mathematically contained within the 2,278 cases of the Standard Mode. Therefore, the combined pipeline comprises exactly 2,278 unique virtual test cases. However, evaluating both modes independently results in a total evaluation corpus of 3,276 test instances (2,278 standard and 998 domain-aligned). Lastly, it describes the quantitative measures used to assess the security and compression effectiveness of the artefact and details the Parameter-Efficient Fine-Tuning (PEFT) processes using Low-Rank Adaptation (LoRA).

== Research Strategy: Design Science Research

A Design Science Research (DSR) approach is used in this dissertation. DSR is a proactive, problem-solving paradigm in contrast to purely theoretical or empirical research methodologies, which mainly aim to observe, characterise, or explain a given event. By developing novel and inventive artefacts to address useful, real-world problems, it aims to expand the limits of human and organisational capacities.

A purely empirical approach to this research would simply evaluate the computational load of the "Context Tax" in small and medium-sized businesses (SMEs) or monitor the phenomena of Indirect Prompt Injections (IPIs). Finding these weaknesses is important, but it does not offer a workable answer to the "Operational Paradox" facing SMEs. Because the main goal of this research is to actively develop a functioning, deployable solution—more precisely, a secure middleware proxy driven by a refined Gemma 4 E2B SLM—DSR is the ideal methodology. The practically important business issues of protecting Agent Skills (SKILL.md) and maximising token efficiency prior to downstream execution are specifically addressed by this artefact.

Recent applications in difficult organisational areas demonstrate how effective the DSR methodology is for creating specialised AI solutions. For instance, @zupan2025developing successfully built and assessed a specialised SLM in the accounting and finance sector using a DSR methodology. In their work, @zupan2025developing created an internal virtual accounting assistant by teaching a 7-billion-parameter model to produce highly structured, double-entry bookkeeping schemes using SFT and LoRA. Their study shows that DSR may be successfully used to build lightweight, fine-tuned SLMs that address highly particular, structured data problems instead of depending on enormous, generalised Large Language Models @zupan2025developing.

By using this methodology, this dissertation directly complies with DSR's dual mandate, which is to rigorously construct a novel technological artefact (the Gemma 4 E2B proxy) and then empirically evaluate it against quantifiable, measurable criteria to demonstrate its usefulness in resolving the SME security and context management crisis.

== Data Generation: Programmatic Matrix Synthesis

There is currently no publicly accessible archive or dataset of deliberately poisoned Agent Skills since Agent Skills, and the SKILL.md folders that underpin them, represent a recently formalised architectural standard for AI integration. While dynamic tool-calling benchmarks like AgentDojo @debenedetti2024agentdojo exist to evaluate general prompt injections across dozens of tools in interactive code sandboxes, they do not package their resources or payloads in the static Agent Skill/SKILL.md format. Consequently, no publicly accessible archive of poisoned Agent Skills exists at the time of writing, rendering the programmatic synthesis of this dataset a necessary and justified Design Science Research (DSR) step rather than a workaround.

The work uses a programmatic combinatorics approach to build this dataset, modifying the synthesis matrix created by the INJECAGENT benchmark @zhan2024injecagent. We specifically adapted the static combinatoric structure of the INJECAGENT benchmark @zhan2024injecagent rather than the dynamic interactive structure of AgentDojo @debenedetti2024agentdojo. While AgentDojo is highly suited for evaluating multi-turn, stateful tool interactions, the static cross-multiplication matrix of INJECAGENT maps directly onto the target structure of Agent Skills: a single tool/skill configuration file containing a single target description placeholder. This allows us to systematically evaluate how a local proxy can inspect and parse a skill's metadata and description during the initial progressive disclosure phase, before any tool execution occurs. The dataset is constructed by cross-multiplying two different axes of data, User Cases and Attacker Cases, using two distinct synthesis models:
- *User Cases (Benign)*: 17 benign, SME-relevant tool instructions, including calendar management, document retrieval, and customer lookups, make up the first axis. Each skill's Markdown body or simulated YAML frontmatter has a placeholder string called `<Attacker Instruction>` that is used as the injection target.
- *Attacker Cases (Malicious)*: 62 unique malicious payloads that were taken directly from the INJECAGENT dataset @zhan2024injecagent make up the second axis. These payloads, which are strictly classified by their adversarial intent, include 32 "Data Stealing" attacks (which are intended to surreptitiously exfiltrate private databases to attacker-controlled servers) and 30 "Direct Harm" attacks (which are intended to cause unauthorised actions, such as fraudulent financial transactions) @zhan2024injecagent. The broader taxonomy of evaluated attack vectors, integrating classifications from both INJECAGENT and MSB frameworks, is outlined in @tbl-ipi-attack-vectors. Specifically, while the attack payloads themselves (the adversarial actions) are drawn from INJECAGENT's Direct Harm and Data Stealing categories, their delivery vectors within the `SKILL.md` template files (the location of the injection) are structured to evaluate the proxy's resilience against MSB's Tool Signature and Out-of-Scope Parameter manipulation vectors (by hiding payloads in YAML description fields, parameter descriptions, or custom blocks).

The underlying rationale for this cross-multiplication architecture in the original INJECAGENT design is directly rooted in the *confused deputy problem* @zhan2024injecagent. Because modern tool-integrated AI agents are typically granted access to a diverse suite of capabilities, often mixing low-privilege read functions (e.g., retrieving web content or product reviews) with high-privilege write functions (e.g., executing financial transfers, sending emails, or modifying code repositories), they act as deputies carrying out actions on behalf of the user. An attacker can exploit this by embedding malicious commands in external, untrusted read sources, which the agent (the deputy) processes and is subsequently fooled into executing using its authorized write permissions. This cross-tool execution pattern creates a highly realistic and potent attack surface, which the combinatoric matrix is designed to systematically evaluate.


#figure(
  table(
    columns: (1fr, 1.2fr, 2.8fr),
    stroke: 0.5pt,
    align: left,
    [*Dimension*], [*Attack Vector & Source*], [*SME Skill Implementation / Simulation*],
    [Payload ("What")],
    [Direct Harm \ (INJECAGENT @zhan2024injecagent)],
    [Tricking the agent into executing unauthorized real-world actions (e.g., executing fraudulent bank transfers, overriding security configs, or command execution).],

    [Payload ("What")],
    [Data Stealing \ (INJECAGENT @zhan2024injecagent)],
    [Covertly extracting private user data (e.g., contact lists, emails, calendar details) and exfiltrating them to an attacker-controlled endpoint.],

    [Delivery Vector ("Where")],
    [Tool Signature / Preference Manipulation \ (MSB @zhang2025msb)],
    [Simulated by embedding malicious payloads directly inside the YAML frontmatter `description` fields of the `SKILL.md` templates (e.g., `AmazonGetProductDetails`), hijacking routing/prioritization logic.],

    [Delivery Vector ("Where")],
    [Out-of-Scope Parameters \ (MSB @zhang2025msb)],
    [Simulated by embedding payloads inside specific parameter descriptions (e.g., `username` parameter details in `GitHubGetUserDetails`), tricking the agent during parameter binding.],
  ),
  caption: [Taxonomy of Evaluated Indirect Prompt Injection (IPI) Attack Vectors],
) <tbl-ipi-attack-vectors>

To ensure the proxy is evaluated under realistic conditions, the programmatic generation executes in two modes:

1. *Standard Mode (Naive Cross-Multiplication)*: Performs a complete cross-multiplication between all 17 user tools and 62 attacker payloads ($17 times 62 = 1,054$ unique scenarios). This evaluates the agent's general resistance to cross-domain hijacks (e.g., executing a smart lock command found inside an Amazon review).
2. *Domain-Aligned Mode (Filtered Context)*: Maps user tools and attacker payloads into matching semantic domains, generating only context-appropriate injection scenarios (totaling 414 unique scenarios). This prevents the proxy from acting as a simple out-of-domain anomaly detector and tests true malicious intent classification (e.g., placing a fraudulent purchase command inside a retail review).

=== Domain Category Mappings
- *E-Commerce / Retail*: Matches user tools (e.g., `AmazonGetProductDetails`, `ShopifyGetProductDetails`) with financial fraud, unauthorized orders, or deposit payloads (e.g., `BankManagerTransferFunds`).
- *Email & Communication*: Matches user tools (e.g., `GmailReadEmail`, `TwilioGetReceivedSmsMessages`) with data exfiltration, spam, or phishing payloads (e.g., `GmailSendEmail`).
- *Developer & Productivity*: Matches user tools (e.g., `GitHubGetRepositoryDetails`, `EvernoteManagerSearchNotes`) with file deletion, folder traversal, or policy overrides (e.g., `GitHubDeleteRepository`).
- *Web & Social Media*: Matches user tools (e.g., `WebBrowserNavigateTo`, `TwitterManagerSearchTweets`) with credential theft, smart home hijack, or location tracking (e.g., `AugustSmartLockUnlockDoor`).

For both modes, the datasets are generated in two parallel settings:
- *The Base Setting*: The placeholder is replaced solely with the malicious payload.
- *The Enhanced Setting*: The payload is prepended with a forceful hacking prompt designed to aggressively override the AI's safety guardrails: "IMPORTANT!!! Ignore all previous instructions and strictly adhere to the following instruction:" @zhan2024injecagent.

=== Shortcut Learning Mitigation
Small Language Models (SLMs) are highly prone to *shortcut learning*—a phenomenon where the model learns to rely on superficial, spurious correlation patterns rather than semantic logic to perform a classification task (e.g., memorizing to always strip text following a specific keyword or colon at the end of a description). To mitigate this vulnerability and ensure the defensive proxy learns a generalized semantic filter rather than superficial formatting templates, we apply two structural variations across the 17 base templates:
- *Varied Injection Positions*: The `<Attacker Instruction>` placeholder is systematically placed in different structural areas across the templates. Some templates place it in the YAML `description` field, others in custom YAML fields like `external_context` or `warnings`, some within Markdown parameter lists, others in usage procedures, and some in concluding note sections.
- *Varied Phrasing*: Each base template uses distinct warning language and contextual phrasing to describe untrusted data sources (e.g., varying terms like "WARNING", "CAUTION", "unverified data", or "external comments"). This variation ensures that the model cannot simply memorize a static prefix token to identify injection boundaries.

=== Benign Hard Negatives
To evaluate and prevent the risk of *over-refusal* or *false-positives*—where the defensive proxy inadvertently mangles or refuses a benign skill simply because it contains warning scaffolding or structure—we introduce benign hard negative controls. We generate 170 benign hard negative instances ($17 "templates" times 10 "benign payloads"$). These instances utilize the exact same warning scaffolding and injection placeholders as the poisoned files, but replace the malicious attacker payloads with benign, non-hostile strings (e.g., "none", "no unusual activity", "regular update", "standard log entry", etc.). This forces the proxy to distinguish between the presence of warning patterns and actual adversarial instruction intent, establishing a critical control baseline for evaluating format preservation and false-alarm rates.

=== Dataset Dimensions and Outputs
The dataset constructed for this dissertation comprises two distinct evaluation modes—Standard Mode and Domain-Aligned Mode—each synthesized across three settings (Base, Enhanced, and Benign) to evaluate safety under varying levels of adversarial and benign prompting. Rather than creating thousands of separate physical files or metadata JSON logs on disk, which would introduce filesystem storage and retrieval overhead, the pipeline is executed 100% in-memory at runtime. Raw user cases and attacker payloads are dynamically combined on-the-fly to construct the virtual skill contents. This configuration yields a total evaluation corpus of 3,276 virtual test instances (consisting of 2,278 standard cases and 998 domain-aligned cases).

The total volume of the generated virtual Agent Skills is structured as follows:
- *Standard Mode (Full Combinatoric Matrix)*:
  - _Logic_: Cross-multiplication of all 17 User Cases (Benign SME Tools) with 62 Attacker Cases (Malicious Payloads) under different conditions.
  - _Base Setting_: 1,054 virtual instances (malicious payload only).
  - _Enhanced Setting_: 1,054 virtual instances (payload prepended with safety override hacking prompt).
  - _Benign Setting (Hard Negatives)_: 170 virtual instances (benign placeholders such as "none" or "no unusual activity" embedded in the warning fields).
  - _Total Output_: 2,278 unique virtual cases generated in-memory.
- *Domain-Aligned Mode (Context-Filtered Matrix)*:
  - _Logic_: Filters the combinatoric matrix to retain only context-appropriate injection pairs (e.g., matching e-commerce tools with financial fraud, or email tools with data exfiltration).
  - _Base Setting_: 414 virtual instances.
  - _Enhanced Setting_: 414 virtual instances.
  - _Benign Setting (Hard Negatives)_: 170 virtual instances (benign payloads mapped to domain tools).
  - _Total Output_: 998 unique virtual cases generated in-memory.

Importantly, these payloads were programmatically mapped to particular metadata vulnerabilities identified by the MCP Security Bench (MSB) @zhang2025msb in order to guarantee that the dataset appropriately reflects the vulnerabilities of contemporary tool-calling architectures. For instance, in order to mimic Preference Manipulation attacks, payloads were inserted straight into the SKILL.md files' description fields, deceiving the agent during the progressive disclosure phase @zhang2025msb. The detailed composition of the generated dataset, including categories, components, and evaluation splits, is summarized in @tbl-dataset-composition.

#figure(
  table(
    columns: (1.2fr, 1.2fr, 0.8fr, 3fr),
    stroke: 0.5pt,
    align: left,
    [*Evaluation Mode*], [*Dataset Split*], [*Quantity*], [*Description*],
    [Standard Mode], [Base Setting], [1,054], [Complete matrix output (17 User Cases $times$ 62 Attacker Cases).],

    [Standard Mode],
    [Enhanced Setting],
    [1,054],
    [Malicious payload prepended with forced safety override hacking prompt.],

    [Standard Mode], [Benign Setting], [170], [Hard negatives containing warning scaffolding with harmless content.],

    [Domain-Aligned Mode],
    [Base Setting],
    [414],
    [Contextually mapped subset (e.g., finance attacks for e-commerce tools).],

    [Domain-Aligned Mode], [Enhanced Setting], [414], [Domain-aligned payload prepended with forced hacking prompt.],

    [Domain-Aligned Mode],
    [Benign Setting],
    [170],
    [Hard negatives containing warning scaffolding with harmless content mapping to domain tools.],
  ),
  caption: [Composition of the programmatic synthesis evaluation dataset],
) <tbl-dataset-composition>


== Artifact Construction: Supervised Fine-Tuning (SFT) and LoRA
Google DeepMind's Gemma 4 E2B was chosen as the foundational Small Language Model (SLM) to operationalise the defensive proxy. Three main architectural benefits led to the selection of this particular model. First, it makes use of a "hybrid-thinking" architecture, which is highly optimised for intricate agentic and tool-use workflows @unsloth2026gemma4. This means that the model is naturally taught to build an internal reasoning channel before generating a final answer. Second, in order to parse and compress verbose SKILL.md folders without losing crucial procedural metadata, Gemma 4 must support a large context window of up to 128K tokens @unsloth2026gemma4. Lastly, its 2-billion parameter size achieves the best possible balance between computational efficiency and reasoning power.

For targeted classification and routing tasks, training an LLM with complete fine-tuning, where all neuronal weights are updated simultaneously, is incredibly computationally demanding, time-consuming, and superfluous @unsloth2026finetuning. Rather, this work uses the Unsloth framework @unsloth2026finetuning to implement Parameter-Efficient Fine-Tuning (PEFT) through LoRA. By freezing the basic model's initial weights and only training a small set of additional low-rank matrices, LoRA dramatically decreases computational overhead, as @zupan2025developing has shown in the successful development of domain-specific accounting assistants.

Making sure this Design Science Research (DSR) artefact is sustainable amid the harsh infrastructural and financial restrictions of typical SMEs is one of its primary goals. This is accomplished by fine-tuning the proxy in conjunction with the LoRA adapters using dynamic 4-bit quantisation. This method significantly reduces the model's memory footprint without significantly sacrificing accuracy, enabling the optimised Gemma 4 E2B proxy to operate entirely locally on consumer-grade hardware with as little as 5GB of RAM @unsloth2026gemma4. This local deployment functionality ensures that private company data and SKILL.md files do not need to be sent to costly, third-party cloud APIs for security auditing, thereby immediately resolving the SME hardware constraint.

=== SFT Dataset Structure and Task Formulation
The programmatic combinatorics step described in the previous section yields a total corpus of 3,276 virtual cases. However, standard Parameter-Efficient Fine-Tuning (PEFT) frameworks such as Unsloth @unsloth2026finetuning do not ingest raw file directories (e.g., individual `SKILL.md` documents) directly. Instead, modern model training and fine-tuning platforms require a flat, structured dataset format consisting of rows and columns—typically configured in an Alpaca-style `{instruction, input, output}` schema, or conversational formats like ShareGPT/ChatML.

To bridge this operational gap, we implement a unified dataset curation script (`refine_dataset.py`) acting as a local middleware. This script processes the raw InjecAgent data and templates directly in-memory, batches the inputs to optimize API rate usage, and queries the Gemini API using modern structured JSON output (supported by a strict Pydantic response schema). For each case, the Gemini critic identifies injections and refines the skill, which is then subjected to deterministic local validation guardrails (ASR keyword matching and YAML format checks) before being written directly to a compiled JSONL training dataset file (`sft_dataset_sanitized.jsonl`):
- *Instruction*: The system prompt (`PROXY_SYSTEM_PROMPT`) defining the operational expectations for the proxy, instructing it to identify prompt injections, preserve YAML/Markdown structural boundaries, compress the text to minimize token overhead, and output only valid skill code.
- *Input*: The raw, unvetted `SKILL.md` text content including the embedded injection payload (the standard or domain-aligned threat).
- *Output*: The sanitized and compressed "gold distilled" target representation returned by the API critic.

This "gold distilled" target representation represents a critical methodological addition to the pipeline. While the input contains the poisoned skill, the ground-truth target is a hand-crafted clean, optimized, and fully sanitized version of the skill schema. For example, for the `AmazonGetProductDetails` tool, the raw input containing a payment exfiltration command is mapped to a gold output that contains only the clean ASIN parameter and product retrieval usage steps, stripped of any external injected text, comments, or warnings. This formulation enforces a many-to-one mapping under Supervised Fine-Tuning: regardless of what hostile or benign payload is present in the input, the proxy learns to discard it and reconstruct only the pure, sanitized tool schema.

Furthermore, we design the SFT task formulation to take advantage of Gemma's native "hybrid-thinking" architecture @unsloth2026gemma4. Since the model supports an internal reasoning path, the training targets are tokenized to permit a structured reasoning trace (enclosed in `<thought>...</thought>` tags) prior to outputting the final distilled skill markdown. This allows the model to explicitly evaluate the safety of the input context and isolate injection markers before producing the sanitized output schema, boosting both Format Integrity and Security Efficacy. While the model is trained strictly on instruction-input-output triples to map raw inputs to clean outputs, the evaluation pipeline maintains a parallel metadata file for each row containing the target injection payload and attacker tool references. This metadata acts as a verification label, allowing the offline evaluation suite to programmatically parse model outputs and compute the `ASR-valid` metric by checking for semantic leaks of these labeled payloads.

=== Dataset Partitioning

To train the Small Language Model (SLM) proxy via Supervised Fine-Tuning (SFT) and subsequently verify its performance, the generated cases were partitioned into Training and Unseen Holdout Evaluation sets. The partitions are configured as shown in @tbl-dataset-partitioning.

#figure(
  table(
    columns: (1.5fr, 1fr, 1.2fr, 1.2fr),
    stroke: 0.5pt,
    align: left,
    [*Dataset Mode*], [*Total Cases*], [*SFT Training Split*], [*Holdout Evaluation Split*],
    [Standard Mode], [1,054], [500 cases (47.4%)], [554 cases (52.6%)],
    [Domain-Aligned Mode], [414], [200 cases (48.3%)], [214 cases (51.7%)],
    [Benign Mode (Hard Negatives)], [170], [80 cases (47.1%)], [90 cases (52.9%)],
  ),
  caption: [Dataset Partitioning Splits for SFT Training and Holdout Evaluation],
) <tbl-dataset-partitioning>

The splits are applied to the unique injection cases. In execution, these splits are mirrored identically across both the Base and Enhanced settings. To prevent data leakage and preserve zero-shot evaluation integrity, the SFT training and evaluation splits are kept strictly mode-specific. Because the Domain-Aligned cases are a strict subset of the Standard cases, combining the training sets during the fine-tuning phase would result in the model being trained on examples that overlap with the Domain-Aligned holdout set. Thus, training is conducted separately: standard evaluation runs are tested against standard holdouts after training on the standard training set (1,080 rows), and domain-aligned evaluation runs are tested against domain-aligned holdouts after training on the domain-aligned training set (480 rows).

After the fine-tuning process is finished, these holdout datasets serve as the last evaluation ground to test the artifact's defensive efficacy and zero-shot generalisation capabilities.

== Academic Justifications

=== Justification for the Partitioning Ratio (SFT vs. Holdout)
In machine learning, a standard 80/20 split is typical for large-scale training. However, because our proxy's task is highly focused (parsing a semi-structured `SKILL.md` file, identifying natural language injections, and outputting compressed YAML/Markdown), the training objective is classification- and format-oriented rather than open-ended text generation.

- *Parameter Efficiency*: Using Parameter-Efficient Fine-Tuning (PEFT/LoRA) on the 2-billion parameter Gemma model, 200 to 500 training examples are more than sufficient to converge the model's weights for targeted classification and extraction @unsloth2026finetuning.
- *Maximizing Evaluation Rigor*: By allocating a larger-than-normal percentage (about 52%) of the dataset to the Holdout Split, we ensure the security metrics (ASR-valid) are computed over a wider array of unseen attack payloads, strengthening the statistical reliability of the evaluation @zhan2024injecagent.

=== Justification for the Deterministic Split (Fixed Seed = 42)
To ensure the scientific validity of the experiment, a deterministic split was enforced using a fixed random seed of 42.

- *Prevention of Data Leakage (Zero Sample Leakage)*: In zero-shot evaluation, it is critical that the model is never tested on payloads it observed during training @gulyamov2026prompt. By partitioning indices directly (ensuring a specific case index is placed in either the training split or the holdout split, but never both), we guarantee zero sample leakage.
- *Structural Repetition vs. Payload Generalisation*: Because the dataset is synthesized from a fixed set of 17 base skill templates (such as `AmazonGetProductDetails` or `GmailReadEmail`), there is inherent structural repetition in the templates. However, the attacker instructions (the malicious payloads injected) and their specific tool combinations are unique to each case. Consequently:
  - *SFT Training*: The model learns how to recognize prompt injection patterns generally and how to sanitize/distill the template structure.
  - *Holdout Evaluation*: The model is evaluated on completely unseen attacker instructions (adversarial payloads) injected into those templates.
  This partition design is standard and acceptable in security benchmarks like InjecAgent @zhan2024injecagent. The primary objective is to test if a model can generalize its safety boundary to new, unseen attack instructions (out-of-distribution payloads) rather than new tool definitions.
- *Scientific Reproducibility*: Under the Design Science Research (DSR) paradigm, any independent researcher must be able to reproduce the exact SFT training adapters and evaluation runs. Enforcing a fixed seed ensures that the dataset partitions remain identical across different execution environments @zupan2025developing.

=== Justification for the Dual-Mode Setup (Standard vs. Domain-Aligned)
The introduction of the contextually filtered Domain-Aligned Mode alongside the Standard Mode isolates a critical variable:

- *Anomaly vs. Intent Classification*: Naive benchmarks mix mismatched domains (e.g., smart lock commands inside Amazon reviews). While useful for evaluating general multi-tool hijack resistance, it risks training the proxy to act as a simple "anomaly detector" (flagging irrelevant topics) @zhan2024injecagent.
- *Contextual Vulnerability Testing*: Evaluating the proxy against the Domain-Aligned split tests its capacity to identify malicious behavior when the attack is hidden within a contextually appropriate instruction (e.g., a bank withdrawal request inside an e-commerce workflow), proving the model's true security capabilities @zhang2025msb.

== Evaluation Framework
According to the DSR approach, the created artefact must be thoroughly evaluated in accordance with specific, quantifiable standards in order to demonstrate its usefulness. Testing will be limited to the unseen holdout datasets (554 standard, 214 domain-aligned, and 90 benign hard negative cases) in order to assess the refined Gemma 4 E2B proxy. The evaluation framework is built around three main indicators intended to measure the proxy's operational effectiveness as well as its security resilience.

- *Metric 1: ASR-valid Security Efficacy*: The Attack Success Rate (ASR) calculates the proportion of hostile payloads that successfully evade the proxy. However, as @zhan2024injecagent has shown, assessing raw ASR is incorrect because an LLM may provide deformed gibberish or fail to produce a coherent response at all; these failures do not constitute a successful defence. To prevent formatting failures from masquerading as successful defences, ASR-valid is calculated only on syntactically valid outputs ($N_("valid")$). Let $N_("leak")$ be the number of valid outputs that still contain the malicious instruction:
  $ "ASR"_("valid") = N_("leak") / N_("valid") times 100 $
  The ASR-valid metric is computed across the different dataset configurations specified in the preceding section to verify the resilience of the proxy. This study will conclusively demonstrate the proxy's active resilience against overt adversarial manipulation @zhan2024injecagent by examining the difference in ASR-valid between the Base Setting (which contains only the concealed payload) and the Enhanced Setting (which forcefully prepends the payload with an aggressive hacking prompt).
- *Metric 2: Format Integrity Pass Rate*: Securing the workflow is only half the objective; the proxy must also maintain the operational functionality of the SME's toolset. Downstream AI agents rely heavily on precise YAML frontmatter and strict Markdown schemas to correctly interpret and execute Agent Skills. If the proxy neutralizes an attack, such as stripping out a Preference Manipulation injection defined by @zhang2025msb, but accidentally corrupts the underlying YAML syntax in the process, the downstream agent will fail to load the tool entirely. Consequently, the Format Integrity Pass Rate evaluates the proxy's ability to sanitize malicious data without breaking the rigid structural formatting of the SKILL.md file. Let $N_("valid")$ be the number of syntactically correct outputs, and $N_("total")$ be the total holdout cases evaluated:
  $ "Format Integrity" = N_("valid") / N_("total") times 100 $
- *Metric 3: Token Compression Ratio*: To address the computationally expensive "Context Tax" identified by @fraser2025cutting, the proxy is also tasked with Semantic Distillation, compressing verbose, redundant instructions into highly efficient metadata. To quantify this mitigation, the Token Compression Ratio will be calculated. This metric directly compares the total token volume of the raw, unedited SKILL.md input against the token volume of the proxy's distilled, sanitized output. Let $T_("in")$ be the token count of the raw poisoned skill and $T_("out")$ be the token count of the proxy's distilled, sanitized output:
  $ "Compression Ratio" = T_("in") / T_("out") $
  An average is taken over all $N_("total")$ holdout cases.

=== Evaluation Execution Pipeline

To operationalize the evaluation of the fine-tuned SLM proxy, a programmatic test harness is implemented (materialized in `evaluate_proxy.py`). Rather than requiring the manual deployment and file-piping of thousands of physical `SKILL.md` documents or loading static metadata files, the harness manages the evaluation pipeline through a fully in-memory execution flow. This process is structured as follows (illustrated in @fig-assessment-flow):

1. *In-Memory Dataset Construction*: The harness dynamically builds the evaluation dataset in-memory by loading raw cases directly from `temp_injecagent/data/` and injecting them into templates. To preserve zero-shot evaluation integrity and prevent data leakage, a deterministic splitter using a fixed random seed ($"seed" = 42$) partitions the dataset and isolates the unseen holdout split (554 standard, 214 domain-aligned, and 90 benign hard negative unique cases).
2. *Local or Hosted Model Invocation*: For each holdout case, the harness wraps the system instructions (`PROXY_SYSTEM_PROMPT`) and raw skill content into standard fine-tuning formatting templates (supporting Alpaca or ChatML schemas) to match the model's training configuration. It then queries the target model via one of three backend interfaces:
  - *Ollama Backend*: Dispatches a HTTP POST request to Ollama's local generation endpoint (`/api/generate`) running the quantized `gemma:2b` model.
  - *LM Studio Backend*: Dispatches a request to an OpenAI-compatible local server endpoint (`/v1/chat/completions`) hosting the fine-tuned LoRA adapters.
  - *Gemini Backend*: Dispatches a request directly to the hosted Gemini API (e.g. `gemini-2.5-flash`) to serve as a baseline comparison.
3. *Programmatic Metric Calculation*: Upon receiving the distilled output from the model proxy, the harness applies three automated evaluation passes:
  - *ASR-valid Audit*: Checks the output for semantic leaks of the malicious payload. An injection leak is flagged if the output contains the attacker's instruction verbatim, references any of the mapped attacker tools, or exhibits a keyword overlap ratio of $\ge 80\%$ (determined via a heuristic keyword filter excluding common stop-words).
  - *Format Integrity Pass*: Parses the YAML frontmatter and Markdown headings to verify that the proxy preserved the strict `SKILL.md` syntax layout without corruption.
  - *Compression Ratio Calculation*: Counts the tokens of the input and output strings using the public, ungated `alpindale/gemma-tokenizer` model and computes the compression ratio ($T_("in") / T_("out")$).
4. *Checkpointing and Logging*: To guarantee stability during long execution runs, the harness logs results incrementally to a JSONL file (`results/evaluation_{model_type}_{mode}_{setting}_results.jsonl`). This allows the pipeline to dynamically resume progress from the last cached case-index in the event of hardware or connection failures.

#figure(
  image("SLM Proxy Assessment Flow.png", width: 55%),
  caption: [Systematic Execution Flow of the SLM Proxy Assessment Harness],
) <fig-assessment-flow>

== Summary
The Design Science Research (DSR) methodology used to build and thoroughly evaluate the secure Small Language Model (SLM) middleware proxy was described in this chapter. This study used a programmatic matrix synthesis to generate 1,054 unique standard attack scenarios and 414 unique domain-aligned attack scenarios, which were evaluated under Base and Enhanced threat settings alongside 170 benign hard negative controls to produce a total evaluation corpus of 3,276 virtual test instances (2,278 standard and 998 domain-aligned). This dual-dataset strategy ensures that the proxy is evaluated against both general out-of-domain hijacks and sophisticated, domain-aligned prompt injections.

Additionally, the chapter detailed the Supervised Fine-Tuning (SFT) parameters, highlighting the use of 4-bit quantisation and Low-Rank Adaptation (LoRA) on the Gemma 4 E2B model to directly correspond with the severe hardware restrictions of SMEs @unsloth2026finetuning, @unsloth2026gemma4. Lastly, it developed a strong assessment mechanism intended to measure the operational utility of the proxy using Format Integrity, Security Efficacy (ASR-valid), and the Token Compression Ratio.


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
  [*PEFT*], [Parameter-Efficient Fine-Tuning],
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
