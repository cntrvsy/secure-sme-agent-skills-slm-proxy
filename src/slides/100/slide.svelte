<script lang="ts">
	import { Transition } from '@animotion/core'
</script>

<div class="hero min-h-[80vh] w-full max-w-7xl mx-auto px-4">
	<Transition visible class="w-full">
		<div class="card bg-base-200 border border-base-300 p-12 shadow-2xl flex flex-col items-center text-center relative overflow-hidden">
			<!-- Subtle background gradient glow -->
			<div class="absolute -top-40 -left-40 w-96 h-96 bg-primary/10 rounded-full blur-3xl"></div>
			<div class="absolute -bottom-40 -right-40 w-96 h-96 bg-secondary/10 rounded-full blur-3xl"></div>

			<!-- Institution Details -->
			<Transition delay={0.1} visible>
				<div class="badge badge-outline badge-primary px-4 py-3 uppercase tracking-widest text-xs font-semibold mb-6">
					Cardiff School of Technologies • Cardiff Metropolitan University
				</div>
			</Transition>

			<!-- Main Title -->
			<Transition delay={0.3} visible>
				<h1 class="text-4xl md:text-5xl font-extrabold tracking-tight leading-tight mb-6 bg-gradient-to-r from-primary via-secondary to-accent bg-clip-text text-transparent">
					Securing SME Agent Skills via Fine-Tuned SLM Proxies
				</h1>
			</Transition>

			<!-- Title Hook (TED Talk Style) -->
			<Transition delay={0.5} visible>
				<p class="text-lg md:text-xl text-base-content max-w-4xl mx-auto font-light leading-relaxed mb-10">
					A secure local Small Language Model (SLM) proxy protecting resource-constrained SMEs against Indirect Prompt Injection (IPI) attacks in tool-integrated agentic workflows
				</p>
			</Transition>

			<!-- Divider -->
			<div class="divider w-24 mx-auto mb-8 bg-gradient-to-r from-primary to-accent h-[2px]"></div>

			<!-- Metadata Grid -->
			<div class="grid grid-cols-1 md:grid-cols-2 gap-8 w-full max-w-2xl text-left mt-2">
				<Transition delay={0.7} visible>
					<div class="flex flex-col">
						<span class="text-xs uppercase text-base-content/50 tracking-wider font-semibold">Author</span>
						<span class="text-lg font-bold text-base-content">Benin Mukabanah</span>
						<span class="text-xs text-base-content/70">Masters Degree in Computing & IT</span>
					</div>
				</Transition>

				<Transition delay={0.9} visible>
					<div class="flex flex-col">
						<span class="text-xs uppercase text-base-content/50 tracking-wider font-semibold">Supervisor</span>
						<span class="text-lg font-bold text-base-content">Dr P Jenkins</span>
						<span class="text-xs text-slate-400">Technology Dissertation Core</span>
					</div>
				</Transition>
			</div>

			<!-- Interaction Prompt -->
			<div class="mt-12 text-xs text-base-content/40 tracking-wider font-mono">
				Press the right arrow key to begin the presentation
			</div>
		</div>
	</Transition>
</div>
