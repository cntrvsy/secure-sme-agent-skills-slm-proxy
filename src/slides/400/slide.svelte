<script lang="ts">
	import { Transition } from '@animotion/core'
</script>

<div class="flex flex-col items-center justify-center min-h-[85vh] w-full max-w-7xl mx-auto px-4 text-center">
	<Transition visible>
		<h2 class="text-4xl font-extrabold tracking-tight mb-2 text-primary">
			Assessment Harness Execution Flow
		</h2>
		<p class="text-slate-400 font-light mb-6 text-sm max-w-3xl mx-auto">
			The systematic execution flow of the SLM proxy assessment harness (Figure 3.1), managing the evaluation pipeline through an in-memory execution flow.
		</p>
	</Transition>

	<!-- Large Diagram Viewer -->
	<Transition delay={0.2} visible class="w-full flex justify-center">
		<div class="flex items-center justify-center w-full max-w-5xl h-[500px] relative">
			<img 
				class="max-h-[480px] max-w-full object-contain rounded-2xl border border-base-300 shadow-2xl relative z-10 p-2 bg-base-200/50" 
				src="/images/SLM_Proxy_Assessment_Flow.png" 
				alt="Systematic Execution Flow of the SLM Proxy Assessment Harness"
			/>
		</div>
	</Transition>
</div>
